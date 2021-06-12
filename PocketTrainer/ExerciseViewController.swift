//
//  ExerciseViewController.swift
//  PocketTrainer
//
//  Created by Misha on 02.03.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import UIKit
class TrainingCell: UITableViewCell {
    @IBOutlet weak var exerciseQuantity: UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    
}
class ExerciseViewController: UIViewController {

    @IBOutlet weak var groupName: UINavigationItem!
    @IBOutlet weak var exerciseTable: UITableView!
    let file = "training.txt"
    var showOrAdd = "show"
    var trainingArray : [[String]] = []
    var indexOfBtn = 0
    var isTraining = false
    var canEdit : Bool = false
    var name = ""
    var nameAddTraining : String = ""
    var text = ""
    var arrayExercise : [String] = []
    
    @IBOutlet weak var addExerciseButton: UIButton!
    
    @IBOutlet weak var addExerBtn: UIBarButtonItem!
    

    
    @IBAction func addExerciseAction(_ sender: Any) {
    }
    override func viewDidLoad() {
            super.viewDidLoad()
            exerciseTable.delegate = self
            exerciseTable.dataSource = self
            groupName.title = name
            
        addExerBtn.isEnabled = canEdit
        }
    override func viewWillAppear(_ animated: Bool) {
        if isTraining{
            arrayExercise = []
            
        }
        trainingArray = []

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(file)


            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                print(text2)
                let line = text2.components(separatedBy: "\n")
                print("/n /n ", line)
                for i in 0...line.count-1{
                    trainingArray.append(line[i].components(separatedBy: ", "))
                    
                    if trainingArray[i][0] == name && isTraining{
                        arrayExercise = trainingArray[i]
                        arrayExercise.remove(at: 0)
                        exerciseTable.reloadData()
                    }
                }
            }
            catch {/* error handling here */}
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ViewController{
            dest.exerciseTitle = text
        }
        if let dest = segue.destination as? GroupOfExerciseViewController{
            dest.showOrAdd = "add"
            dest.nameAddTraining = name
        }
        
        if let dest = segue.destination as? addApproachViewController {
            
            dest.exerciseName = arrayExercise[indexOfBtn]
            }
        }
    func okButton(index: Int){
        for training in 0...trainingArray.count-1{
            if trainingArray[training][0] == nameAddTraining{
                trainingArray[training].append(arrayExercise[index])
            }
        }
        saveEdit()
    }
    func saveEdit() {
        var sentense : String = ""
        for elem in 0...trainingArray.count-1{
            for word in 0...trainingArray[elem].count-1{
                sentense += trainingArray[elem][word]
                if word != trainingArray[elem].count-1{
                   sentense += ", "
                }
            }
            if elem != trainingArray.count-1{
                sentense += "\n"
            }
        }
        
        print(sentense)

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            //writing
            do {
                try sentense.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}
            }
    }

}

    extension ExerciseViewController: UITableViewDelegate{
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if showOrAdd == "show" {
                text = arrayExercise[indexPath.row]
                performSegue(withIdentifier: "goToEx", sender: nil)
            }
            else{
                
                let alert = UIAlertController(title: nil, message: "Добавить упражнение в тренировку?", preferredStyle: .alert)
                let okBtn = UIAlertAction(title: "Да", style: .default) { (UIAlertAction) in
                    for training in 0...self.trainingArray.count-1{
                        if self.trainingArray[training][0] == self.nameAddTraining{
                            self.trainingArray[training].append(self.arrayExercise[indexPath.row])
                        }
                    }
                    self.saveEdit()
                }
                let cancelBtn = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
                alert.addAction(okBtn)
                alert.addAction(cancelBtn)
                present(alert, animated: true, completion: nil)
        
            }
            }
        
       }
    

    extension ExerciseViewController: UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrayExercise.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "exercise", for: indexPath) as! TrainingCell
            
            cell.textLabel?.text = arrayExercise[indexPath.row]
            cell.textLabel?.textAlignment = NSTextAlignment.center
//            cell.exerciseQuantity.text = "qweqwe"
            cell.addBtn.tag = indexPath.row
            cell.addBtn.addTarget(self, action: #selector(rowButtonWasTapped(sender:)), for: .touchUpInside)
            
            exerciseTable.separatorStyle = .none
            return cell
        }
        @objc
        func rowButtonWasTapped(sender:UIButton){
            let rowIndex:Int = sender.tag
            indexOfBtn = rowIndex
            performSegue(withIdentifier: "addApproachSegue", sender: nil)
        }
        
        func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            if canEdit == true {
                return .delete
            }
            return .none
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete{
                tableView.beginUpdates()
                for i in 0...trainingArray.count-1{
                    if trainingArray[i][0] == name {
                        trainingArray[i].remove(at: indexPath.row + 1)
                        break
                    }
                }
                arrayExercise.remove(at: indexPath.row)
                //trainingArray[ind].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
                print(trainingArray)
                
                saveEdit()
            }
        }
    }

