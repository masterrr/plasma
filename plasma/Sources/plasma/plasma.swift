// plasma.swift

enum PlasmaRange: Int, Sendable {
    case criticalAbundance = 1
    case elevated = 2
    case normalZone = 3
    case optimalZone = 4
    case deficient = 5
    case criticalDeficiency = 6
    
    var isCritical: Bool {
        self == .criticalAbundance || self == .criticalDeficiency
    }
    
    var isAbnormal: Bool {
        self == .elevated || self == .deficient
    }
    
    var isNormal: Bool {
        self == .normalZone || self == .optimalZone
    }
}

struct PlasmaValue: Sendable {
    let biomarkerId: Int
    let value: Double
    let range: PlasmaRange?
}

struct PlasmaOutput: Sendable {
    let message: String
    let importance: Int
    let ruleId: Int
}

struct PlasmaRule: Sendable {
    let id: Int
    let biomarkerIds: Set<Int>
    let evaluate: @Sendable ([PlasmaValue]) -> Bool
    let message: String
    let importance: Int
}

enum BiomarkerId {
    static let glucose = 1
    static let alt = 28
    static let ast = 29
    static let hba1c = 33
}

final class PlasmaEngine {
    private let rules: [PlasmaRule]
    
    init(rules: [PlasmaRule]) {
        self.rules = rules
    }
    
    convenience init() {
        self.init(rules: [
            // Liver Function Rule
            PlasmaRule(
                id: 1,
                biomarkerIds: [BiomarkerId.alt, BiomarkerId.ast],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }
                },
                message: "Your liver enzyme levels require attention...",
                importance: 3
            ),
            
            // Diabetes Rule
            PlasmaRule(
                id: 2,
                biomarkerIds: [BiomarkerId.glucose, BiomarkerId.hba1c],
                evaluate: { values in
                    values.contains { value in
                        guard let range = value.range else { return false }
                        return range.isCritical
                    }
                },
                message: "Your glucose levels indicate possible diabetes...",
                importance: 3
            )
        ])
    }
    
    func process(_ values: [PlasmaValue]) -> [PlasmaOutput] {
        rules.compactMap { rule in
            let relevantValues = values.filter { rule.biomarkerIds.contains($0.biomarkerId) }
            guard relevantValues.count == rule.biomarkerIds.count else { return nil }
            
            return rule.evaluate(relevantValues) ?
                PlasmaOutput(
                    message: rule.message,
                    importance: rule.importance,
                    ruleId: rule.id
                ) : nil
        }
    }
}
