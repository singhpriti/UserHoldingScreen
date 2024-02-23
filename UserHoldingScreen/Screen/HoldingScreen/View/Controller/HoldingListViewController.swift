//
//  HoldingListViewController.swift
//  UserHoldingScreen
//
//  Created by Preity Singh on 22/02/24.
//

import UIKit

class HoldingListViewController: UIViewController {
    
    @IBOutlet weak var HoldingTableView : UITableView!
    var portfolio: PortfolioView!
    
    var model = HoldingsViewModel()
    
    var isExpanded = false
    var collapsedHeight: CGFloat = 0
    var expandedHeight: CGFloat = 93
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
}

extension HoldingListViewController {
    
    func config(){
        portfolio = .fromNib()
        
        portfolio.upDownButton.addTarget(self, action: #selector(expandCollapseButtonTapped), for: .touchUpInside)
        HoldingTableView.register(UINib(nibName: "HoldingsCellTableViewCell" , bundle: nil), forCellReuseIdentifier: "holdingCell")
        
        viewModelInit()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Upstox Holding"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    private func preparePortfolioWithData(){
        view.addSubview(portfolio)
        portfolio.upDownButton.setImage(UIImage(systemName: "arrowshape.up.circle.fill"), for: .normal)
        portfolio?.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height - 125, width: UIScreen.main.bounds.width, height: 125)
        portfolio?.dataStackHeight.constant = collapsedHeight
        calculateAndPreparePortFolio()
    }
    
    @objc func expandCollapseButtonTapped(){
        isExpanded.toggle()
        // Note: 218 is total height and 125 is remaining height while hiding other portion
        if isExpanded {
            portfolio.upDownButton.setImage(UIImage(systemName: "arrowshape.down.circle.fill"), for: .normal)
            portfolio?.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height - 218, width: UIScreen.main.bounds.width, height: 218)
            portfolio?.dataStackHeight.constant = expandedHeight
        }else{
            portfolio.upDownButton.setImage(UIImage(systemName: "arrowshape.up.circle.fill"), for: .normal)
            portfolio?.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height - 125, width: UIScreen.main.bounds.width, height: 125)
            portfolio?.dataStackHeight.constant = collapsedHeight
        }
    }
    
    private func calculateAndPreparePortFolio(){
        let totalCurrentValue = model.holdings.reduce(0.0) { $0 + $1.currentValue }
        let totalInvestmentValue = model.holdings.reduce(0.0) { $0 + $1.investmentValue }
        let totalPnl = totalCurrentValue - totalInvestmentValue
        let totalTodayPnl = model.holdings.reduce(0.0) { $0 + $1.todayPnl }
        
        let formattedCurrentValue = String(format: "%.2f", totalCurrentValue)
        let formattedInvestmentValue = String(format: "%.2f", totalInvestmentValue)
        let formattedPnl = String(format: "%.2f", totalPnl)
        let formattedTodayPnl = String(format: "%.2f", totalTodayPnl)
        
        portfolio.CurrentValue.text = "\u{20B9} \(formattedCurrentValue)"
        portfolio.TotalInvestment.text = "\u{20B9} \(formattedInvestmentValue)"
        portfolio.TodayPandL.text = "\u{20B9} \(formattedTodayPnl)"
        portfolio.OverAllPandL.text = "\u{20B9} \(formattedPnl)"
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
                    self.preparePortfolioWithData()
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
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "holdingCell", for: indexPath) as? HoldingsCellTableViewCell else {
            return UITableViewCell()
        }
        let data =  model.holdings[indexPath.row]
        cell.data = data
        return cell
    }
}


extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
