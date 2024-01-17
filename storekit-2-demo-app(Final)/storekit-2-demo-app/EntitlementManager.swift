//
//  EntitlementManager.swift
//  storekit-2-demo-app
//
//  Created by Aisultan Askarov on 13.01.2024.
//

import SwiftUI

class EntitlementManager: ObservableObject {
    static let userDefaults = UserDefaults(suiteName: "group.demo.app")!
    
    @AppStorage("hasPro", store: userDefaults)
    var hasPro: Bool = false
}

