//
//  SubscriptionManager.swift
//  storekit-2-demo-app
//
//  Created by Aisultan Askarov on 11.01.2024.
//

import StoreKit

@MainActor
class SubscriptionsManager: ObservableObject {
    let productIDs: [String] = ["pro_monthly", "pro_yearly"] //TODO: Replace with your own product ids
    
    @Published 
    var products: [Product] = []
    var purchasedProductIDs: Set<String> = []
}

// MARK: StoreKit2 API
extension SubscriptionsManager {
    
}
