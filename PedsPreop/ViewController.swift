//
//  ViewController.swift
//  PedsPreop
//
//  Created by David May on 3/23/22.
//

import UIKit

class ViewController: UITableViewController {
    enum Row {
        case weight, sex, startHct, minHct, ageYears, category
    }
    let  rows: [Row] = [.weight, .sex, .startHct, .minHct, .ageYears, .category]
    let playground = Playground()
    override func viewDidLoad() {
        super.viewDidLoad()

      
        playground.test()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch rows[indexPath.row] {
        case .weight: cell.textLabel?.text = "Weight: \(playground.weight)"
        case .sex: cell.textLabel?.text = "Sex: \(playground.sex)"
        case .startHct: cell.textLabel?.text = "Starting Hct: \(playground.startHct)"
        case .minHct: cell.textLabel?.text = "Minimum Hct: \(playground.minHct)"
        case .ageYears: cell.textLabel?.text = "Age: \(playground.ageYears)"
        case .category: cell.textLabel?.text = "Category:\(playground.category)"
        }
        
        return cell
    }
}

class Playground {
    
    var weight: Double = 22
    var sex: String = "Male"
    var startHct: Double = 35
    var minHct: Double = 25
    var ageYears: Int = 5
    var category: String = "Child"
    var maintRate: Double = 0
    var hoursDeficit: Double =  4
    var estimatedFluidDeficit: Double = 0
    var estimatedBloodVolume: Double = 0
    var allowableBloodLoss: Double = 0
    
    func test() {
    //Patient Data (Eventually would like this to be interactive)
   
    
    //category is one of the following...preterm neonate, neonate, infant, toddler, child, teen, adult
    //func test() {
        //    print("Weight \(weight) kg")
        //    print(sex)
        //    print(category)
        
        if weight > 20 {
            maintRate = weight + 40
        }else if weight < 10 {
            maintRate = weight * 4
        }else {
            maintRate = (weight - 10) * 2 + 40
        }
        
        //Fluids and blood calulated results
        
        print("Maintence Fluid Rate: \(round(10*maintRate)/10) ml/hour")
        
        estimatedFluidDeficit = hoursDeficit * maintRate
        
        print("Fluid Deficit: \(estimatedFluidDeficit) ml.")
        
        print("First hour fluid rate: \(round(10 * (maintRate + estimatedFluidDeficit/2))/10) ml/hour.")
        print("Second and third hour fluid rate: \(maintRate + estimatedFluidDeficit/4) ml/hour.")
        
        switch category {
        case "preterm neonate":
            estimatedBloodVolume = 95 * weight
        case "neonate":
            estimatedBloodVolume = 90 * weight
        case "infant":
            estimatedBloodVolume = 80 * weight
        default :
            estimatedBloodVolume = 70 * weight
        }
        print("Estimated blood volume: \(estimatedBloodVolume) ml.")
        
        let averageHct: Double = (startHct+minHct)/2
        
        allowableBloodLoss = estimatedBloodVolume * (startHct - minHct)/averageHct
        print("Starting Hematocrit: \(startHct)")
        print("Minimum Hematocrit: \(minHct)")
        print("")
        print("Allowable blood loss: \(round(allowableBloodLoss)) ml.")
    //}
    //Route Struct
    struct Route {
        //let units: String = "mg/kg"
        let routeName: String
        let lowerLimit: Double
        let upperLimit: Double
        let suggestedDose: Double
        let maxDose: Double?
        let maxDosage: Double? = nil
        let timeToEffect: Int
        let units: String
        let comments: String
        let usualConcentration: Double
        
        
    }
    
    
    //Drug Struct
    struct Drug {
        
        enum  RouteNames {
            
            case iv
            case im
            case intranasal
            case oral
            case rectal
            case interosseus
            case tracheal
            case subCutaneous
            case aeresolized
            case inhalational
            
        }
        let genericName: String
        let commonName: String
        let routes: [RouteNames]
        //for each route in routes {
        let iv: Route
        var im: Route
        var oral: Route
        var intranasal: Route
        var rectal: Route
        //  var subCutaneous: Route
        //   var interosseous: Route
        //  var aerosolized: Route
        //  var ett: Route
        
    }
    
    //Sedation Meds Section
    
    //Midazolam
    let midazolam = Drug(
        genericName: "midazolam",
        commonName: "versed",
        routes: [.iv, .im, .oral, .intranasal,.rectal],
        iv: Route(routeName: "IV", lowerLimit: 0.05, upperLimit: 0.1, suggestedDose: 0.07, maxDose: 6, timeToEffect: 3, units: "mg", comments: "Reduce dosage 30% with conconminate opioid administration.Younger children (ie, < 5 years) may require larger cumulative doses, as high as 0.6 mg/kg or 6 mg.",usualConcentration: 1.0),
        im: Route(routeName: "IM", lowerLimit: 0.1, upperLimit: 0.2, suggestedDose: 0.12, maxDose: 10, timeToEffect: 30, units: "mg", comments: "",usualConcentration: 1.0),
        oral: Route(routeName: "Oral", lowerLimit: 0.5, upperLimit: 1.0, suggestedDose: 0.7, maxDose: 20, timeToEffect: 30, units: "mg", comments: "",usualConcentration: 2.0),
        intranasal: Route(routeName: "Intranasal", lowerLimit: 0.2, upperLimit: 0.6, suggestedDose: 0.3, maxDose: 10, timeToEffect: 10, units: "mg", comments: "",usualConcentration: 5.0),
        rectal: Route(routeName: "Rectal", lowerLimit: 0.3, upperLimit: 0.5, suggestedDose: 0.4, maxDose: 10, timeToEffect: 30, units: "mg", comments: "", usualConcentration: 2.0)
    )
    
    
    print("_______________________________")
    //Ketamine Section
    
    let ketamine = Drug(
        genericName: "Ketamine",
        commonName: "Ketalar",
        routes: [.iv, .im, .oral],
        iv: Route(routeName: "IV", lowerLimit: 1.0, upperLimit: 2.0, suggestedDose: 1.5, maxDose: 200, timeToEffect: 3, units: "mg", comments: "Reduce dosage 30% with conconminate opioid administration.Younger children (ie, < 5 years) may require larger cumulative doses, as high as 0.6 mg/kg or 6 mg.",usualConcentration: 100.0),
        im: Route(routeName: "IM", lowerLimit: 2.0, upperLimit: 5.0, suggestedDose: 3.5, maxDose: 10, timeToEffect: 8, units: "mg", comments: "", usualConcentration: 100),
        oral: Route(routeName: "Oral", lowerLimit: 6, upperLimit: 10.0, suggestedDose: 7.0, maxDose: 500, timeToEffect: 30, units: "mg", comments: "Syrup is 2mg/ml",usualConcentration: 8),
        intranasal: Route(routeName: "Intranasal", lowerLimit: 0.0, upperLimit: 0.0, suggestedDose: 0.0, maxDose: 0, timeToEffect: 0, units: "mg", comments: "", usualConcentration: 100),
        rectal: Route(routeName: "Rectal", lowerLimit: 0.0, upperLimit: 0.0, suggestedDose: 0.0, maxDose: 0, timeToEffect: 0, units: "mg", comments: "Not Applicable", usualConcentration: 50)
    )
    
    print("_______________________________")
    
    //hydrocodoneAcetaminophen Section
    
    let hydrocodoneAcetaminophen = Drug(
        genericName: "hydrocodone Acetaminophen",
        commonName: "Lortab",
        routes: [.oral],
        iv: Route(routeName: "IV", lowerLimit: 0.0, upperLimit: 0.0, suggestedDose: 0.0, maxDose: 0, timeToEffect: 0, units: "mg", comments: "Not Applicable",usualConcentration: 0),
        im: Route(routeName: "IM", lowerLimit: 0.0, upperLimit: 0.0, suggestedDose: 0.0, maxDose: 00, timeToEffect: 0, units: "mg", comments: "",usualConcentration: 0),
        oral: Route(routeName: "Oral", lowerLimit: 0.05, upperLimit: 0.2, suggestedDose: 0.1, maxDose: 10, timeToEffect: 30, units: "mg", comments: "Usual 7.5 mg hydrocodone / 325 mg Acetaminophen per 15 ml (0.5/21.67 per ml). Dose is caclulated on hydrocodone component.", usualConcentration: 0.5),
        intranasal: Route(routeName: "Intranasal", lowerLimit: 0.0, upperLimit: 0.0, suggestedDose: 0.0, maxDose: 0, timeToEffect: 0, units: "mg", comments: "Not Applicable",usualConcentration: 0),
        rectal: Route(routeName: "Rectal", lowerLimit: 0.0, upperLimit: 0.0, suggestedDose: 0.0, maxDose: 0, timeToEffect: 0, units: "mg", comments: "Not Applicable",usualConcentration: 0)
    )
    
    print("_______________________________")
    
    
    //Atropine Section
    
    let atropine = Drug(
        genericName: "atropine",
        commonName: "Atropine",
        routes: [.oral,.im,.iv],
        iv: Route(routeName: "IV", lowerLimit: 10.0, upperLimit: 20.0, suggestedDose: 10.0, maxDose: 400, timeToEffect: 2, units: "mcg", comments: "", usualConcentration: 400),
        im: Route(routeName: "IM", lowerLimit: 10.0, upperLimit: 20.0, suggestedDose: 10.0, maxDose: 400, timeToEffect: 5, units: "mcg", comments: "",usualConcentration: 400),
        oral: Route(routeName: "Oral", lowerLimit: 15.0, upperLimit: 40.0, suggestedDose: 25.0, maxDose: 2, timeToEffect: 30, units: "mcg", comments: "Mix injectable in sweet liquid (0.2-0.3ml/kg) to administer orally", usualConcentration: 400),
        intranasal: Route(routeName: "Intranasal", lowerLimit: 0.0, upperLimit: 0.0, suggestedDose: 0.0, maxDose: 0, timeToEffect: 0, units: "mg", comments: "N/A", usualConcentration: 0),
        rectal: Route(routeName: "Rectal", lowerLimit: 40.0, upperLimit: 40.0, suggestedDose: 40.0, maxDose: 30, timeToEffect: 0, units: "mcg", comments: "Not Applicable",usualConcentration: 0)
    )
    
    let dexmedetomidine = Drug(
        genericName: "dexmedetomidine",
        commonName: "Precedex",
        routes: [.intranasal,.im,.iv, .oral],
        iv: Route(routeName: "IV", lowerLimit: 0.5, upperLimit: 1.5, suggestedDose: 0.7, maxDose: 0, timeToEffect: 10, units: "mcg", comments: "Can cause bradycardia / hypotension, Respiratory drive remains intact, Give slowly over 10 minutes", usualConcentration: 100),
        im: Route(routeName: "IM", lowerLimit: 0.5, upperLimit: 1.5, suggestedDose: 1.0, maxDose: 0, timeToEffect: 15, units: "mcg", comments: "Can cause bradycardia / hypotension, Respiratory drive remains intact",usualConcentration: 100),
        oral: Route(routeName: "Oral", lowerLimit: 1.0, upperLimit: 5.0, suggestedDose: 4.0, maxDose: 0, timeToEffect: 40, units: "mcg", comments: "Can cause bradycardia / hypotension, Respiratory drive remains intact. Long onset time. Oral preparation not commercially available", usualConcentration: 100),
        intranasal: Route(routeName: "Intranasal", lowerLimit: 1.0, upperLimit: 4.0, suggestedDose: 2.0, maxDose: 0, timeToEffect: 15, units: "mcg", comments: "Can cause bradycardia / hypotension, Respiratory drive remains intact", usualConcentration: 100),
        rectal: Route(routeName: "Rectal", lowerLimit: 0.0, upperLimit: 0.0, suggestedDose: 0.0, maxDose: 0, timeToEffect: 0, units: "mg", comments: "Not Applicable",usualConcentration: 0)
    )
    
    let acetaminophen = Drug(
        genericName: "acetaminophen",
        commonName: "Tylenol",
        routes: [.rectal, .iv, .oral],
        iv: Route(routeName: "IV", lowerLimit: 10, upperLimit: 15, suggestedDose: 12.5, maxDose: 750, timeToEffect: 10, units: "mg", comments: "Ofirmev infuse over 15 minutes", usualConcentration: 10),
        im: Route(routeName: "IM", lowerLimit: 0, upperLimit: 0, suggestedDose: 0, maxDose: 0, timeToEffect: 0, units: "mg", comments: "N/A",usualConcentration: 0),
        oral: Route(routeName: "Oral", lowerLimit: 10.0, upperLimit: 15.0, suggestedDose: 12.5, maxDose: 60, timeToEffect: 40, units: "mg", comments: "Remember to accout for other sources (eg lortab)", usualConcentration: 32),
        intranasal: Route(routeName: "Intranasal", lowerLimit: 0, upperLimit: 0, suggestedDose: 0, maxDose: 0, timeToEffect: 0, units: "mg", comments: "N/A",usualConcentration: 0),
        rectal: Route(routeName: "Rectal", lowerLimit: 10.0, upperLimit: 15.0, suggestedDose: 12.5, maxDose: 60, timeToEffect: 40, units: "mg", comments: "Remember to accout for other sources (eg lortab)", usualConcentration: 0)
    )
    
    let clonidine = Drug(
        genericName: "clonidine",
        commonName: "Catapress",
        routes: [.intranasal,.im,.iv, .oral],
        iv: Route(routeName: "IV", lowerLimit: 1.0, upperLimit: 2.0, suggestedDose: 1.5, maxDose: 0, timeToEffect: 10, units: "mcg", comments: "Can cause bradycardia / hypotension, Respiratory drive remains intact", usualConcentration: 100),
        im: Route(routeName: "IM", lowerLimit: 2, upperLimit: 2, suggestedDose: 2, maxDose: 0, timeToEffect: 20, units: "mcg", comments: "Can cause bradycardia / hypotension, Respiratory drive remains intact",usualConcentration: 100),
        oral: Route(routeName: "Oral", lowerLimit: 4.0, upperLimit: 5.0, suggestedDose: 4.5, maxDose: 0, timeToEffect: 40, units: "mcg", comments: "Can cause bradycardia / hypotension, Respiratory drive remains intact", usualConcentration: 100),
        intranasal: Route(routeName: "Intranasal", lowerLimit: 2.0, upperLimit: 4.0, suggestedDose: 3.0, maxDose: 0, timeToEffect: 15, units: "mcg", comments: "Can cause bradycardia / hypotension, Respiratory drive remains intact", usualConcentration: 100),
        rectal: Route(routeName: "Rectal", lowerLimit: 2.5, upperLimit: 5, suggestedDose: 4, maxDose: 0, timeToEffect: 0, units: "mcg", comments: "Can cause bradycardia / hypotension, Respiratory drive remains intact",usualConcentration: 0)
    )
    
    var drugName = [atropine, midazolam, hydrocodoneAcetaminophen, ketamine, dexmedetomidine, acetaminophen]
    for name in drugName {
        
        print("")
        print(name.genericName.capitalized)
        
        for route in name.routes {
            let currentRoute  = route
            
            switch (currentRoute) {
            case .iv:
                print("")
                print("IV Dosage: \(round(100*name.iv.suggestedDose*weight)/100) \(name.iv.units)      Range (\(name.iv.lowerLimit) \(name.iv.units)/kg - \(name.iv.upperLimit) \(name.iv.units)/kg): \(round(100*name.iv.lowerLimit*weight)/100) - \(round(100*name.iv.upperLimit*weight)/100) \(name.iv.units)")
            case .im:
                print("")
                print("IM Dosage: \(round(100*name.im.suggestedDose*weight)/100) \(name.im.units)      Range (\(name.im.lowerLimit) \(name.im.units)/kg - \(name.im.upperLimit) \(name.im.units)/kg): \(round(100*name.im.lowerLimit*weight)/100) - \(round(100*name.im.upperLimit*weight)/100) \(name.im.units)")
            case .oral:
                print("")
                print("Oral Dosage: \(round(100*name.oral.suggestedDose*weight)/100) \(name.oral.units)      Range (\(name.oral.lowerLimit) \(name.oral.units)/kg - \(name.oral.upperLimit) \(name.oral.units)/kg): \(round(100*name.oral.lowerLimit*weight)/100) - \(round(100*name.oral.upperLimit*weight)/100) \(name.oral.units)")
                print("      \((round(100*name.oral.suggestedDose*weight)/name.oral.usualConcentration)/100) ml of \(name.oral.usualConcentration) \(name.oral.units) per ml \(name.commonName.capitalized) preparation.")
                print("      \(name.oral.comments)")
                
            case .intranasal:
                print("")
                print("Intranasal Dosage: \(round(100*name.intranasal.suggestedDose*weight)/100) \(name.intranasal.units)      Range (\(name.intranasal.lowerLimit) \(name.intranasal.units)/kg - \(name.intranasal.upperLimit) \(name.intranasal.units)/kg): \(round(100*name.intranasal.lowerLimit*weight)/100) - \(round(100*name.intranasal.upperLimit*weight)/100) \(name.intranasal.units)")
            case .rectal:
                print("")
                print("Rectal Dosage: \(round(100*name.rectal.suggestedDose*weight)/100) \(name.rectal.units)      Range (\(name.rectal.lowerLimit) \(name.rectal.units)/kg - \(name.rectal.upperLimit) \(name.rectal.units)/kg): \(round(100*name.rectal.lowerLimit*weight)/100) - \(round(100*name.rectal.upperLimit*weight)/100) \(name.rectal.units)")
            default:
                print("default")
            }
            
        }
        print("_______________________________")
        
    }
}
}
