//
//  CryptoTableViewController.swift
//  CryptoTracker
//
//  Created by Rommel Rico on 5/16/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit

private let headerHeight: CGFloat = 100.0
private let netWorthHeight: CGFloat = 45.0
private let amountHeight: CGFloat = headerHeight - netWorthHeight

class CryptoTableViewController: UITableViewController, CoinDataDelegate {

    var amountLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoinData.shared.getPrices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CoinData.shared.delegate = self
        tableView.reloadData()
        displayNetWorth()
    }
    
    func createHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: headerHeight))
        headerView.backgroundColor = .white
        
        let netWorthLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: netWorthHeight))
        netWorthLabel.text = "My Crypto Net Worth"
        netWorthLabel.textAlignment = .center
        headerView.addSubview(netWorthLabel)
        
        amountLabel.frame = CGRect(x: 0, y: netWorthHeight, width: view.frame.size.width, height: amountHeight)
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: 60)
        headerView.addSubview(amountLabel)
        
        displayNetWorth()
        
        return headerView
    }
    
    func displayNetWorth() {
        amountLabel.text = CoinData.shared.netWorthAsString()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoinData.shared.coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let coin = CoinData.shared.coins[indexPath.row]
        if coin.amount != 0.0 {
            cell.textLabel?.text = "\(coin.symbol) - \(coin.priceAsString()) - \(coin.amount)"
        } else {
            cell.textLabel?.text = "\(coin.symbol) - \(coin.priceAsString())"
        }
        cell.imageView?.image = coin.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinVC = CoinViewController()
        coinVC.coin = CoinData.shared.coins[indexPath.row]
        navigationController?.pushViewController(coinVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createHeaderView()
    }
    
    // MARK: - Coin data delegate
    
    func newPrices() {
        self.tableView.reloadData()
        displayNetWorth()
    }

}
