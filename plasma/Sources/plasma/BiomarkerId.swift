//
//  BiomarkerId.swift
//  plasma
//
//  Created by Dmitrij Kurilo on 20/12/2024.
//

enum MetaBiomarkerStaticEnum: Int, CaseIterable {
    case insulin = 0
    case glucose = 1
    case ldlCholesterol = 2
    case hdlCholesterol = 3
    case triglycerides = 4
    case highSensitivityCReactiveProtein = 5
    case homocysteine = 6
    case thyroidStimulatingHormone = 7
    case vitaminD25Hydroxy = 8
    case zinc = 9
    case ferritin = 10
    case prolactin = 11
    case fructosamine = 12
    case cPeptide = 13
    case insulinAutoantibodiesIgG = 14
    case antiIsletCellAntibodies = 15
    case calcium = 16
    case sodium = 17
    case potassium = 18
    case bicarbonate = 19
    case chloride = 20
    case creatinine = 21
    case phosphorus = 22
    case magnesium = 23
    case bloodUreaNitrogen = 24
    case cholesterol = 25
    case freeTriiodothyronine = 26
    case totalThyroxine = 27
    case alanineAminotransferase = 28
    case aspartateAminotransferase = 29
    case alkalinePhosphatase = 30
    case albumin = 31
    case bilirubinTotal = 32
    case glycatedHemoglobin = 33
    case redBloodCells = 34
    case hemoglobin = 35
    case hematocrit = 36
    case whiteBloodCells = 37
    case platelets = 38
    case vldlCholesterol = 39
    case oxLdlCholesterol = 40
    case apolipoproteinA1 = 41
    case apolipoproteinB = 42
    case leptin = 43
    case adiponectin = 44
    case interleukin6 = 45
    case fibrinogen = 46
    case erythrocyteSedimentationRate = 47
    case reticulocytes = 48
    case neutrophils = 49
    case lymphocytes = 50
    case monocytes = 51
    case eosinophils = 52
    case basophils = 53
    case plateletDistributionWidth = 54
    case meanPlateletVolume = 55
    case plateletcrit = 56
    case plateletLargeCellRatio = 57
    case haptaglobin = 58
    case alpha2Macroglobulin = 59
    case dDimer = 60
    case freeTestosterone = 61
    case totalTestosterone = 62
    case bioavailableTestosterone = 63
    case dihydrotestosterone = 64
    case dehydroepiandrosteroneSulfate = 65
    case androstendione = 66
    case luteinizingHormone = 67
    case follicleStimulatingHormone = 68
    case estradiol = 69
    case progesterone = 70
    case sexHormoneBindingGlobulin = 71
    case prostatePecificAntigenTotal = 72
    case antiMullerianHormone = 73
    case totalTriiodothyronine = 74
    case freeThyroxine = 75
    case reverseTriiodothyronine = 76
    case thyroglobulin = 77
    case thyroglobulinAntibody = 78
    case thyroidPeroxidaseAntibody = 79
    case thyroidStimulatingHormoneReceptorAntibody = 80
    case bilirubinDirect = 81
    case gammaGlutamyltransferase = 82
    case insulinLikeGrowthFactor1 = 83
    case cortisolMorning = 84
    case estimatedGlomerularFiltrationRateNonAfricanAmerican = 85
    case cystatinC = 86
    case uricAcid = 87
    case vitaminA = 88
    case vitaminE = 89
    case vitaminC = 90
    case vitaminB1 = 91
    case thiamineDiphosphateErythrocyte = 92
    case vitaminB6 = 93
    case vitaminB12 = 94
    case vitaminB12Active = 95
    case folate = 96
    case folateErythrocyte = 97
    case transferrin = 98
    case iron = 99
    case unsaturatedIronBindingCapacity = 100
    case redBloodCellDistributionWidthCV = 101
    case zincErythrocyte = 102
    case calciumIonized = 103
    case copper = 104
    case ceruloplasmin = 105
    case seleniumSerum = 106
    case iodine = 107
    case meanCorpuscularVolume = 108
    case meanCorpuscularHemoglobin = 109
    case meanCorpuscularHemoglobinConcentration = 110
    case redBloodCellDistributionWidthSD = 111
    case prostatePecificAntigenFree = 112
    case nonCeruloplasminBoundCopper = 113
    case neutrophilRange = 114
    case lymphocyteRange = 115
    case monocyteRange = 116
    case eosinophilRange = 117
    case basophilRange = 118
    case absoluteBandNeutrophils = 119
    case bandNeutrophilRange = 120
    case metamyelocyteRange = 121
    case myelocyteRange = 122
    case absolutePromyelocytes = 123
    case promyelocyteRange = 124
    case absoluteBlasts = 125
    case blastRange = 126
    case absoluteNucleatedRBC = 127
    case nucleatedRBCRange = 128
    case reactiveLymphocyteRange = 129
    case largeImmatureCells = 130
    case largeImmatureCellsRange = 131
    case estrone = 132
    case betaGammaTocopherol = 133
    case lead = 134
    case proteinTotal = 135
    case globulin = 136
    case alpha1Globulin = 137
    case alpha2Globulin = 138
    case beta1Globulin = 139
    case beta2Globulin = 140
    case gammaGlobulin = 141
    case abnormalProteinBand1 = 142
    case abnormalProteinBand2 = 143
    case abnormalProteinBand3 = 144
    case carbohydrateAntigen199 = 145
    case carbohydrateAntigen125 = 146
    case carcinoembryonicAntigen = 147
    case alphaFetoproteinTumorMarker = 148
    case ldlParticleNumber = 149
    case ldlSmall = 150
    case ldlMedium = 151
    case hdlLarge = 152
    case ldlPeakSize = 153
    case lipoproteinA = 154
    case epa = 155
    case dha = 156
    case omega3Index = 157
    case arachidonicAcid = 158
    case methylmalonicAcid = 159
    case candidaAlbicansAntibodiesIgG = 160
    case candidaAlbicansAntibodiesIgA = 161
    case candidaAlbicansAntibodiesIgM = 162
    case borreliaBurgdorferiAntibodiesIgG = 163
    case borreliaBurgdorferiAntibodiesIgM = 164
    case hepatitisAAntibodiesTotal = 165
    case hepatitisAAntibodiesIgM = 166
    case hepatitisAAntibodiesIgG = 167
    case hepatitisBSurfaceAntigen = 168
    case hepatitisBSurfaceAntibodiesTotal = 169
    case hepatitisBEAntigen = 170
    case hepatitisBEAntibodiesTotal = 171
    case hepatitisBCoreAntibodiesIgM = 172
    case hepatitisBCoreAntibodiesTotal = 173
    case hepatitisCAntibodiesIgG = 174
    case hepatitisEAntibodiesIgG = 175
    case hepatitisEAntibodiesIgM = 176
    case cytomegalovirusAntibodiesIgG = 177
    case cytomegalovirusAntibodiesIgM = 178
    case epsteinBarrVirusViralCapsidAntigenAntibodiesIgG = 179
    case epsteinBarrVirusViralCapsidAntigenAntibodiesIgM = 180
    case epsteinBarrVirusNuclearAntigenAntibodiesIgG = 181
    case epsteinBarrVirusEarlyAntigenAntibodiesIgG = 182
    case epsteinBarrVirusHeterophileAntibodiesIgM = 183
    case herpesSimplexVirusType1SpecificAntibodiesIgG = 184
    case herpesSimplexVirusType2SpecificAntibodiesIgG = 185
    case varicellaZosterVirusAntibodiesIgG = 186
    case humanImmunodeficiencyVirusAntigenAntibodies = 187
    case rubellaAntibodiesIgG = 188
    case rubellaAntibodiesIgM = 189
    case nkCellsCytolyticCD3NegCD16PosCD56DimCD45Pos = 190
    case nkCellsCytolyticCD3NegCD16PosCD56DimCD45PosRange = 191
    case nkCellsCytokineProducingCD3NegCD16NegCD56BrightCD45Pos = 192
    case nkCellsCytokineProducingCD3NegCD16NegCD56BrightCD45PosRange = 193
    case tLymphocytes = 194
    case tLymphocytesRangeIn100Lymphocytes = 195
    case tLymphocytesRangeIn100Leukocytes = 196
    case tHelperCellsCD3PosCD4PosCD45Pos = 197
    case tHelperCellsCD3PosCD4PosCD45PosRange = 198
    case cytotoxicTCellsCD3PosCD8PosCD45Pos = 199
    case cytotoxicTCellsCD3PosCD8PosCD45PosRange = 200
    case immatureTCellsCD4PosCD8PosCD45PosRange = 201
    case nkCellsCD3NegCD16PosCD56PosCD45Pos = 202
    case nkCellsCD3NegCD16PosCD56PosCD45PosRangeIn100Lymphocytes = 203
    case nkCellsCD3NegCD16PosCD56PosCD45PosRangeIn100Leukocytes = 204
    case nkCellsExpressingCD8AntigenAlphaChainCD3NegCD8PosCD45Pos = 205
    case nkCellsExpressingCD8AntigenAlphaChainCD3NegCD8PosCD45PosRange = 206
    case bLymphocytes = 207
    case bLymphocytesRangeIn100Lymphocytes = 208
    case bLymphocytesRangeIn100Leukocytes = 209
    case tCellsActivatedCD3PosHLADRPosCD45Pos = 210
    case tCellsActivatedCD3PosHLADRPosCD45PosRange = 211
    case bLymphocytesAndActivatedNKCellsCD3NegHLADRPosCD45Pos = 212
    case bLymphocytesAndActivatedNKCellsCD3NegHLADRPosCD45PosRange = 213
    case activatedTLymphocytesExpressingAlphaChainOfIL2ReceptorCD3PosCD25PosCD45Pos = 214
    case activatedTLymphocytesExpressingAlphaChainOfIL2ReceptorCD3PosCD25PosCD45PosRange = 215
    case activatedBLymphocytesCD3NegCD25PosCD45Pos = 216
    case activatedBLymphocytesCD3NegCD25PosCD45PosRange = 217
    case regulatoryTCellsCD4PosCD25BrightCD127NegCD45PosRange = 218
    case b1CellsCD19PosCD5PosCD27NegCD45Pos = 219
    case b1CellsCD19PosCD5PosCD27NegCD45PosRange = 220
    case b2CellsCD19PosCD5NegCD27NegCD45Pos = 221
    case b2CellsCD19PosCD5NegCD27NegCD45PosRange = 222
    case tCellsExpressingNKCellsMarkersCD3PosCD56PosCD45Pos = 223
    case tCellsExpressingNKCellsMarkersCD3PosCD56PosCD45PosRange = 224
    case memoryTCellsCD4PosCD45ROPosCD45RAPosCD45Pos = 225
    case memoryTCellsCD4PosCD45ROPosCD45RAPosCD45PosRange = 226
    case naiveTCellsCD4PosCD45RAPosCD45RONegCD45Pos = 227
    case naiveTCellsCD4PosCD45RAPosCD45RONegCD45PosRange = 228
    case tCellsActivatedEarlyCD45PosCD3PosCD25PosRange = 229
    case tCellsActivatedCytotoxicExpressingHLADRCD8PosHLADRPosCD45Pos = 230
    case tCellsActivatedCytotoxicExpressingHLADRCD8PosHLADRPosCD45PosRange = 231
    case activatedCD3PosTCellsExpressingCD25Pos = 232
    case activatedCD3PosTCellsExpressingCD25PosRange = 233
    case tCellsActivatedCytotoxicCD3PosCD8BrightCD38Pos = 234
    case tCellsActivatedCytotoxicCD3PosCD8BrightCD38PosRange = 235
    case bilirubinIndirect = 601
    case prothrombinTime = 329
    case activatedPartialTromboplastinTime = 332
}

enum BiomarkerId {
    static let glucose = 1
    static let alt = 28  // alanine aminotransferase
    static let ast = 29  // aspartate aminotransferase
    static let hba1c = 33 // glycated hemoglobin
    static let ldlCholesterol = 2
    static let apoB = 42
    static let crp = 5
    static let insulin = 0
    static let calcium = 16
    static let vitaminD = 8
    static let cortisol = 84
    static let dheas = 65
    static let testosterone = 62
    static let magnesium = 23
    static let zinc = 9
    static let alkalinePhosphatase = 30
    static let ggt = 82
    static let hemoglobin = 35
    static let redBloodCell = 34
    static let meanCorpuscularVolume = 108
    static let cholesterol = 25
    static let triglycerides = 4
    static let tsh = 7
    static let t4 = 75
    static let dDimer = 60
    static let biliTotal = 32
    static let biliDirect = 81
    static let biliIndirect = 601  // NOT FOUND IN ABOVE ENUM YET TODO
    static let albumin = 31
    static let protein = 135
    static let pt = 329  // NOT FOUND IN THE ABOVE ENUM YET TODO
    static let aptt = 332  // NOT FOUND IN ABOVE ENUM YET TODO
    static let creatinine = 21
    static let egfr = 85
    static let prolactin = 11
    static let shbg = 71  // POSSIBLE WRONG MAPPING: Same ID as hydroxyprogesterone17
    static let meanCorpuscularHemoglobin = 109
    static let absoluteReticulocyte = 48
    static let redBloodCellDistributionWidthCV = 101
    static let redBloodCellDistributionWidthSD = 111
    static let riboflavin = 41  // POSSIBLE WRONG MAPPING: Maps to apolipoproteinA1 in MetaBiomarker
    static let homocysteine = 6
    static let methylmalonicAcid = 159
    static let hyperHe = 46  // POSSIBLE WRONG MAPPING: Maps to fibrinogen in MetaBiomarker
    static let iron = 99
    static let ferritin = 10
    static let totalIronBindingCapacity = 49  // POSSIBLE WRONG MAPPING: Maps to neutrophils in MetaBiomarker
    static let hypoHe = 50  // POSSIBLE WRONG MAPPING: Maps to lymphocytes in MetaBiomarker
    static let parathyroidHormone = 51  // POSSIBLE WRONG MAPPING: Maps to monocytes in MetaBiomarker
    static let rbc = 52  // POSSIBLE WRONG MAPPING: Maps to eosinophils in MetaBiomarker
    static let vitaminD25Hydroxy = 8
    static let vitaminD125dihydroxy = 54  // POSSIBLE WRONG MAPPING: Maps to plateletDistributionWidth in MetaBiomarker
    static let phosphorus = 22
    static let t3 = 74  // POSSIBLE WRONG MAPPING: Same ID as inhibinB
    static let thyroidStimulatingHormone = 7
    static let thyroidStimulatingImmunoglobulin = 58  // POSSIBLE WRONG MAPPING: Maps to haptaglobin in MetaBiomarker
    static let thyroidPeroxidaseAntibody = 79
    static let erythrocyteSedimentationRate = 47
    static let highSensitivityCReactiveProtein = 5
    static let thyroglobulinAntibody = 78
    static let totalTestosterone = 62
    static let freeTestosteron = 61
    static let luteinizingHormone = 67
    static let follicleStimulatingHormone = 68
    static let androstendione = 66
    static let dehydroepiandrosteroneSulfate = 65
    static let dehydroepiandrosterone = 69  // POSSIBLE WRONG MAPPING: Same ID as estradiol
    static let freeAndrogenIndex = 70  // POSSIBLE WRONG MAPPING: Maps to progesterone in MetaBiomarker
    static let hydroxyprogesterone17 = 71  // POSSIBLE WRONG MAPPING: Same ID as shbg
    static let antiMullerianHormone = 73
    static let estradiol = 69  // POSSIBLE WRONG MAPPING: Same ID as dehydroepiandrosterone
    static let inhibinB = 74  // POSSIBLE WRONG MAPPING: Same ID as t3
    static let hdlCholesterol = 3
    static let platelets = 38
}
