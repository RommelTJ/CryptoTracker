//
//  CoinViewController.swift
//  CryptoTracker
//
//  Created by Rommel Rico on 5/20/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit
import SwiftChart

private let chartHeight: CGFloat = 300.0

class CoinViewController: UIViewController {

    var coin: Coin?
    var chart = Chart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        chart.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: chartHeight)
        let series = ChartSeries([0, 6, 2, 8, 4, 7, 3, 10, 8])
        series.color = ChartColors.greenColor()
        chart.add(series)
        view.addSubview(chart)
    }

}
