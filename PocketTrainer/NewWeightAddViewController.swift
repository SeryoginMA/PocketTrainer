//
//  NewWeightAddViewController.swift
//  PocketTrainer
//
//  Created by Misha on 09.03.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import UIKit

class NewWeightAddViewController: UIViewController {
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var dateView: UIDatePicker!
    var weightText = ""
    var weightArray = [["1","2"]
    ]
    
    var today = Date()
    let formatter1 = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter1.dateStyle = .short
        
        weightArray.append(["95","3/8/21"])
        weightArray.append(["85","3/6/21"])
        dateView.addTarget(self, action: #selector(datePickerChanged(dateView:)), for: .valueChanged)
        view.addSubview(dateView)
    }
    
    
    @IBAction func addWeightButton(_ sender: UIButton) {
        today = dateView.date
        weightArray.append([weight.text!,formatter1.string(from: today)])
        print(weightArray)
//        if let dest = segue.destination as? WeightViewController{
//            dest.name = text
//            for i in 0...(globalArray.count-1){
//                if globalArray[i][0] == text{
//                    dest.arrayExercise.append(globalArray[i])
//                }
//            }
//
//        }
        
        dismiss(animated: true) {
            
        }
    }
    @objc func datePickerChanged(dateView: UIDatePicker) {
        for i in 0...weightArray.count-1{
            if (weightArray[i][1] == formatter1.string(from: dateView.date)){
                weight.text = weightArray[i][0]
                print("yra")
            }
        }
    }
}
