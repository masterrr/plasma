// plasma.swift

final class PlasmaEngine {
    private var rules: [PlasmaRule]

    init(rules: [PlasmaRule]) {
        self.rules = rules
    }

    convenience init() {
        self.init(rules: [
            PlasmaRule(
                id: 1,
                biomarkerIds: [BiomarkerId.alt, BiomarkerId.ast],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }
                },
                message: "Your liver enzyme levels require medical attention. Consider lifestyle modifications and consult your healthcare provider.",
                importance: 3
            ),

            PlasmaRule(
                id: 2,
                biomarkerIds: [BiomarkerId.glucose, BiomarkerId.hba1c],
                evaluate: { values in
                    values.contains { value in
                        guard let range = value.range else { return false }
                        return range.isCritical
                    }
                },
                message: "Your glucose markers indicate possible diabetes. Please consider lifestyle modifications and consult your healthcare provider for evaluation.",
                importance: 3
            ),

            PlasmaRule(
                id: 3,
                biomarkerIds: [BiomarkerId.ldlCholesterol, BiomarkerId.apoB, BiomarkerId.crp],
                evaluate: { values in
                    let borderlineCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range == .elevated
                    }.count
                    return borderlineCount >= 2
                },
                message: "Consider coronary calcium scoring and carotid ultrasound for early atherosclerosis detection, even though values are only borderline elevated. Early detection can guide preventive strategies.",
                importance: 1
            ),

            // Metabolic Health Rule
            PlasmaRule(
                id: 4,
                biomarkerIds: [BiomarkerId.insulin, BiomarkerId.glucose, BiomarkerId.hba1c],
                evaluate: { values in
                    let criticalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isCritical
                    }.count
                    let abnormalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }.count
                    return criticalCount > 0 || abnormalCount >= 2
                },
                message: "Consider DEXA scan for detailed body composition analysis and visceral fat assessment. Understanding body composition can guide targeted interventions, even with borderline metabolic markers.",
                importance: 1
            ),

            // Bone Health Rule
            PlasmaRule(
                id: 5,
                biomarkerIds: [BiomarkerId.calcium, BiomarkerId.vitaminD],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }
                },
                message: "Consider DEXA scan for detailed body composition analysis and bone density. Please consider lifestyle modifications and consult your healthcare provider for evaluation.",
                importance: 1
            ),

            // Hormone Panel Rule
            PlasmaRule(
                id: 6,
                biomarkerIds: [BiomarkerId.cortisol, BiomarkerId.dheas, BiomarkerId.testosterone],
                evaluate: { values in
                    let criticalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isCritical
                    }.count
                    if criticalCount > 0 { return true }

                    let cortisolDheasAbnormal = values.filter { value in
                        guard let range = value.range else { return false }
                        return (value.biomarkerId == BiomarkerId.cortisol ||
                               value.biomarkerId == BiomarkerId.dheas) &&
                               (range.isAbnormal || range.isCritical)
                    }.count == 2

                    return cortisolDheasAbnormal
                },
                message: "Consider 4-point salivary cortisol testing and comprehensive hormone panel including pregnenolone and melatonin. Diurnal pattern assessment can reveal subtle imbalances even with normal baseline values.",
                importance: 1
            ),

            // Micronutrient Rule
            PlasmaRule(
                id: 7,
                biomarkerIds: [BiomarkerId.vitaminD, BiomarkerId.magnesium, BiomarkerId.zinc],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }
                },
                message: "Consider comprehensive micronutrient testing including intracellular mineral analysis and fat-soluble vitamin panel. Achieving optimal levels rather than just normal ranges can support better health outcomes.",
                importance: 1
            ),

            // Extended Liver Health Rule
            PlasmaRule(
                id: 8,
                biomarkerIds: [BiomarkerId.alkalinePhosphatase, BiomarkerId.alt,
                              BiomarkerId.ggt, BiomarkerId.insulin],
                evaluate: { values in
                    let criticalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isCritical
                    }.count
                    let abnormalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }.count
                    return criticalCount > 0 || abnormalCount >= 2
                },
                message: "Consider liver elastography and abdominal ultrasound. Early detection of fatty liver can guide lifestyle interventions, even with borderline liver enzyme elevations.",
                importance: 1
            ),

            // Anemia Rule
            PlasmaRule(
                id: 9,
                biomarkerIds: [BiomarkerId.hemoglobin, BiomarkerId.rbc, BiomarkerId.mcv],
                evaluate: { values in
                    let criticalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isCritical
                    }.count
                    let abnormalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }.count
                    return criticalCount > 0 || abnormalCount >= 2
                },
                message: "Your blood cell measurements indicate possible anemia. Please consult your healthcare provider for evaluation.",
                importance: 3
            ),

            // Lipid Profile Rule
            PlasmaRule(
                id: 10,
                biomarkerIds: [BiomarkerId.cholesterol, BiomarkerId.ldlCholesterol,
                              BiomarkerId.triglycerides],
                evaluate: { values in
                    let criticalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isCritical
                    }.count
                    let abnormalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }.count
                    return criticalCount > 0 || abnormalCount >= 2
                },
                message: "Multiple components of your lipid profile show concerning values. Consider lifestyle changes and consult your healthcare provider.",
                importance: 2
            ),

            // Thyroid Function Rule
            PlasmaRule(
                id: 11,
                biomarkerIds: [BiomarkerId.tsh, BiomarkerId.t4],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }
                },
                message: "Your thyroid hormone levels require medical attention. Please consult your healthcare provider for evaluation.",
                importance: 3
            ),

            // D-Dimer Rule
            PlasmaRule(
                id: 12,
                biomarkerIds: [BiomarkerId.dDimer],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }
                },
                message: "Your coagulation markers require medical attention! This may indicate a risk of thrombosis! Please consult your healthcare provider.",
                importance: 3
            ),

            // Bilirubin Rule
            PlasmaRule(
                id: 13,
                biomarkerIds: [BiomarkerId.biliTotal, BiomarkerId.biliDirect,
                              BiomarkerId.biliIndirect, BiomarkerId.ggt],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }
                },
                message: "Your liver enzyme levels require attention. Consider liver elastography and abdominal ultrasound. Consider lifestyle modifications and consult your healthcare provider.",
                importance: 3
            ),

            // Protein Rule
            PlasmaRule(
                id: 14,
                biomarkerIds: [BiomarkerId.albumin, BiomarkerId.protein],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }
                },
                message: "Your liver function markers require medical attention! Please consult your healthcare provider. Consider liver elastography and abdominal ultrasound.",
                importance: 3
            ),

            // Coagulation High Values Rule
            PlasmaRule(
                id: 15,
                biomarkerIds: [BiomarkerId.pt, BiomarkerId.aptt],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range == .elevated || range == .criticalAbundance
                    }
                },
                message: "Your coagulation markers require medical attention! This may indicate a risk of bleeding! Please consult your healthcare provider.",
                importance: 3
            ),

            // Coagulation Low Values Rule
            PlasmaRule(
                id: 16,
                biomarkerIds: [BiomarkerId.pt, BiomarkerId.aptt],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range == .deficient || range == .criticalDeficiency
                    }
                },
                message: "Your coagulation markers require medical attention! This may indicate a risk of thrombosis! Please consult your healthcare provider.",
                importance: 3
            ),

            // Kidney Function Rule
            PlasmaRule(
                id: 17,
                biomarkerIds: [BiomarkerId.creatinine, BiomarkerId.egfr],
                evaluate: { values in
                    values.allSatisfy { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }
                },
                message: "Your kidney function markers require medical attention. Please consult your healthcare provider.",
                importance: 3
            ),

            // Hormone Interaction Rule
            PlasmaRule(
                id: 18,
                biomarkerIds: [BiomarkerId.testosterone, BiomarkerId.prolactin],
                evaluate: { values in
                    let testosteroneDeficient = values.first { $0.biomarkerId == BiomarkerId.testosterone }
                        .flatMap { value in
                            guard let range = value.range else { return false }
                            return range == .deficient || range == .criticalDeficiency
                        } ?? false

                    let prolactinElevated = values.first { $0.biomarkerId == BiomarkerId.prolactin }
                        .flatMap { value in
                            guard let range = value.range else { return false }
                            return range == .elevated || range == .criticalAbundance
                        } ?? false

                    return testosteroneDeficient && prolactinElevated
                },
                message: "Your hormone levels show an important interaction that requires medical evaluation. Please consult your healthcare provider.",
                importance: 3
            ),

            // SHBG Rule
            PlasmaRule(
                id: 19,
                biomarkerIds: [BiomarkerId.testosterone, BiomarkerId.shbg],
                evaluate: { values in
                    let criticalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isCritical
                    }.count
                    let abnormalCount = values.filter { value in
                        guard let range = value.range else { return false }
                        return range.isAbnormal || range.isCritical
                    }.count
                    return criticalCount > 0 || abnormalCount > 0
                },
                message: "Your hormone and binding protein levels require attention. Please consult your healthcare provider for evaluation.",
                importance: 2
            ),
            // Anemia rule
            PlasmaRule(
                id: 20,
                biomarkerIds: [BiomarkerId.hemoglobin, BiomarkerId.meanCorpuscularVolume, BiomarkerId.meanCorpuscularHemoglobin, BiomarkerId.iron, BiomarkerId.ferritin, BiomarkerId.totalIronBindingCapacity,BiomarkerId.redBloodCell, BiomarkerId.redBloodCellDistributionWidthCV, BiomarkerId.redBloodCellDistributionWidthSD, BiomarkerId.hypoHe],
                evaluate: { values in
                    // Retrieve values for each biomarker
                    let hemoglobin = values.first(where: { $0.biomarkerId == BiomarkerId.hemoglobin })
                    let mcv = values.first(where: { $0.biomarkerId == BiomarkerId.meanCorpuscularVolume })
                    let mch = values.first(where: { $0.biomarkerId == BiomarkerId.meanCorpuscularHemoglobin })
                    let iron = values.first(where: { $0.biomarkerId == BiomarkerId.iron })
                    let ferritin = values.first(where: { $0.biomarkerId == BiomarkerId.ferritin })
                    let rbc = values.first(where: { $0.biomarkerId == BiomarkerId.redBloodCell })
                    let tibc = values.first(where: { $0.biomarkerId == BiomarkerId.totalIronBindingCapacity })
                    let rdwCV = values.first(where: { $0.biomarkerId == BiomarkerId.redBloodCellDistributionWidthCV })
                    let rdwSD = values.first(where: { $0.biomarkerId == BiomarkerId.redBloodCellDistributionWidthSD })
                    let hypoHe = values.first(where: { $0.biomarkerId == BiomarkerId.hypoHe })
                    
                    // Logic for detecting iron deficiency anemia based on the range
                    let isIronDeficiencyAnemia = (
                        // Deficient or critically deficient levels for these biomarkers
                        (hemoglobin?.range == .deficient || hemoglobin?.range == .criticalDeficiency ||
                         mcv?.range == .deficient || mcv?.range == .criticalDeficiency ||
                         mch?.range == .deficient || mch?.range == .criticalDeficiency ||
                         iron?.range == .deficient || iron?.range == .criticalDeficiency ||
                         ferritin?.range == .deficient || ferritin?.range == .criticalDeficiency) &&
                        
                        // Deficient red blood cells
                        (rbc?.range == .deficient) &&
                        
                        // Elevated or critically abundant levels for these biomarkers
                        (tibc?.range == .elevated || tibc?.range == .criticalAbundance ||
                         rdwCV?.range == .elevated || rdwCV?.range == .criticalAbundance ||
                         rdwSD?.range == .elevated || rdwSD?.range == .criticalAbundance ||
                         hypoHe?.range == .elevated || hypoHe?.range == .criticalAbundance) &&
                        
                        // Elevated red blood cell distribution width
                        (rdwCV?.range == .elevated || rdwSD?.range == .elevated)
                    )

                    return isIronDeficiencyAnemia
                },


                message: "The, changes, in your test results are characteristic of iron deficiency anemia.This condition can indicate a lack of iron in the body.A consultation with a doctor is recommended to identify the underlying cause and determine treatment, which may include iron supplements and dietary adjustments.Consuming iron-rich foods (meat, fish, legumes, leafy greens) and ensuring adequate hydration can support iron levels restoration." ,
                importance: 2
            ),
    // FD anemia rule
        PlasmaRule(
            id: 21,
            biomarkerIds: [
                BiomarkerId.hemoglobin, BiomarkerId.meanCorpuscularVolume, BiomarkerId.meanCorpuscularHemoglobin,
                BiomarkerId.absoluteReticulocyte, BiomarkerId.redBloodCell, BiomarkerId.redBloodCellDistributionWidthCV,
                BiomarkerId.redBloodCellDistributionWidthSD, BiomarkerId.riboflavin, BiomarkerId.homocysteine,
                BiomarkerId.methylmalonicAcid, BiomarkerId.hyperHe
            ],
            evaluate: { values in
                // Retrieve values for each biomarker
                let hemoglobin = values.first(where: { $0.biomarkerId == BiomarkerId.hemoglobin })
                let riboflavin = values.first(where: { $0.biomarkerId == BiomarkerId.riboflavin })
                let absoluteReticulocyte = values.first(where: { $0.biomarkerId == BiomarkerId.absoluteReticulocyte })
                let redBloodCell = values.first(where: { $0.biomarkerId == BiomarkerId.redBloodCell })
                let homocysteine = values.first(where: { $0.biomarkerId == BiomarkerId.homocysteine })
                let methylmalonicAcid = values.first(where: { $0.biomarkerId == BiomarkerId.methylmalonicAcid })
                let hyperHe = values.first(where: { $0.biomarkerId == BiomarkerId.hyperHe })
                let meanCorpuscularHemoglobin = values.first(where: { $0.biomarkerId == BiomarkerId.meanCorpuscularHemoglobin })
                let redBloodCellDistributionWidthCV = values.first(where: { $0.biomarkerId == BiomarkerId.redBloodCellDistributionWidthCV })
                let redBloodCellDistributionWidthSD = values.first(where: { $0.biomarkerId == BiomarkerId.redBloodCellDistributionWidthSD })

                // Logic for detecting the conditions based on the ranges
                let isDeficientOrCritical = (
                    (hemoglobin?.range == .deficient || hemoglobin?.range == .criticalDeficiency ||
                     riboflavin?.range == .deficient || riboflavin?.range == .criticalDeficiency ||
                     absoluteReticulocyte?.range == .deficient || absoluteReticulocyte?.range == .criticalDeficiency ||
                     redBloodCell?.range == .deficient || redBloodCell?.range == .criticalDeficiency)
                )

                let isElevatedOrCriticalAbundance = (
                    homocysteine?.range == .elevated || homocysteine?.range == .criticalAbundance ||
                    methylmalonicAcid?.range == .elevated || methylmalonicAcid?.range == .criticalAbundance ||
                    hyperHe?.range == .elevated || hyperHe?.range == .criticalAbundance ||
                    meanCorpuscularHemoglobin?.range == .elevated || meanCorpuscularHemoglobin?.range == .criticalAbundance ||
                    redBloodCellDistributionWidthCV?.range == .elevated || redBloodCellDistributionWidthCV?.range == .criticalAbundance ||
                    redBloodCellDistributionWidthSD?.range == .elevated || redBloodCellDistributionWidthSD?.range == .criticalAbundance
                )

                // Return true if either condition is satisfied
                return isDeficientOrCritical || isElevatedOrCriticalAbundance
            },
            message: "The changes in your test results are characteristic of folate-deficiency anemia. This condition may indicate a low level of folic acid in the body, which is essential for red blood cell production. A consultation with a doctor is recommended to determine the cause and develop an appropriate treatment plan. Treatment may include folic acid supplements and dietary adjustments. To restore folate levels, focus on consuming folate-rich foods such as leafy greens (spinach, kale), citrus fruits, beans, peas, and fortified cereals.",
            importance: 3
        ),
// Endocrinology rule
        PlasmaRule(
            id: 21,
            biomarkerIds:[ BiomarkerId.parathyroidHormone, BiomarkerId.calcium, BiomarkerId.vitaminD25Hydroxy, BiomarkerId.vitaminD125dihydroxy, BiomarkerId.phosphorus, BiomarkerId.creatinine, BiomarkerId.albumin ],
            evaluate: { values in
                   // Retrieve values for each biomarker
                   let parathyroidHormone = values.first(where: { $0.biomarkerId == BiomarkerId.parathyroidHormone })
                   let calcium = values.first(where: { $0.biomarkerId == BiomarkerId.calcium })
                   let vitaminD125dihydroxy = values.first(where: { $0.biomarkerId == BiomarkerId.vitaminD125dihydroxy })
                   let creatinine = values.first(where: { $0.biomarkerId == BiomarkerId.creatinine })
                   let phosphorus = values.first(where: { $0.biomarkerId == BiomarkerId.phosphorus })
                   let vitaminD25Hydroxy = values.first(where: { $0.biomarkerId == BiomarkerId.vitaminD25Hydroxy })
                   let albumin = values.first(where: { $0.biomarkerId == BiomarkerId.albumin })

                   // Check for elevated or critical abundance
                   let isElevatedOrCriticalAbundance = (
                       parathyroidHormone?.range == .elevated || parathyroidHormone?.range == .criticalAbundance ||
                       calcium?.range == .elevated || calcium?.range == .criticalAbundance ||
                       vitaminD125dihydroxy?.range == .elevated || vitaminD125dihydroxy?.range == .criticalAbundance ||
                       creatinine?.range == .elevated || creatinine?.range == .criticalAbundance
                   )

                   // Check for deficient levels
                   let isDeficient = (
                       phosphorus?.range == .deficient ||
                       vitaminD25Hydroxy?.range == .deficient ||
                       albumin?.range == .deficient
                   )

                   // Return true if any of the conditions are met
                   return isElevatedOrCriticalAbundance || isDeficient
               },
               message: "The changes in your test results indicate increased function of the parathyroid glands. Timely diagnosis can help prevent complications. Please consult your primary care physician or an endocrinologist for further evaluation and treatment. In the meantime, avoid taking supplements containing calcium and vitamin D, and opt for non-carbonated drinking water instead of mineral water. Ensure a healthy balance between work and rest.",
               importance: 3
           ),
        // Endocrinology rule
                PlasmaRule(
                    id: 22,
                    biomarkerIds:[ BiomarkerId.parathyroidHormone, BiomarkerId.calcium, BiomarkerId.vitaminD125dihydroxy, BiomarkerId.vitaminD25Hydroxy, BiomarkerId.phosphorus, BiomarkerId.magnesium,] ,
                    evaluate: { values in
                           // Retrieve values for each biomarker
                           let phosphorus = values.first(where: { $0.biomarkerId == BiomarkerId.phosphorus })
                           let parathyroidHormone = values.first(where: { $0.biomarkerId == BiomarkerId.parathyroidHormone })
                           let vitaminD25Hydroxy = values.first(where: { $0.biomarkerId == BiomarkerId.vitaminD25Hydroxy })
                           let vitaminD125dihydroxy = values.first(where: { $0.biomarkerId == BiomarkerId.vitaminD125dihydroxy })
                           let magnesium = values.first(where: { $0.biomarkerId == BiomarkerId.magnesium })
                           let calcium = values.first(where: { $0.biomarkerId == BiomarkerId.calcium })

                           // Check for elevated levels
                           let isElevated = (
                               phosphorus?.range == .elevated ||
                               parathyroidHormone?.range == .elevated
                           )

                           // Check for deficient levels
                           let isDeficient = (
                               vitaminD25Hydroxy?.range == .deficient ||
                               vitaminD125dihydroxy?.range == .deficient ||
                               magnesium?.range == .deficient ||
                               calcium?.range == .deficient
                           )

                           // Return true if any of the conditions are met
                           return isElevated || isDeficient
                    },
                       message: "The changes in your laboratory tests may indicate reduced parathyroid gland function. Timely diagnosis and treatment can help prevent complications. Please consult your primary care physician or an endocrinologist for further evaluation and treatment. In the meantime, increase calcium-rich foods in your diet, such as dairy products, soy, and legumes. Maintain proper hydration and ensure a healthy balance between work and rest.",
                       importance: 3
                   ),
        // Endocrinology rule
                PlasmaRule(
                    id: 23,
                    biomarkerIds:[BiomarkerId.tsh, BiomarkerId.t3,BiomarkerId.t4, BiomarkerId.thyroidStimulatingHormone, BiomarkerId.thyroidStimulatingImmunoglobulin, BiomarkerId.thyroidPeroxidaseAntibody, BiomarkerId.erythrocyteSedimentationRate, BiomarkerId.crp, BiomarkerId.highSensitivityCReactiveProtein, BiomarkerId.thyroglobulinAntibody,] ,
                    evaluate: { values in
                          // Extract values for each biomarker
                          let t4 = values.first(where: { $0.biomarkerId == BiomarkerId.t4 })
                          let t3 = values.first(where: { $0.biomarkerId == BiomarkerId.t3 })
                          let thyroidStimulatingHormone = values.first(where: { $0.biomarkerId == BiomarkerId.thyroidStimulatingHormone })
                          let thyroidPeroxidaseAntibody = values.first(where: { $0.biomarkerId == BiomarkerId.thyroidPeroxidaseAntibody })
                          let erythrocyteSedimentationRate = values.first(where: { $0.biomarkerId == BiomarkerId.erythrocyteSedimentationRate })
                          let crp = values.first(where: { $0.biomarkerId == BiomarkerId.crp })
                          let highSensitivityCReactiveProtein = values.first(where: { $0.biomarkerId == BiomarkerId.highSensitivityCReactiveProtein })
                          let thyroglobulinAntibody = values.first(where: { $0.biomarkerId == BiomarkerId.thyroglobulinAntibody })

                          // Check for elevated or critically abundant levels
                          let isElevatedOrCriticalAbundance = (
                              t4?.range == .elevated || t4?.range == .criticalAbundance ||
                              t3?.range == .elevated || t3?.range == .criticalAbundance ||
                              thyroidStimulatingHormone?.range == .elevated || thyroidStimulatingHormone?.range == .criticalAbundance ||
                              thyroidPeroxidaseAntibody?.range == .elevated || thyroidPeroxidaseAntibody?.range == .criticalAbundance ||
                              erythrocyteSedimentationRate?.range == .elevated || erythrocyteSedimentationRate?.range == .criticalAbundance ||
                              crp?.range == .elevated || crp?.range == .criticalAbundance ||
                              highSensitivityCReactiveProtein?.range == .elevated || highSensitivityCReactiveProtein?.range == .criticalAbundance ||
                              thyroglobulinAntibody?.range == .elevated || thyroglobulinAntibody?.range == .criticalAbundance
                          )

                          return isElevatedOrCriticalAbundance
                      },
                    message: "The changes in your laboratory tests may suggest the possibility of autoimmune hyperthyroidism (Graves' disease).Timely diagnosis and treatment can help prevent complications. Please consult your primary care physician or an endocrinologist for further evaluation and treatment. Consider imaging such as a Radioactive Iodine Uptake (RAIU) test, if not already done, to confirm the diagnosis. Look out for palpitations, weight loss, heat intolerance, tremors, or changes in eye appearance, and report these to your healthcare provider. Incorporate balanced meals with adequate protein and complex carbohydrates to manage potential weight loss.Limit caffeine and iodine-rich foods (e.g, seaweed) unless otherwise advised by a doctor. Graves' disease can impact mood and anxiety levels. Practice stress-reducing techniques like mindfulness, yoga, or meditation.Maintain regular sleep patterns to manage fatigue and mood swings. Consider a calming bedtime routine to enhance sleep quality .",
                    importance: 3
                ),
                  // Endocrinology rule
                          PlasmaRule(
                              id: 24,
                              biomarkerIds: [BiomarkerId.totalTestosterone, BiomarkerId.freeTestosteron, BiomarkerId.luteinizingHormone, BiomarkerId.dehydroepiandrosterone, BiomarkerId.follicleStimulatingHormone, BiomarkerId.androstendione, BiomarkerId.dehydroepiandrosteroneSulfate, BiomarkerId.glucose, BiomarkerId.insulin, BiomarkerId.triglycerides, BiomarkerId.ldlCholesterol, BiomarkerId.hydroxyprogesterone17, BiomarkerId.freeAndrogenIndex, BiomarkerId.shbg, BiomarkerId.antiMullerianHormone] ,
                                  evaluate: { values in
                                      // Extract values for each biomarker
                                      let totalTestosterone = values.first(where: { $0.biomarkerId == BiomarkerId.totalTestosterone })
                                      let freeTestosteron = values.first(where: { $0.biomarkerId == BiomarkerId.freeTestosteron })
                                      let luteinizingHormone = values.first(where: { $0.biomarkerId == BiomarkerId.luteinizingHormone })
                                      let dehydroepiandrosterone = values.first(where: { $0.biomarkerId == BiomarkerId.dehydroepiandrosterone })
                                      let follicleStimulatingHormone = values.first(where: { $0.biomarkerId == BiomarkerId.follicleStimulatingHormone })
                                      let androstendione = values.first(where: { $0.biomarkerId == BiomarkerId.androstendione })
                                      let dehydroepiandrosteroneSulfate = values.first(where: { $0.biomarkerId == BiomarkerId.dehydroepiandrosteroneSulfate })
                                      let glucose = values.first(where: { $0.biomarkerId == BiomarkerId.glucose })
                                      let insulin = values.first(where: { $0.biomarkerId == BiomarkerId.insulin })
                                      let triglycerides = values.first(where: { $0.biomarkerId == BiomarkerId.triglycerides })
                                      let ldlCholesterol = values.first(where: { $0.biomarkerId == BiomarkerId.ldlCholesterol })
                                      let hydroxyprogesterone17 = values.first(where: { $0.biomarkerId == BiomarkerId.hydroxyprogesterone17 })
                                      let freeAndrogenIndex = values.first(where: { $0.biomarkerId == BiomarkerId.freeAndrogenIndex })
                                      let antiMullerianHormone = values.first(where: { $0.biomarkerId == BiomarkerId.antiMullerianHormone })
                                      let shbg = values.first(where: { $0.biomarkerId == BiomarkerId.shbg })

                                      // Check for elevated biomarkers
                                      let isElevated = (
                                          totalTestosterone?.range == .elevated || freeTestosteron?.range == .elevated ||
                                          luteinizingHormone?.range == .elevated || dehydroepiandrosterone?.range == .elevated ||
                                          follicleStimulatingHormone?.range == .elevated || androstendione?.range == .elevated ||
                                          dehydroepiandrosteroneSulfate?.range == .elevated || glucose?.range == .elevated ||
                                          insulin?.range == .elevated || triglycerides?.range == .elevated || ldlCholesterol?.range == .elevated ||
                                          hydroxyprogesterone17?.range == .elevated || freeAndrogenIndex?.range == .elevated ||
                                          antiMullerianHormone?.range == .elevated
                                      )

                                      // Check for deficient biomarkers
                                      let isDeficient = (
                                          shbg?.range == .deficient || follicleStimulatingHormone?.range == .deficient
                                      )

                                      // Return evaluation based on elevated or deficient conditions
                                      return isElevated && isDeficient
                                  },
                                  message: "Your test results indicate elevated levels of several key hormones and metabolic markers, which may suggest a condition such as polycystic ovary syndrome (PCOS), metabolic syndrome, or other endocrine or metabolic disorders. Additionally, low levels of SHBG and Follicle Stimulating Hormone (FSH) could indicate an imbalance in your hormonal regulation. We recommend consulting your healthcare provider for a comprehensive evaluation and personalized treatment plan.",
                                  importance: 3
                              ),
            // Endocrinology rule
                    PlasmaRule(
                        id: 25,
                        biomarkerIds: [BiomarkerId.follicleStimulatingHormone, BiomarkerId.estradiol, BiomarkerId.antiMullerianHormone, BiomarkerId.inhibinB,],
                        evaluate: { values in
                               // Extract values for each biomarker
                               let follicleStimulatingHormone = values.first(where: { $0.biomarkerId == BiomarkerId.follicleStimulatingHormone })
                               let estradiol = values.first(where: { $0.biomarkerId == BiomarkerId.estradiol })
                               let antiMullerianHormone = values.first(where: { $0.biomarkerId == BiomarkerId.antiMullerianHormone })
                               let inhibinB = values.first(where: { $0.biomarkerId == BiomarkerId.inhibinB })

                               // Check for elevated FSH
                               let isElevatedFSH = follicleStimulatingHormone?.range == .elevated

                               // Check for deficient estradiol, AMH, and inhibin B
                               let isDeficientEstradiol = estradiol?.range == .deficient
                               let isDeficientAMH = antiMullerianHormone?.range == .deficient
                               let isDeficientInhibinB = inhibinB?.range == .deficient

                               // Return evaluation based on elevated FSH and deficient estradiol, AMH, and inhibin B
                               return isElevatedFSH && (isDeficientEstradiol || isDeficientAMH || isDeficientInhibinB)
                           },
                           message: "Your test results show an elevated level of Follicle Stimulating Hormone (FSH), which may indicate diminished ovarian reserve or possible early menopause. Additionally, low levels of estradiol, anti-Müllerian hormone (AMH), or inhibin B may suggest a disruption in ovarian function or hormonal balance. We recommend consulting a healthcare provider for further evaluation and possible treatments.",
                           importance: 3
                       ),
            // Endocrinology rule hypothyroidism
                    PlasmaRule(
                        id: 26,
                        biomarkerIds: [ BiomarkerId.thyroidStimulatingHormone, BiomarkerId.t3, BiomarkerId.t4, BiomarkerId.thyroidStimulatingImmunoglobulin , BiomarkerId.thyroidPeroxidaseAntibody, BiomarkerId.erythrocyteSedimentationRate, BiomarkerId.thyroglobulinAntibody, BiomarkerId.crp, BiomarkerId.highSensitivityCReactiveProtein,],
                        evaluate: { values in
                               // Extract values for each biomarker
                               let thyroidStimulatingHormone = values.first(where: { $0.biomarkerId == BiomarkerId.thyroidStimulatingHormone })
                               let t3 = values.first(where: { $0.biomarkerId == BiomarkerId.t3 })
                               let t4 = values.first(where: { $0.biomarkerId == BiomarkerId.t4 })
                               let thyroidStimulatingImmunoglobulin = values.first(where: { $0.biomarkerId == BiomarkerId.thyroidStimulatingImmunoglobulin })
                               let thyroidPeroxidaseAntibody = values.first(where: { $0.biomarkerId == BiomarkerId.thyroidPeroxidaseAntibody })
                               let erythrocyteSedimentationRate = values.first(where: { $0.biomarkerId == BiomarkerId.erythrocyteSedimentationRate })
                               let thyroglobulinAntibody = values.first(where: { $0.biomarkerId == BiomarkerId.thyroglobulinAntibody })
                               let crp = values.first(where: { $0.biomarkerId == BiomarkerId.crp })
                               let highSensitivityCReactiveProtein = values.first(where: { $0.biomarkerId == BiomarkerId.highSensitivityCReactiveProtein })

                               // Check for elevated biomarkers
                               let isElevated = (
                                   thyroidStimulatingHormone?.range == .elevated ||
                                   thyroidStimulatingImmunoglobulin?.range == .elevated ||
                                   thyroidPeroxidaseAntibody?.range == .elevated ||
                                   erythrocyteSedimentationRate?.range == .elevated ||
                                   thyroglobulinAntibody?.range == .elevated ||
                                   crp?.range == .elevated ||
                                   highSensitivityCReactiveProtein?.range == .elevated
                               )

                               // Check for decreased biomarkers
                               let isDecreased = (
                                   t3?.range == .deficient ||
                                   t4?.range == .deficient
                               )

                               // Return true if any of the conditions are met
                            
                               return isElevated && isDecreased
                           },
                           message: "Your test results indicate that certain thyroid and inflammatory biomarkers are elevated, while T3 and T4 levels are low. These findings could suggest an underlying thyroid disorder or inflammation. It is important to consult with a healthcare provider for further evaluation and appropriate treatment. Management may involve thyroid function tests, imaging, and addressing any inflammatory conditions present.",
                           importance: 3
                    ),
            // Endocrinology rule hyperthyroidism
                    PlasmaRule(
                        id: 27,
                        biomarkerIds: [ BiomarkerId.tsh, BiomarkerId.t3, BiomarkerId.t4, BiomarkerId.thyroidStimulatingImmunoglobulin, BiomarkerId.thyroidPeroxidaseAntibody, BiomarkerId.erythrocyteSedimentationRate, BiomarkerId.thyroglobulinAntibody, BiomarkerId.crp, BiomarkerId.highSensitivityCReactiveProtein, ],
                        evaluate: { values in
                              // Extract values for each biomarker
                              let tsh = values.first(where: { $0.biomarkerId == BiomarkerId.tsh })
                              let t3 = values.first(where: { $0.biomarkerId == BiomarkerId.t3 })
                              let t4 = values.first(where: { $0.biomarkerId == BiomarkerId.t4 })
                              let thyroidStimulatingImmunoglobulin = values.first(where: { $0.biomarkerId == BiomarkerId.thyroidStimulatingImmunoglobulin })
                              let thyroidPeroxidaseAntibody = values.first(where: { $0.biomarkerId == BiomarkerId.thyroidPeroxidaseAntibody })
                              let erythrocyteSedimentationRate = values.first(where: { $0.biomarkerId == BiomarkerId.erythrocyteSedimentationRate })
                              let thyroglobulinAntibody = values.first(where: { $0.biomarkerId == BiomarkerId.thyroglobulinAntibody })
                              let crp = values.first(where: { $0.biomarkerId == BiomarkerId.crp })
                              let highSensitivityCReactiveProtein = values.first(where: { $0.biomarkerId == BiomarkerId.highSensitivityCReactiveProtein })

                              // Check for deficiency in TSH
                              let isDeficientTSH = tsh?.range == .deficient

                              // Check for elevated levels in other biomarkers
                              let isElevated = (
                                  t3?.range == .elevated ||
                                  t4?.range == .elevated ||
                                  thyroidStimulatingImmunoglobulin?.range == .elevated ||
                                  thyroidPeroxidaseAntibody?.range == .elevated ||
                                  erythrocyteSedimentationRate?.range == .elevated ||
                                  thyroglobulinAntibody?.range == .elevated ||
                                  crp?.range == .elevated ||
                                  highSensitivityCReactiveProtein?.range == .elevated
                              )

                              // Return true if the conditions are met
                              return isDeficientTSH && isElevated
                          },
                          message: "Your test results indicate a deficiency in TSH combined with elevated levels of other thyroid and inflammatory biomarkers. This pattern may suggest hyperthyroidism or an underlying inflammatory condition. Please consult with a healthcare provider for further assessment and appropriate management, which may include additional thyroid function tests and evaluation for autoimmune or inflammatory diseases.Be aware of symptoms like weight loss, palpitations, heat intolerance, sweating, tremors, or eye changes and report these to your healthcare provider.Limit iodine intake (e.g., seaweed, iodized salt) and caffeine to manage symptoms like nervousness and palpitations. Maintain a balanced diet with sufficient calories to meet increased metabolic needs.Treatment options may include antithyroid medications, radioactive iodine therapy, or surgery. Follow up regularly to monitor thyroid function and adjust treatment as needed.Practice relaxation techniques such as meditation or yoga to reduce stress, which can exacerbate symptoms. Prioritize regular sleep patterns to manage fatigue.",
                          importance: 3
                    ),
            // Metabolic rule
                    PlasmaRule(
                        id: 28,
                        biomarkerIds: [ BiomarkerId.glucose, BiomarkerId.hba1c, BiomarkerId.triglycerides, BiomarkerId.hdlCholesterol, BiomarkerId.ldlCholesterol,],
                        evaluate: { values in
                               // Extract values for each biomarker
                               let glucose = values.first(where: { $0.biomarkerId == BiomarkerId.glucose })
                               let hba1c = values.first(where: { $0.biomarkerId == BiomarkerId.hba1c })
                               let triglycerides = values.first(where: { $0.biomarkerId == BiomarkerId.triglycerides })
                               let hdl = values.first(where: { $0.biomarkerId == BiomarkerId.hdlCholesterol })
                               let ldl = values.first(where: { $0.biomarkerId == BiomarkerId.ldlCholesterol })

                               // Check if HDL Cholesterol is deficient
                               let isHDLDeficient = hdl?.range == .deficient

                               // Check if other biomarkers are elevated
                               let isEvaluated = (
                                   glucose?.range == .elevated ||
                                   hba1c?.range == .elevated ||
                                   triglycerides?.range == .elevated ||
                                   ldl?.range == .elevated
                               )

                               // Return true if HDL is deficient or if other biomarkers are elevated
                               return isHDLDeficient || isEvaluated
                           },
                        message: "the results indicate a deficiency in HDL cholesterol or elevated levels of glucose, HbA1c, triglycerides, or LDL cholesterol. The changes in your lab results may indicate metabolic syndrome, increasing the risk for diabetes, cardiovascular disease, and stroke. Consult your physician for a comprehensive evaluation and individualized treatment plan.Adopt a Mediterranean-style diet, rich in fruits, vegetables, lean proteins, and healthy fats, to improve blood sugar and lipid profiles.Monitor your blood pressure levels and try to normalize your BMI. Engage in regular physical activity, aiming for at least 150 minutes of moderate-intensity exercise weekly.If needed, medications like antihypertensives, statins, or antidiabetics may be prescribed to manage individual components. Regular follow-ups to monitor progress are essential.",
                           importance: 3
                    ),
                ]
                )}
        }
