//
//  StatisticViewController.swift
//  PocketTrainer
//
//  Created by Misha on 18.05.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import UIKit

struct UserParametr : Codable {
    
    var userHeight: String
    var userWeight: String
    var userGender: Int
    var userAge: String
    var lifeStyle: Int
}
struct LifeStyle {
    var name: String
    var ratio: Double
}

class StatisticViewController: UIViewController {

    @IBOutlet weak var userHeightTextField: UITextField!
    @IBOutlet weak var userWeightField: UITextField!
    @IBOutlet weak var userAgeTextField: UITextField!
    @IBOutlet weak var userGenderSC: UISegmentedControl!
    @IBOutlet weak var caloriesRSK: UILabel!
    @IBOutlet weak var dailyCaloriesLabel: UILabel!
    
    @IBOutlet weak var carbohydratesLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var lifeStylePicker: UIPickerView!
    let lifeStyle: [LifeStyle] = [LifeStyle(name: "Сидячий", ratio: 1.0),
                                  LifeStyle(name: "Низкая активность", ratio: 1.12),
                                  LifeStyle(name: "Активный", ratio: 1.27),
                                  LifeStyle(name: "Очень активный", ratio: 1.54)]
    var ratio: Double = 1
    var today = Date()
    let formatter1 = DateFormatter()
    var userWeight: Double = 0
    var userAge: Double = 0
    var userHeight: Double = 0
    var RSK: Double = 0
    var userParametr: UserParametr = UserParametr(userHeight: "", userWeight: "", userGender: 0, userAge: "", lifeStyle: 0 )
    var dailyCalories: Double = 0
    var dailyFat: Double = 0
    var dailyProtein: Double = 0
    var dailyCarbohydrates: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lifeStylePicker.dataSource = self
        lifeStylePicker.delegate = self
        today = NSDate() as Date
        
        if let data = UserDefaults.standard.value(forKey:"user") as? Data {
       
            let userPar = try? PropertyListDecoder().decode(UserParametr.self, from: data)
            userParametr = userPar ?? UserParametr(userHeight: "", userWeight: "", userGender: 0, userAge: "", lifeStyle: 0 )
        }
        userHeightTextField.text = userParametr.userHeight
        userWeightField.text = userParametr.userWeight
        userAgeTextField.text = userParametr.userAge
        userGenderSC.selectedSegmentIndex = userParametr.userGender
        lifeStylePicker.selectRow(userParametr.lifeStyle, inComponent: 0, animated: true)
        ratio = lifeStyle[userParametr.lifeStyle].ratio
        calculateRSK()
        userHeightTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        userWeightField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        userAgeTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        userGenderSC.addTarget(self, action: #selector(textFieldDidChange), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first as? UITouch{
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    override func viewWillAppear(_ animated: Bool) {
        if let data = UserDefaults.standard.value(forKey:"simulationConfiguration") as? Data {
            let eatenFood2 = try? PropertyListDecoder().decode(Array<Food>.self, from: data)
            var eatenFood = eatenFood2 ?? []
            if eatenFood.count != 0{
                if eatenFood[0].date != (formatter1.string(from: today)){
                    eatenFood.removeAll()
                    
                }
                dailyCalories = 0
                for food in eatenFood{
                    dailyCalories += food.calories * Double(food.weight)
                    dailyFat += food.fat * Double(food.weight)
                    dailyProtein += food.protein * Double(food.weight)
                    dailyCarbohydrates += food.carbohydrates * Double(food.weight)
                }
                fatLabel.text = String(Int(round(dailyFat))) + " г"
                proteinLabel.text = String(Int(round(dailyProtein))) + " г"
                carbohydratesLabel.text = String(Int(round(dailyCarbohydrates))) + " г"
                dailyCaloriesLabel.text = String(Int(round(dailyCalories)))  + " ккал " + "( " + String(Int(round(dailyCalories/RSK*100))) + "% )"
            }
            
            //reloadTableView()
        }
    }
    @objc func textFieldDidChange() {
        calculateRSK()
    }
//   Для мужчин:
//
//    TEE = 864 - 9,72 × возраст (лет) + PA × [(14,2 × вес (кг) + 503 × рост (метры)]
//
//    Для женщин:
//
//    TEE = 387 - 7,31 × возраст (лет) + PA × [(10,9 × вес (кг) + 660,7 × рост (метры)]


    func calculateRSK(){
        userParametr.userWeight = userWeightField.text ?? "1"
        userParametr.userHeight = userHeightTextField.text ?? "1"
        userParametr.userAge = userAgeTextField.text ?? "1"
        userParametr.userGender = userGenderSC.selectedSegmentIndex
        userParametr.lifeStyle = lifeStylePicker.selectedRow(inComponent: 0)
        userWeight = Double(userParametr.userWeight) ?? 1.0
        userHeight = Double(userParametr.userHeight) ?? 1.0
        userAge = Double(userParametr.userAge) ?? 1.0
        if userParametr.userGender == 0 {
            RSK = 864 - (9.72 * userAge) + ratio * ( 14.2 * userWeight + 503 * userHeight / 100)
            
        }else{
            RSK = 387 - (7.31 * userAge) + ratio * ( 10.9 * userWeight + 660.7 * userHeight / 100)
        }
        caloriesRSK.text = String(Int(round(RSK)))+" ккал"
        UserDefaults.standard.set(try? PropertyListEncoder().encode(userParametr), forKey:"user")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension StatisticViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
        
    }
}
extension StatisticViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let style = lifeStyle[row]
        return style.name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ratio = lifeStyle[row].ratio
        calculateRSK()
        
    }
}
