//
//  HoldingListViewController.swift
//  UserHoldingScreen
//
//  Created by Preity Singh on 22/02/24.
//

import UIKit

class HoldingListViewController: UIViewController {
    
    @IBOutlet weak var HoldingTableView : UITableView!
    @IBOutlet weak var PortfolioTableView : UITableView!
    
    var model = HoldingsViewModel()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
 }



extension HoldingListViewController {
    
    func config(){
        HoldingTableView.register(UINib(nibName: "HoldingsCellTableViewCell" , bundle: nil), forCellReuseIdentifier: "holdingCell")
        
        PortfolioTableView.register(UINib(nibName: "PortfolioViewTableViewCell", bundle: nil), forCellReuseIdentifier: "PortfolioCell")
        viewModelInit()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Upstox Holding"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    func viewModelInit(){
        model.fetchUserHoldings()
        observeDataBinding()
    }
    
    func observeDataBinding(){
        model.eventHandler = { [weak self] result in
            guard let self else {return}
            switch result {
            case.stopLoading:
                print("Here is your holdings...")
            case.dataLoaded:
                DispatchQueue.main.async {
                    self.HoldingTableView.reloadData()
                    self.PortfolioTableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
            
        }
    }
}

extension HoldingListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == HoldingTableView {
            return model.holdings.count
        } else if tableView == PortfolioTableView {
    
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          if tableView == PortfolioTableView {
              return 300
          }
          return UITableView.automaticDimension
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == HoldingTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "holdingCell", for: indexPath) as? HoldingsCellTableViewCell else {
                return UITableViewCell()
            }
            let data =  model.holdings[indexPath.row]
            cell.data = data
            return cell
        } else if tableView == PortfolioTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioCell", for: indexPath) as? PortfolioViewTableViewCell else {
                return UITableViewCell()
            }
            
            // Calculate aggregated data for the portfolio
    
              let totalCurrentValue = model.holdings.reduce(0.0) { $0 + $1.currentValue }
              let totalInvestmentValue = model.holdings.reduce(0.0) { $0 + $1.investmentValue }
              let totalPnl = totalCurrentValue - totalInvestmentValue
              let totalTodayPnl = model.holdings.reduce(0.0) { $0 + $1.todayPnl }
            
            let formattedCurrentValue = String(format: "%.2f", totalCurrentValue)
            let formattedInvestmentValue = String(format: "%.2f", totalInvestmentValue)
            let formattedPnl = String(format: "%.2f", totalPnl)
            let formattedTodayPnl = String(format: "%.2f", totalTodayPnl)
            
            
            cell.CurrentValue.text = "Current Value"
            cell.TotalInvestment.text = "Total Investment"
            cell.TodayPandL.text = "Today's Profit & Loss"
            cell.OverAllPandL.text = "Profit & Loss"
            
            cell.CurrentAmount.text = "\u{20B9} \(formattedCurrentValue)"
            cell.TotalInvestmentAmount.text = "\u{20B9} \(formattedInvestmentValue)"
            cell.TodaysPandLAmount.text = "\u{20B9} \(formattedTodayPnl)"
            cell.OverallAmount.text = "\u{20B9} \(formattedPnl)"
            

            return cell

        }
        return UITableViewCell()
    }
}



