//
//  WeightViewController.swift
//  PocketTrainer
//
//  Created by Misha on 05.03.2021.
//  Copyright © 2021 Misha. All rights reserved.
//
import UIKit
import Charts


class WeightViewController: UIViewController, ChartViewDelegate{
    var lineChart = LineChartView()
    
    var weightArray = [[85,1],
                       [84,2],
                       [83,3],
                       [84,4],
                       [84,5],
                       [83,7],
                       [82,8],]
    
    @IBOutlet weak var textWeight: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.width)
        lineChart.center = view.center
        
        view.addSubview(lineChart)
        
        
        var entries = [ChartDataEntry]()
        for i in 0...weightArray.count-1{
            entries.append(ChartDataEntry(x: Double(weightArray[i][1]),
                                          y: Double(weightArray[i][0])))
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        
        let data = LineChartData(dataSet: set)
        
        lineChart.data = data
    }
    
    
}
