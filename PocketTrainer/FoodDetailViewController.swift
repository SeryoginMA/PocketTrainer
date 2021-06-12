//
//  FoodDetailViewController.swift
//  PocketTrainer
//
//  Created by Misha on 14.05.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController {
    var food :Food!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var fat: UILabel!
    @IBOutlet weak var carbohydrates: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    
    var completion: ((String) -> ())?
    var weight: Double!
    override func viewDidLoad() {
        super.viewDidLoad()

        foodName.text = food.name
        weightTextField.text = String(food.weight)
        editParametr()
        
        weightTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange() {
        editParametr()
        
    }
    @IBAction func saveFoodWeight(_ sender: Any) {
        completion?(weightTextField.text ?? "1")
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteFoodFromEatenList(_ sender: Any) {
        completion?("delete")
        navigationController?.popViewController(animated: true)
    }
    func editParametr(){
        weight = Double(weightTextField.text ?? "1") ?? 1
        
        calories.text = String(round(food.calories * weight))+"ккал"
        fat.text = String(round(100*food.fat * weight)/100)+"г"
        carbohydrates.text = String(round(100*food.carbohydrates * weight)/100)+"г"
        protein.text = String(round(100*food.protein * weight)/100)+"г"
    }
    
}
