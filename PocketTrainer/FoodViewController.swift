//
//  FoodViewController.swift
//  PocketTrainer
//
//  Created by Misha on 14.05.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController {
    var eatenFood: [Food] = []
    //var eatenAllFood: [Food] = []
    @IBOutlet weak var eatenFoodTable: UITableView!
    //@IBOutlet weak var eatDatePicker: UIDatePicker!
    var today = Date()
    let formatter1 = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        today = NSDate() as Date
        eatenFoodTable.delegate = self
        eatenFoodTable.dataSource = self
        if let data = UserDefaults.standard.value(forKey:"simulationConfiguration") as? Data {
            let eatenFood2 = try? PropertyListDecoder().decode(Array<Food>.self, from: data)
            eatenFood = eatenFood2 ?? []
            if eatenFood.count != 0{
                if eatenFood[0].date != (formatter1.string(from: today)){
                    eatenFood.removeAll()
                    
                }
            }
            //reloadTableView()
        }
//        eatDatePicker.addTarget(self, action: #selector(datePickerChanged(dateView:)), for: .valueChanged)
//        view.addSubview(eatDatePicker)
    }
//    @objc func datePickerChanged(dateView: UIDatePicker) {
//        reloadTableView()
//    }
//    func reloadTableView(){
//        eatenFood = []
//
//        for food in eatenAllFood{
//
//            if (formatter1.string(from: eatDatePicker.date)) == food.date{
//                eatenFood.append(food)
//            }
//        }
//        eatenFoodTable.reloadData()
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFoodDetail"{
            if let indexPath = eatenFoodTable.indexPathForSelectedRow{
                let detailVC = segue.destination as! FoodDetailViewController
                detailVC.food = eatenFood[indexPath.row]
                let index = indexPath.row
                
                detailVC.completion = { weight in
                    if weight != "delete"{
                        self.eatenFood[index].weight = Int(weight) ?? 1
                        self.eatenFoodTable.reloadData()
                        self.saveEatenList()
                    }else{
                        
                        self.eatenFood.remove(at: index)
                        self.eatenFoodTable.reloadData()
                        self.saveEatenList()
                        
                    }
                }
            }
            
        }
        if segue.identifier == "goToFoodList" {
            if let selectVC = segue.destination as? FoodListTVC{
                selectVC.completion = { addFood in
                    for food in addFood{
                        self.eatenFood.append(food)
                        self.saveEatenList()
                        self.eatenFoodTable.reloadData()
                        print("asdasd")
                        }
                    }
                }
            }
    }
    func saveEatenList(){

        UserDefaults.standard.set(try? PropertyListEncoder().encode(eatenFood), forKey:"simulationConfiguration")

    }

}
extension FoodViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   }

}
extension FoodViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eatenFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eatenFoodCell", for: indexPath)
        
        let food = eatenFood[indexPath.row]
        
        cell.textLabel?.text = food.name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.detailTextLabel?.text = String(food.weight)+"г, " + String(Int(round(Double(food.weight) * food.calories))) + "ккал"
        
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            eatenFood.remove(at: indexPath.row)
//            let foodDelet = eatenFood[indexPath.row]
//            for i in 0...eatenAllFood.count-1{
//                let food = eatenAllFood[i]
//                if food.name == foodDelet.name && food.weight == foodDelet.weight && food.date == foodDelet.date{
//                    eatenAllFood.remove(at: i)
//                    break
//                }
//            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveEatenList()
            tableView.endUpdates()
        }
    }
}


