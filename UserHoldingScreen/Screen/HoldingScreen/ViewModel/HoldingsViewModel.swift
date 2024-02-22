//
//  HoldingsViewModel.swift
//  UserHoldingScreen
//
//  Created by Preity Singh on 22/02/24.
//

import Foundation

final class HoldingsViewModel {
    
    var holdings: [UserHolding] = []
    
    var eventHandler : ((_ event: Event) -> Void)?
    
    func fetchUserHoldings() {
    
        APIManager.shared.gethUserHoldingDetails { result in
            self.eventHandler?(.stopLoading)
            switch result {
            case .success(let userHoldingsResponse):
                self.holdings = userHoldingsResponse.userHolding
                
                // Notify any observers (e.g., views) that the data has been updated
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}


extension HoldingsViewModel {
    enum Event {
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}

