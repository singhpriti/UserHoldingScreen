//
//  UserHoldingModel.swift
//  UserHoldingScreen
//
//  Created by Preity Singh on 22/02/24.
//

import Foundation



struct UserHoldingsResponse: Codable {
    let userHolding: [UserHolding]
}

struct UserHolding: Codable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
    
    
    var currentValue: Double {
        return ltp * Double(quantity)
    }
    
    var investmentValue: Double {
        return avgPrice * Double(quantity)
    }
    
    var pnl: Double {
        return currentValue - investmentValue
      }
    
    var todayPnl: Double {
        return (close - ltp) * Double(quantity)
    }

}
    


        

