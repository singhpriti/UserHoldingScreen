//
//  HoldingsCellTableViewCell.swift
//  UserHoldingScreen
//
//  Created by Preity Singh on 22/02/24.
//

import UIKit

final class HoldingsCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var holdingListBackground: UIView!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var ltp: UILabel!
    @IBOutlet weak var profitAndLoss: UILabel!
    
    var data: UserHolding? {
        didSet{
            holdingDetailConfig()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        holdingListBackground.clipsToBounds = false
        holdingListBackground.layer.cornerRadius = 5
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
 
    private func holdingDetailConfig() {
        
        guard let data = data else { return }
        symbol.text = data.symbol
        quantity.text = "\(data.quantity)"
        
        let ltpAttributedString = NSMutableAttributedString(string: "LTP: ", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: ltp.font.pointSize)
        ])
        let priceSymbol = "\u{20B9}"
        let ltpPriceAttributedString = NSAttributedString(string: "\(priceSymbol) \(data.ltp)", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ])
        ltpAttributedString.append(ltpPriceAttributedString)
        
        ltp.attributedText = ltpAttributedString
        
        let pnlValue = String(format: "%.2f", data.pnl)
        let pnlAttributedString = NSMutableAttributedString(string: "P/L: ", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: profitAndLoss.font.pointSize)
        ])
        
        let pnlPriceAttributedString = NSAttributedString(string: "\(priceSymbol) \(pnlValue)", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: profitAndLoss.font.pointSize)
        ])
        pnlAttributedString.append(pnlPriceAttributedString)
        
        profitAndLoss.attributedText = pnlAttributedString
    }
    
    
}
