//
//  FoodVCViewController.swift
//  PocketTrainer
//
//  Created by Misha on 14.05.2021.
//  Copyright © 2021 Misha. All rights reserved.
//

import UIKit

class FoodVC: UIViewController {

    let eatenFood: [Food] = []
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return eatenFood.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let food = eatenFood[indexPath.row]
        
        cell.textLabel?.text = food.name
        cell.detailTextLabel?.text = String(food.weight)+"г"
        
        return cell
    }

    

    

}
