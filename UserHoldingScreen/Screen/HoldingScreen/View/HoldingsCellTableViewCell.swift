//
//  HoldingsCellTableViewCell.swift
//  UserHoldingScreen
//
//  Created by Preity Singh on 22/02/24.
//

import UIKit

class HoldingsCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var HoldingListBackground: UIView!
    @IBOutlet weak var Symbol: UILabel!
    @IBOutlet weak var Quantity: UILabel!
    @IBOutlet weak var LTP: UILabel!
    @IBOutlet weak var ProfitandLoss: UILabel!
   // @IBOutlet weak var PortfolioVie: UIView!
    
    
    var data : UserHolding? {
        didSet{
            holdingDetailConfig()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        HoldingListBackground.clipsToBounds = false
        HoldingListBackground.layer.cornerRadius = 5
    }
    
    @objc func toggleCollapse() {
           if let tableView = superview as? UITableView {
               tableView.beginUpdates()
               tableView.endUpdates()
           }
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    func holdingDetailConfig() {
        guard let data = data else { return }
        
        Symbol.text = data.symbol
        Quantity.text = "\(data.quantity)"
    
        let ltpAttributedString = NSMutableAttributedString(string: "LTP: ", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: LTP.font.pointSize)
        ])
    
        let ltpPriceAttributedString = NSAttributedString(string: "\u{20B9} \(data.ltp)", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 18)
            //.font: UIFont.boldSystemFont(ofSize: LTP.font.pointSize)
        ])
        ltpAttributedString.append(ltpPriceAttributedString)
        
    
        LTP.attributedText = ltpAttributedString
        
       
        let pnlValue = String(format: "%.2f", data.pnl)
        let pnlAttributedString = NSMutableAttributedString(string: "P/L: ", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: ProfitandLoss.font.pointSize)
        ])
        
        let pnlPriceAttributedString = NSAttributedString(string: "\u{20B9} \(pnlValue)", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: ProfitandLoss.font.pointSize)
        ])
        pnlAttributedString.append(pnlPriceAttributedString)
       
        ProfitandLoss.attributedText = pnlAttributedString
    }

    
}
