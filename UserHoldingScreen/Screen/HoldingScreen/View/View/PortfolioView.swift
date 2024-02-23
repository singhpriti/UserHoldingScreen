//
//  PortfolioView.swift
//  UserHoldingScreen
//
//  Created by Riddhi Vekariya on 23/02/24.
//

import UIKit

class PortfolioView: UIView {

    @IBOutlet weak var OverAllPandL: UILabel!
    @IBOutlet weak var TodayPandL: UILabel!
    @IBOutlet weak var CurrentValue: UILabel!
    @IBOutlet weak var TotalInvestment: UILabel!
    @IBOutlet weak var dataStackHeight: NSLayoutConstraint!
    @IBOutlet weak var upDownButton: UIButton!
    var isExpand: Bool = false
    
    override class func awakeFromNib() {
        
    }
}
