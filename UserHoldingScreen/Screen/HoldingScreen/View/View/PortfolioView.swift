//
//  PortfolioView.swift
//  UserHoldingScreen
//
//  Created by Riddhi Vekariya on 23/02/24.
//

import UIKit

 final class PortfolioView: UIView {

    @IBOutlet weak var overAllPandL: UILabel!
    @IBOutlet weak var todayPandL: UILabel!
    @IBOutlet weak var currentValue: UILabel!
    @IBOutlet weak var totalInvestment: UILabel!
    @IBOutlet weak var dataStackHeight: NSLayoutConstraint!
    @IBOutlet weak var upDownButton: UIButton!
    var isExpand: Bool = false
    
}
