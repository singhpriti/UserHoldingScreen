//
//  HoldingListViewController.swift
//  UserHoldingScreen
//
//  Created by Preity Singh on 22/02/24.
//

import UIKit

final class HoldingListViewController: UIViewController {
    
   @IBOutlet weak var holdingTableView: UITableView!
    
   private var portfolio: PortfolioView?
   private var model = HoldingsViewModel()
   private var isExpanded = false
   private var collapsedHeight: CGFloat = 0
   private var expandedHeight: CGFloat = 93
   private var portfolioCollapsedHeight: CGFloat = 159
   private var portfolioExpendedHeight: CGFloat = 252
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
}

extension HoldingListViewController {
    
     private func config() {
        portfolio = .fromNib()
        
        portfolio?.upDownButton.addTarget(self, action: #selector(expandCollapseButtonTapped), for: .touchUpInside)
        holdingTableView.register(UINib(nibName: "HoldingsCellTableViewCell" , bundle: nil), forCellReuseIdentifier: "holdingCell")
        
        viewModelInit()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Upstox Holding"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    }
    
    private func preparePortfolioWithData() {
        guard let portfolio else { return }
        view.addSubview(portfolio)
        portfolio.upDownButton.setImage(UIImage(systemName: "arrowshape.up.circle.fill"), for: .normal)
        portfolio.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height - portfolioCollapsedHeight, width: UIScreen.main.bounds.width, height: portfolioCollapsedHeight)
        portfolio.dataStackHeight.constant = collapsedHeight
        calculateAndPreparePortFolio()
    }
    
    @objc func expandCollapseButtonTapped() {
        isExpanded.toggle()
        if isExpanded {
            portfolio?.upDownButton.setImage(UIImage(systemName: "arrowshape.down.circle.fill"), for: .normal)
            portfolio?.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height - portfolioExpendedHeight, width: UIScreen.main.bounds.width, height: portfolioExpendedHeight)
            portfolio?.dataStackHeight.constant = expandedHeight
        }else{
            portfolio?.upDownButton.setImage(UIImage(systemName: "arrowshape.up.circle.fill"), for: .normal)
            portfolio?.frame = CGRect(x: 0 , y: UIScreen.main.bounds.height - portfolioCollapsedHeight, width: UIScreen.main.bounds.width, height: portfolioCollapsedHeight)
            portfolio?.dataStackHeight.constant = collapsedHeight
        }
    }
    
    private func calculateAndPreparePortFolio() {
        let totalCurrentValue = model.holdings.reduce(0.0) { $0 + $1.currentValue }
        let totalInvestmentValue = model.holdings.reduce(0.0) { $0 + $1.investmentValue }
        let totalPnl = totalCurrentValue - totalInvestmentValue
        let totalTodayPnl = model.holdings.reduce(0.0) { $0 + $1.todayPnl }
        
        let formattedCurrentValue = String(format: "%.2f", totalCurrentValue)
        let formattedInvestmentValue = String(format: "%.2f", totalInvestmentValue)
        let formattedPnl = String(format: "%.2f", totalPnl)
        let formattedTodayPnl = String(format: "%.2f", totalTodayPnl)
        
        let priceSymbol = "\u{20B9}"
        portfolio?.currentValue.text = "\(priceSymbol) \(formattedCurrentValue)"
        portfolio?.totalInvestment.text = "\(priceSymbol) \(formattedInvestmentValue)"
        portfolio?.todayPandL.text = "\(priceSymbol) \(formattedTodayPnl)"
        portfolio?.overAllPandL.text = "\(priceSymbol) \(formattedPnl)"
    }
    
    
    private func viewModelInit() {
        model.fetchUserHoldings()
        observeDataBinding()
    }
    
   private func observeDataBinding() {
        model.eventHandler = { [weak self] result in
            guard let self else {return}
            switch result {
            case .stopLoading:
                print("Here is your holdings...")
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.holdingTableView.reloadData()
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
        if tableView == holdingTableView {
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
