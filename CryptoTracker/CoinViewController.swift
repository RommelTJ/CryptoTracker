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
private let imageSize: CGFloat = 100.0
private let priceLabelHeight: CGFloat = 25.0

class CoinViewController: UIViewController, CoinDataDelegate {

    var coin: Coin?
    var chart = Chart()
    var priceLabel: UILabel = UILabel()
    var youOwnLabel = UILabel()
    var worthLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let coin = coin {
            CoinData.shared.delegate = self
            coin.getHistoricalData()
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
            
            title = coin.symbol
            view.backgroundColor = .white
            edgesForExtendedLayout = []
            
            chart.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: chartHeight)
            chart.yLabelsFormatter = { CoinData.shared.doubleToMoneyString(double: $1) }
            chart.xLabels = [30, 25, 20, 15, 10, 5, 0]
            chart.xLabelsFormatter = { String(Int(round(30 - $1))) + "d" }
            view.addSubview(chart)
            
            let imageView = UIImageView(frame: CGRect(x: view.frame.size.width/2 - imageSize/2, y: chartHeight, width: imageSize, height: imageSize))
            imageView.image = coin.image
            view.addSubview(imageView)
            
            priceLabel.frame = CGRect(x: 0, y: chartHeight + imageSize, width: view.frame.size.width, height: priceLabelHeight)
            priceLabel.textAlignment = .center
            view.addSubview(priceLabel)
            
            youOwnLabel.frame = CGRect(x: 0, y: chartHeight + imageSize + priceLabelHeight * 2, width: view.frame.size.width, height: priceLabelHeight)
            youOwnLabel.font = UIFont.boldSystemFont(ofSize: 20)
            youOwnLabel.textAlignment = .center
            view.addSubview(youOwnLabel)
            
            worthLabel.frame = CGRect(x: 0, y: chartHeight + imageSize + priceLabelHeight * 3, width: view.frame.size.width, height: priceLabelHeight)
            worthLabel.font = UIFont.boldSystemFont(ofSize: 20)
            worthLabel.textAlignment = .center
            view.addSubview(worthLabel)
            
            newPrices()
        }
    }
    
    @objc func editTapped() {
        if let coin = coin {
            let alert = UIAlertController(title: "How much \(coin.symbol) do you own?", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "0.5"
                textField.keyboardType = .decimalPad
                if self.coin?.amountAsString() != "0.0" {
                    textField.placeholder = String(coin.amount)
                }
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                if let text = alert.textFields?.first?.text {
                    if let amount = Double(text) {
                        self.coin?.amount = amount
                        UserDefaults.standard.set(amount, forKey: coin.symbol + "amount")
                        self.newPrices()
                    }
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - CoinDataDelegate
    
    func newHistory() {
        if let coin = coin {
            let series = ChartSeries(coin.historicalData)
            series.area = true
            chart.add(series)
        }
        
    }
    
    func newPrices() {
        if let coin = coin {
            priceLabel.text = coin.priceAsString()
            youOwnLabel.text = "You own: \(coin.amount) \(coin.symbol)"
            worthLabel.text = coin.amountAsString()
        }
    }

}
