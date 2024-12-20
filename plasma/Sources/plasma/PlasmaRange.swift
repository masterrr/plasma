//
//  PlasmaRange.swift
//  plasma
//
//  Created by Dmitrij Kurilo on 20/12/2024.
//

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
