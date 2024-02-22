//
//  PortfolioViewTableViewCell.swift
//  UserHoldingScreen
//
//  Created by Preity Singh on 22/02/24.
//

import UIKit

class PortfolioViewTableViewCell: UITableViewCell {

    @IBOutlet weak var OverAllPandL: UILabel!
    @IBOutlet weak var OverallAmount: UILabel!
    @IBOutlet weak var TodayPandL: UILabel!
    @IBOutlet weak var CurrentValue: UILabel!
    @IBOutlet weak var TotalInvestment: UILabel!
    @IBOutlet weak var TotalInvestmentAmount: UILabel!
    @IBOutlet weak var TodaysPandLAmount: UILabel!
    @IBOutlet weak var CurrentAmount: UILabel!
    
    
    var data : UserHolding? {
        didSet{
            //holdingDetailConfig()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
//    func holdingDetailConfig() {
//        guard let data = data else { return }
//        CurrentValue.text = "Current Value"
//        TotalInvestment.text = "Total Investment"
//        TodayPandL.text = "Today's Profit & Loss"
//        OverAllPandL.text = "Profit & Loss"
//        
//        CurrentAmount.text = "\u{20B9}\(data.currentValue)"
//        TotalInvestmentAmount.text = "\u{20B9}\(data.investmentValue)"
//        TodaysPandLAmount.text = "\u{20B9}\(data.todayPnl)"
//        OverallAmount.text = "\u{20B9}\(data.todayPnl)"
//    }
    
    
}
