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
    let portfolioView = PortfolioView()

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        view.addSubview(portfolioView)
    }
    
//    override func viewDidLayoutSubviews() {
//         super.viewDidLayoutSubviews()
//         
//         // Calculate the total height of the table view content
//         var contentHeight: CGFloat = 0
//         for section in 0..<HoldingTableView.numberOfSections {
//             contentHeight += HoldingTableView.rect(forSection: section).height
//         }
//         
//         // Set the frame of the PortfolioView below the last cell
//         let portfolioViewY = contentHeight + HoldingTableView.contentInset.top
//         portfolioView.frame = CGRect(x: 0, y: portfolioViewY, width: view.bounds.width, height: 200)
//     }
 }



extension HoldingListViewController {
    
    func config(){
        HoldingTableView.register(UINib(nibName: "HoldingsCellTableViewCell" , bundle: nil), forCellReuseIdentifier: "holdingCell")
        viewModelInit()
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // Create a label
        let titleLabel = UILabel()
        titleLabel.text = "Upstox Holding"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white // Set your desired font
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
                }
            case .error(let error):
                print(error)
            }
            
        }
    }
}

extension HoldingListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.holdings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "holdingCell", for: indexPath) as? HoldingsCellTableViewCell  else { return UITableViewCell() }
        let data =  model.holdings[indexPath.row]
        // assigning the data to cell.data
        cell.data = data
        return cell
    }
    
    
}
