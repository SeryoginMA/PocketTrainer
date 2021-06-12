//
//  addApproachViewController.swift
//  PocketTrainer
//
//  Created by Misha on 17.05.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import UIKit

class addApproachViewController: UIViewController {
    @IBOutlet weak var weightOfApproach: UITextField!
    @IBOutlet weak var quantityOfApproach: UITextField!
    var exercise: [Exercise] = []
    var exerciseAllDate: [Exercise] = []
    var exerciseName: String = ""
    @IBOutlet weak var dateApproach: UIDatePicker!
    var today = Date()
    let formatter1 = DateFormatter()
    @IBOutlet weak var approachTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = exerciseName
        formatter1.dateStyle = .short
        approachTable.delegate = self
        approachTable.dataSource = self
        dateApproach.addTarget(self, action: #selector(datePickerChanged(dateView:)), for: .valueChanged)
        view.addSubview(dateApproach)
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let data = UserDefaults.standard.value(forKey:"exerciseApproach") as? Data {
       
            let exercise2 = try? PropertyListDecoder().decode(Array<Exercise>.self, from: data)
            exerciseAllDate = exercise2 ?? []
            print(dateApproach.date)
            reloadTableView()
        }
    }
    
    @IBAction func addApproachBtn(_ sender: Any) {
        let quantity = Int(quantityOfApproach.text ?? "1") ?? 1
        let weight =  Int(weightOfApproach.text ?? "1") ?? 1

        exerciseAllDate.append(Exercise(name: exerciseName, quantity: quantity, weight: weight, date: (formatter1.string(from: dateApproach.date)) , numOfApproach: exercise.count))
        UserDefaults.standard.set(try? PropertyListEncoder().encode(exerciseAllDate), forKey:"exerciseApproach")
        reloadTableView()
        
    }

    
    @objc func datePickerChanged(dateView: UIDatePicker) {
        reloadTableView()
    }
    func reloadTableView(){
        exercise = []
        print(formatter1.string(from: dateApproach.date))
        print(exercise)
        for exer in exerciseAllDate{

            if exer.name == exerciseName && (formatter1.string(from: dateApproach.date)) == exer.date{
                exercise.append(exer)
            }
        }
        approachTable.reloadData()
    }
}
extension addApproachViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   }

}
extension addApproachViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseApproachCell", for: indexPath)
        
        let exer = exercise[indexPath.row]
        
        cell.textLabel?.text = "#" + String(indexPath.row+1) + ": " + String(exer.weight) + " кг x " + String(exer.quantity) + " повторений"
        
        return cell
    }
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            tableView.beginUpdates()
//            exercise.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            saveEatenList()
//            tableView.endUpdates()
//        }
//    }
}
