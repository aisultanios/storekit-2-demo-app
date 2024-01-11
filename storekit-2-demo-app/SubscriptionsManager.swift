//
//  SubscriptionManager.swift
//  storekit-2-demo-app
//
//  Created by Aisultan Askarov on 11.01.2024.
//

import StoreKit
import SwiftUI

final class SubscriptionsManager: ObservableObject {
    let productIDs: [String] = ["pro_monthly", "pro_yearly"]
    @Published var products: [Product] = []
    
    static let shared = SubscriptionsManager()
    
    private init() {
        
    }
}

// MARK: StoreKit2 API
extension SubscriptionsManager {
    func loadProducts() async {
        do {
            self.products = try await Product.products(for: productIDs)
        } catch {
            print("Failed to fetch products!")
        }
    }
}
