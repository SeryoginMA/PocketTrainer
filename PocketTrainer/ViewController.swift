//
//  ViewController.swift
//  PocketTrainer
//
//  Created by Misha on 02.03.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var exerciseName: UILabel!
    
    var counter = 0
    var imageName = ""
    var exerciseTitle = ""
    var exerciseDescription = ""
    var timer = Timer()
    var imageName2 = ""
    var training: Training = Training(group: "", exerciseName: "", image: "", majorMuscles: "", extraMuscles: "", complexityOfImplementation: "", equipment: "", description: "", calories: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let data = UserDefaults.standard.value(forKey:"training") as? Data {
            let training2 = try? PropertyListDecoder().decode(Array<Training>.self, from: data)
            for train in training2 ?? []{
                if train.exerciseName == exerciseTitle{
                    imageName = train.image
                    exerciseTitle = train.exerciseName
        
                    descriptionText.text = "Основные мышцы: " + train.majorMuscles + "\n" + "Дополнительные мышцы: " + train.extraMuscles + "\n" + "Сложность упражнения: " + train.complexityOfImplementation + "\n" + "Оборудование: " + train.equipment + "\n" + "\n" + train.description
                    
                    exerciseName.text = train.exerciseName
                    
                }
            }
        }
        
        //exerciseName.text = exerciseTitle
        image1.image = UIImage(named: imageName)
        imageName2 = imageName.replacingOccurrences(of: "image", with: "image2", options: .literal, range: nil)
        timer.invalidate() // just in case this button is tapped multiple times
            // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
        
    }

    
    @objc func timerAction() {
        if counter == 0{
            image1.image = UIImage(named:imageName2)
            counter+=1
        }
        else{
            image1.image = UIImage(named: imageName)
            counter-=1
        }
        
        
    }
}
