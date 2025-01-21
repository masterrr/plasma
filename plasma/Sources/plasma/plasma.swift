// plasma.swift

let Aksana = RuleAuthor(name: "Aksana")

final class PlasmaEngine {
    private var rules: [PlasmaRule]
    
    init(rules: [PlasmaRule]) {
        self.rules = rules
    }
    
    convenience init() {
        self.init(rules: [
            
            // Metabolic rule
            PlasmaRule (
                id: 29,
                references:[ Reference( hyperlink: "https://www.auanet.org/guidelines-and-quality/guidelines/testosterone-deficiency-guideline")],
                authors: [Aksana],
                biomarkerIds: [BiomarkerId.freeTestosteron, BiomarkerId.totalTestosterone,],
                evaluate: { values in
                    // Extract values for each biomarker
                    let freeTestosterone = values.first(where: { $0.biomarkerId == BiomarkerId.freeTestosteron })
                    let totalTestosterone = values.first(where: { $0.biomarkerId == BiomarkerId.totalTestosterone })
                    
                    // Check for deficiency (low levels)
                    let isDeficient = (
                        freeTestosterone?.range == PlasmaRange.deficient ||
                        totalTestosterone?.range == PlasmaRange.deficient)
                    
                    // Return true if any of the biomarkers are deficient
                    return isDeficient
                },
                message: " The results indicate a deficiency in testosterone biomarkers, which may suggest hypogonadism or another endocrine issue affecting testosterone levels.You need further examination to determine the underlying cause and discuss possible treatment options with your physician or an endocrinologist.Incorporating resistance training and ensuring adequate protein and essential fats in your diet may help support healthy testosterone levels. Regular follow-ups to monitor your hormone levels and overall progress are essential",
                importance: 2
            ),
            
            // Metabolic rule
            PlasmaRule (
                id: 30,
                references:[Reference(hyperlink:  "https://journals.lww.com/hep/fulltext/2023/05000/aasld_practice_guidance_on_the_clinical_assessment.31.aspx"),],
                authors: [Aksana],
                biomarkerIds: [ BiomarkerId.alt, BiomarkerId.ast, BiomarkerId.triglycerides,  BiomarkerId.ldlCholesterol, BiomarkerId.glucose, BiomarkerId.hba1c, BiomarkerId.creatinine,],
                evaluate: { values in
                    // Extract values for each biomarker
                    let altValue = values.first(where: { $0.biomarkerId == BiomarkerId.alt })
                    let astValue = values.first(where: { $0.biomarkerId == BiomarkerId.ast })
                    let triglyceridesValue = values.first(where: { $0.biomarkerId == BiomarkerId.triglycerides })
                    let ldlValue = values.first(where: { $0.biomarkerId == BiomarkerId.ldlCholesterol })
                    let glucoseValue = values.first(where: { $0.biomarkerId == BiomarkerId.glucose })
                    let hba1cValue = values.first(where: { $0.biomarkerId == BiomarkerId.hba1c })
                    let creatinineValue = values.first(where: { $0.biomarkerId == BiomarkerId.creatinine })
                    
                    // Check if any of these biomarkers are elevated
                    let isAnyElevated = (
                        altValue?.range == .elevated ||
                        astValue?.range == .elevated ||
                        triglyceridesValue?.range == .elevated ||
                        ldlValue?.range == .elevated ||
                        glucoseValue?.range == .elevated ||
                        hba1cValue?.range == .elevated ||
                        creatinineValue?.range == .elevated
                    )
                    
                    return isAnyElevated
                },
                message:" These findings may indicate a possible risk of Nonalcoholic Fatty Liver Disease (NAFLD) or related metabolic dysfunction. We recommend a thorough evaluation by your healthcare provider, which may include imaging (ultrasound, MRI) and lifestyle assessment. Early detection and management of NAFLD are crucial to preventing further complications and improving overall liver health.",
                importance: 2
            ),
            // Metabolic rule
            PlasmaRule (
                id: 31,
                references: [Reference(hyperlink: "https://pubmed.ncbi.nlm.nih.gov/36510335/")],
                authors: [Aksana],
                biomarkerIds:  [BiomarkerId.vitaminD25Hydroxy,BiomarkerId.phosphorus,BiomarkerId.betaCrossLaps,BiomarkerId.osteocalcin, BiomarkerId.boneSpicificAlkalinePhosphatase,] ,
                evaluate: { values in
                    // Extract values for each biomarker
                    let vitaminD25Hydroxy = values.first(where: { $0.biomarkerId == BiomarkerId.vitaminD25Hydroxy })
                    let phosphorus = values.first(where: { $0.biomarkerId == BiomarkerId.phosphorus })
                    let betaCrossLaps = values.first(where: { $0.biomarkerId == BiomarkerId.betaCrossLaps })
                    let osteocalcin = values.first(where: { $0.biomarkerId == BiomarkerId.osteocalcin })
                    let boneSpicificAlkalinePhosphatase = values.first(where: { $0.biomarkerId == BiomarkerId.boneSpicificAlkalinePhosphatase })
                    
                    // Check for deficiencies in Vitamin D, phosphorus, osteocalcin, and bone-specific alkaline phosphatase
                    let isDeficient = (
                        vitaminD25Hydroxy?.range == PlasmaRange.deficient ||
                        phosphorus?.range == PlasmaRange.deficient ||
                        osteocalcin?.range == PlasmaRange.deficient ||
                        boneSpicificAlkalinePhosphatase?.range == PlasmaRange.deficient
                    )
                    
                    // Check for elevated Beta Cross Laps
                    let isElevatedBetaCrossLaps = betaCrossLaps?.range == PlasmaRange.elevated
                    
                    // Return true if the conditions are met (deficiencies + elevated Beta Cross Laps)
                    return isDeficient && isElevatedBetaCrossLaps
                },
                message: "The changes in your laboratory tests may suggest potential bone metabolism issues, such as osteoporosis or bone turnover disorders. This may indicate bone fragility or an increased risk of fractures. Timely assessment by an endocrinologist or a rheumatologist is essential for a full evaluation. Consider a bone density test (DEXA scan) to assess bone strength. To support bone health, ensure adequate intake of calcium, vitamin D, and magnesium. Weight-bearing exercises like walking or resistance training can help maintain bone mass. Limit alcohol consumption and avoid smoking, as these can negatively impact bone health. If diagnosed with osteoporosis or another bone disorder, discuss treatment options with your healthcare provider.",
                importance: 2
            ),
            // Metabolic rule
            PlasmaRule (
                id: 32,
                references: [Reference(hyperlink: "https://www.oatext.com/pdf/IMM-2-137.pdf")],
                authors: [Aksana],
                biomarkerIds:  [BiomarkerId.alphaAmylase, BiomarkerId.lipase,] ,
                evaluate:{ values in
                    // Extract values for each biomarker
                    let alphaAmylase = values.first(where: { $0.biomarkerId == BiomarkerId.alphaAmylase })
                    let lipase = values.first(where: { $0.biomarkerId == BiomarkerId.lipase })
                    
                    // Check for elevated levels
                    let isElevated = (
                        alphaAmylase?.range == PlasmaRange.elevated ||
                        lipase?.range == PlasmaRange.elevated
                    )
                    
                    // Return true if any of the biomarkers are elevated
                    return isElevated
                },
                message: "Your test results indicate elevated levels of alpha amylase or lipase, which are enzymes typically associated with pancreatic function. Elevated levels of these biomarkers may suggest a condition such as pancreatitis or other pancreatic disorders. It's important to consult with your healthcare provider for further assessment and potential diagnostic imaging. Additional tests may be recommended to assess the extent of pancreatic involvement and guide treatment options. Managing risk factors such as alcohol use, high-fat diet, and obesity can help maintain pancreatic health. In the case of pancreatitis, treatment may involve hospitalization, hydration, pain management, and dietary modifications.",
                importance: 3
            ),
            // Metabolic rule
            PlasmaRule (
                id: 33,
                references: [Reference(hyperlink: "https://www.msdmanuals.com/professional/endocrine-and-metabolic-disorders/acid-base-regulation-and-disorders/metabolic-acidosis")],
                authors: [Aksana],
                biomarkerIds:  [BiomarkerId.ketones, BiomarkerId.anionGap,BiomarkerId.hba1c, BiomarkerId.glucose, BiomarkerId.lactate, BiomarkerId.creatinine, BiomarkerId.bloodUreaNitrogen] ,
                evaluate: { values in
                    // Extract values for each biomarker
                    let ketones = values.first(where: { $0.biomarkerId == BiomarkerId.ketones })
                    let anionGap = values.first(where: { $0.biomarkerId == BiomarkerId.anionGap })
                    let hba1c = values.first(where: { $0.biomarkerId == BiomarkerId.hba1c })
                    let glucose = values.first(where: { $0.biomarkerId == BiomarkerId.glucose })
                    let lactate = values.first(where: { $0.biomarkerId == BiomarkerId.lactate })
                    let creatinine = values.first(where: { $0.biomarkerId == BiomarkerId.creatinine })
                    let bloodUreaNitrogen = values.first(where: { $0.biomarkerId == BiomarkerId.bloodUreaNitrogen })
                    
                    // Check for elevated levels
                    let isElevated = (
                        ketones?.range == PlasmaRange.elevated ||
                        anionGap?.range == PlasmaRange.elevated ||
                        hba1c?.range == PlasmaRange.elevated ||
                        glucose?.range == PlasmaRange.elevated ||
                        lactate?.range == PlasmaRange.elevated ||
                        creatinine?.range == PlasmaRange.elevated ||
                        bloodUreaNitrogen?.range == PlasmaRange.elevated
                    )
                    
                    // Return true if any of the biomarkers are elevated
                    return isElevated
                },
                message: "Your test results suggest elevated levels of certain biomarkers, which may indicate an underlying metabolic imbalance, kidney dysfunction, or disturbances in glucose regulation. These changes could be associated with conditions such as diabetic ketoacidosis, kidney disease, or other metabolic disorders. It is important to consult with your healthcare provider for further evaluation and appropriate treatment. Timely intervention and management can help address the underlying cause, potentially improving outcomes and preventing complications.",
                importance: 3
            )])
    }
}
