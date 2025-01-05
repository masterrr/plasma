//
//  Structs.swift
//  plasma
//
//  Created by Dmitrij Kurilo on 20/12/2024.
//

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

struct Reference: Sendable {
    let hyperlink: String
}

struct RuleAuthor: Sendable {
    let name: String
}

struct PlasmaRule: Sendable {
    let id: Int
    let references: [Reference]
    let authors: [RuleAuthor]
    let biomarkerIds: Set<Int>
    let evaluate: @Sendable ([PlasmaValue]) -> Bool
    let message: String
    let importance: Int
    
    // Full constructor with all parameters
    init(
        id: Int,
        references: [Reference],
        authors: [RuleAuthor],
        biomarkerIds: Set<Int>,
        evaluate: @escaping @Sendable ([PlasmaValue]) -> Bool,
        message: String,
        importance: Int
    ) {
        self.id = id
        self.references = references
        self.authors = authors
        self.biomarkerIds = biomarkerIds
        self.evaluate = evaluate
        self.message = message
        self.importance = importance
    }
    
    // Simplified constructor without references and authors
    init(
        id: Int,
        biomarkerIds: Set<Int>,
        evaluate: @escaping @Sendable ([PlasmaValue]) -> Bool,
        message: String,
        importance: Int
    ) {
        self.id = id
        self.references = []  // Empty array by default
        self.authors = []     // Empty array by default
        self.biomarkerIds = biomarkerIds
        self.evaluate = evaluate
        self.message = message
        self.importance = importance
    }
}
