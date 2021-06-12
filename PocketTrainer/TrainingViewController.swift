//
//  TrainingViewController.swift
//  PocketTrainer
//
//  Created by Misha on 26.03.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {
        var text = ""
        var trainingArray : [[String]] = []
        var trainingNameArray : [String] = []
        var trainingExercise : [String] = []
    
    
        @IBOutlet weak var trainingTable: UITableView!
            

        override func viewDidLoad() {
            super.viewDidLoad()
            trainingTable.delegate = self
            trainingTable.dataSource = self
        }
   
        override func viewWillAppear(_ animated: Bool) {
            trainingArray = []
            let file = "training.txt"
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

                let fileURL = dir.appendingPathComponent(file)


                do {
                    
                    let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                    
                    var line = text2.components(separatedBy: "\n")
                    if line[0] == ""{
                        line.remove(at: 0)
                    }
                    for i in 0...line.count-1{
                        trainingArray.append(line[i].components(separatedBy: ", "))
                    }
                    trainingTable.reloadData()
                }
                catch {/* error handling here */}
            }
        }
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let dest = segue.destination as? ExerciseViewController{
                dest.name = text
                dest.isTraining = true
                dest.arrayExercise = []
                dest.canEdit = true
                }
            if segue.identifier == "addNewTraining" {
                if let selectVC = segue.destination as? addTrainingViewController{
                    selectVC.completion = { nameTraining in
                        self.viewWillAppear(true)
                        }
                    }
                }
            }
            
        }
    extension TrainingViewController: UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            text = trainingArray[indexPath.row][0]
            performSegue(withIdentifier: "goToPlan", sender: nil)
       }

    }
    extension TrainingViewController: UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return trainingArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "trainingTableCell", for: indexPath)
            cell.textLabel?.text = trainingArray[indexPath.row][0]
            cell.textLabel?.textAlignment = NSTextAlignment.center
            
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            trainingTable.separatorStyle = .none
            return cell
        }
        
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                tableView.beginUpdates()
                trainingArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                print(trainingArray)
                
                var sentence : String = ""
                if trainingArray.count != 0 {
                    for elem in 0...trainingArray.count-1{
                        for word in 0...trainingArray[elem].count-1{
                            sentence += trainingArray[elem][word]
                            if word != trainingArray[elem].count-1{
                               sentence += ", "
                            }
                            
                        }
                        if elem != trainingArray.count-1{
                            sentence += "\n"
                        }
                    }
                    
                }
                
                let file = "training.txt" //this is the file. we will write to and read from it

                if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = dir.appendingPathComponent(file)

                        
                    do {
                        try sentence.write(to: fileURL, atomically: false, encoding: .utf8)
                    }
                    catch {/* error handling here */}
                }

        }
        
    }
    }
