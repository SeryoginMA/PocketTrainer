//
//  FoodListTVC.swift
//  PocketTrainer
//
//  Created by Misha on 14.05.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import UIKit

class FoodListTVC: UIViewController {
    var today = Date()
    let formatter1 = DateFormatter()
    let eatenFood: [Food] = [
        Food(name: "Котлета", weight: 100, fat: 0.14045, protein: 0.1528, calories: 2.450, carbohydrates: 0.13381, date: ""),
        Food(name: "Рис", weight: 100, fat: 0.00532, protein: 0.06064, calories: 3.303, carbohydrates: 0.72789, date: ""),
        Food(name: "Курица вареная", weight: 100, fat: 0.07196, protein: 0.25258, calories: 1.711, carbohydrates: 0, date: ""),
        Food(name: "Каша овсяная на воде", weight: 100, fat: 0.01699, protein: 0.03008, calories: 0.875, carbohydrates: 0.15004, date: ""),
        Food(name: "Яйцо куриное", weight: 100, fat: 0.10877, protein: 0.12764, calories: 1.566, carbohydrates: 0.00934, date: ""),
        Food(name: "Миндаль", weight: 100, fat: 0.5064, protein: 0.2126, calories: 5.780, carbohydrates: 0.1974, date: ""),
        Food(name: "Огурец (с кожурой)", weight: 100, fat: 0.0011, protein: 0.0065, calories: 0.150, carbohydrates: 0.0363, date: ""),
        Food(name: "Шампиньоны", weight: 100, fat: 0.00343, protein: 0.03105, calories: 0.229, carbohydrates: 0.03429, date: ""),
        Food(name: "Макароны", weight: 100, fat: 0.00604, protein: 0.03766, calories: 1.026, carbohydrates: 0.20039, date: ""),
        Food(name: "Лобстер", weight: 100, fat: 0.009, protein: 0.188, calories: 0.900, carbohydrates: 0.005, date: ""),
        Food(name: "Минтай", weight: 100, fat: 0.008, protein: 0.1718, calories: 0.810, carbohydrates: 0, date: ""),
        Food(name: "Скумбрия", weight: 100, fat: 0.0936, protein: 0.1932, calories: 1.670, carbohydrates: 0, date: ""),
        Food(name: "Треска", weight: 100, fat: 0.108, protein: 0.192, calories: 2.110, carbohydrates: 0.0825, date: ""),
        Food(name: "Кета", weight: 100, fat: 0.0377, protein: 0.2014, calories: 1.200, carbohydrates: 0, date: "")
        //Food(name: "Свинина отварная", weight: 100, fat: <#T##Double#>, protein: <#T##Double#>, calories: <#T##Double#>, carbohydrates: <#T##Double#>),
//        Food(name: <#T##String#>, weight: <#T##Int#>, fat: <#T##Double#>, protein: <#T##Double#>, calories: <#T##Double#>, carbohydrates: <#T##Double#>),
    ]
    private var searchFood = [Food]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool{
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    private var isFiltering: Bool{
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var completion: (([Food]) -> ())?
    var addFood:[Food] = []
    @IBOutlet weak var FoodListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        today = NSDate() as Date
        FoodListTableView.delegate = self
        FoodListTableView.dataSource = self
        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Найти"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
   
    
    
    @IBAction func saveEatenFoodBut(_ sender: Any) {
        completion?(addFood)
        navigationController?.popViewController(animated: true)
    }

}
extension FoodListTVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let food: Food
//        if isFiltering{
//            food = searchFood[indexPath.row]
//        }else{
//            food = eatenFood[indexPath.row]
//        }
//    
//        addFood.append(food)
//        print(addFood)
        if let cell = tableView.cellForRow(at: indexPath) {

            if cell.accessoryType == .none{
                var food: Food
                if isFiltering{
                    food = searchFood[indexPath.row]
                }else{
                    food = eatenFood[indexPath.row]
                }
                food.date = (formatter1.string(from: today))
                addFood.append(food)
                print(addFood)
                cell.accessoryType = .checkmark
            }
            
                   

            }
   }

}
extension FoodListTVC: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
            return searchFood.count
        }
        return eatenFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        
        var food: Food
        
        if isFiltering{
            food = searchFood[indexPath.row]
        }else {
            food = eatenFood[indexPath.row]
        }
        
        cell.textLabel?.text = food.name
        cell.detailTextLabel?.text = String(round(food.calories * 100))+"ккал"
        
        return cell
        
    }
}
extension FoodListTVC : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        
    }
    
    private func filterContentForSearchText(_ searchText: String){
        
        searchFood = eatenFood.filter({ (food: Food) -> Bool in
            return food.name.lowercased().contains(searchText.lowercased())
        })
        FoodListTableView.reloadData()
    }
}
