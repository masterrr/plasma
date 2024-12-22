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

struct PlasmaRule: Sendable {
    let id: Int
    let biomarkerIds: Set<Int>
    let evaluate: @Sendable ([PlasmaValue]) -> Bool
    let message: String
    let importance: Int
}
