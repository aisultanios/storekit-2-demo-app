//
//  ContentView.swift
//  storekit-2-demo-app
//
//  Created by Aisultan Askarov on 11.01.2024.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    //MARK: - Properties
    @EnvironmentObject private var subscriptionsManager: SubscriptionsManager
    
    @State private var selectedProduct: Product? = nil
    private let features: [String] = ["Remove all ads", "Daily new content", "Other cool features", "Follow for more tutorials"]
    
    //MARK: - Layout
    var body: some View {
        subscriptionOptionsView
            .padding(.horizontal, 15)
            .padding(.vertical, 15)
    }
    
    // MARK: - Views
    private var subscriptionOptionsView: some View {
        VStack(alignment: .center, spacing: 12.5) {
            // TODO: Implement paywall after setting up a subscriptionsManager
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.5)
                .ignoresSafeArea(.all)
        }
    }
    
    private var hasSubscriptionView: some View {
        VStack(spacing: 20) {
            Image(systemName: "crown.fill")
                .foregroundStyle(.yellow)
                .font(Font.system(size: 100))
            
            Text("You've Unlocked Pro Access")
                .font(.system(size: 30.0, weight: .bold))
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .ignoresSafeArea(.all)
    }
    
    private var proAccessView: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "dollarsign.circle.fill")
                .foregroundStyle(.tint)
                .font(Font.system(size: 80))
            
            Text("Unlock Pro Access")
                .font(.system(size: 33.0, weight: .bold))
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
            
            Text("Get access to all of our features")
                .font(.system(size: 17.0, weight: .semibold))
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
    }
    
    private var featuresView: some View {
        List(features, id: \.self) { feature in
            HStack(alignment: .center) {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 22.5, weight: .medium))
                    .foregroundStyle(.blue)
                
                Text(feature)
                    .font(.system(size: 17.0, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.leading)
            }
            .listRowSeparator(.hidden)
            .frame(height: 35)
        }
        .scrollDisabled(true)
        .listStyle(.plain)
        .padding(.vertical, 20)
    }
    
    private var productsListView: some View {
        List(subscriptionsManager.products, id: \.self) { product in
            SubscriptionItemView(product: product, selectedProduct: $selectedProduct)
        }
        .scrollDisabled(true)
        .listStyle(.plain)
        .listRowSpacing(2.5)
        .frame(height: CGFloat(subscriptionsManager.products.count) * 90, alignment: .bottom)
    }
    
    private var purchaseSection: some View {
        VStack(alignment: .center, spacing: 15) {
            PurchaseButtonView(selectedProduct: $selectedProduct, subscriptionsManager: subscriptionsManager)
            
            Button("Restore Purchases") {
                // TODO: Implement Restoring
            }
            .font(.system(size: 14.0, weight: .regular, design: .rounded))
            .frame(height: 15, alignment: .center)
        }
    }
}

struct SubscriptionItemView: View {
    var product: Product
    @Binding var selectedProduct: Product?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12.5)
                .stroke(selectedProduct == product ? .blue : .black, lineWidth: 1.0)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            
            HStack {
                VStack(alignment: .leading, spacing: 8.5) {
                    Text(product.displayName)
                        .font(.system(size: 16.0, weight: .semibold, design: .rounded))
                        .multilineTextAlignment(.leading)
                    
                    Text("Get full access for just \(product.displayPrice)")
                        .font(.system(size: 14.0, weight: .regular, design: .rounded))
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Image(systemName: selectedProduct == product ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(selectedProduct == product ? .blue : .gray)
            }
            .padding(.horizontal, 20)
            .frame(height: 65, alignment: .center)
        }
        .onTapGesture {
            selectedProduct = product
        }
        .listRowSeparator(.hidden)
    }
}

// MARK: Subscription Item
struct PurchaseButtonView: View {
    @Binding var selectedProduct: Product?
    var subscriptionsManager: SubscriptionsManager
    
    var body: some View {
        Button(action: {
            if let selectedProduct = selectedProduct {
                // TODO: Implement Purchasing Product
            } else {
                print("Please select a product before purchasing.")
            }
        }) {
            RoundedRectangle(cornerRadius: 12.5)
                .overlay {
                    Text("Purchase")
                        .foregroundStyle(.white)
                        .font(.system(size: 16.5, weight: .semibold, design: .rounded))
                }
        }
        .padding(.horizontal, 20)
        .frame(height: 46)
        .disabled(selectedProduct == nil)
    }
}

