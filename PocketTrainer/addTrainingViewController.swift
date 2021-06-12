//
//  addTrainingViewController.swift
//  PocketTrainer
//
//  Created by Misha on 05.03.2021.
//  Copyright © 2021 Misha. All rights reserved.
//
import UIKit
import Charts


class addTrainingViewController: UIViewController{
    
    @IBOutlet weak var nameNewTraining: UITextField!
    var completion: ((String) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTrainingButton(_ sender: Any) {
        if nameNewTraining.text != ""{
            let file = "training.txt" //this is the file. we will write to and read from it
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

                let fileURL = dir.appendingPathComponent(file)
                //reading
                do {
                    let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                    try (text2+"\n"+nameNewTraining.text!.capitalized).write(to: fileURL, atomically: false, encoding: .utf8)
                    
                }
                catch {/* error handling here */}
            }
            completion?(nameNewTraining.text!.capitalized)
            dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: nil, message: "Название тренировки не может быть пустым", preferredStyle: .alert)
            
            let cancelBtn = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
          
            alert.addAction(cancelBtn)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
}
