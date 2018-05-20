//
//  CryptoTableViewController.swift
//  CryptoTracker
//
//  Created by Rommel Rico on 5/16/18.
//  Copyright © 2018 Rommel Rico. All rights reserved.
//

import UIKit

class CryptoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CoinData.shared.getPrices()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoinData.shared.coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let coin = CoinData.shared.coins[indexPath.row]
        cell.textLabel?.text = coin.symbol
        cell.imageView?.image = coin.image
        return cell
    }

}
