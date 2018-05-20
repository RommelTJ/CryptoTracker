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

class CoinViewController: UIViewController, CoinDataDelegate {

    var coin: Coin?
    var chart = Chart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CoinData.shared.delegate = self
        coin?.getHistoricalData()
        
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        chart.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: chartHeight)
        chart.yLabelsFormatter = { CoinData.shared.doubleToMoneyString(double: $1) }
        chart.xLabels = [30, 25, 20, 15, 10, 5, 0]
        chart.xLabelsFormatter = { String(Int(round(30 - $1))) + "d" }
        view.addSubview(chart)
    }
    
    // MARK: - CoinDataDelegate
    
    func newHistory() {
        if let coin = coin {
            let series = ChartSeries(coin.historicalData)
            series.area = true
            chart.add(series)
        }
        
    }

}
