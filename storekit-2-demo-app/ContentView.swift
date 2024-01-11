//
//  ContentView.swift
//  storekit-2-demo-app
//
//  Created by Aisultan Askarov on 11.01.2024.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    @ObservedObject private var subscriptionsManager = SubscriptionsManager.shared
    @State private var selectedProduct: Product? = nil
    
    private var screenWidth: CGFloat = UIScreen.main.bounds.width
    private var screenHeight: CGFloat = UIScreen.main.bounds.height
    private let features: [String] = ["Remove all ads", "Daily new content", "Other cool features", "Follow for more tutorials"]
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 12.5) {
            Spacer()
            if !subscriptionsManager.products.isEmpty {
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundStyle(.tint)
                    .font(Font.system(size: 80))
                VStack(alignment: .center, spacing: 10, content: {
                    Text("Unlock Pro Access")
                        .font(.system(size: 33.0, weight: .bold))
                        .fontDesign(.rounded)
                        .multilineTextAlignment(.center)
                    Text("Get access to all of our features")
                        .font(.system(size: 17.0, weight: .semibold))
                        .fontDesign(.rounded)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                })
                
                // Features
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
                
                VStack(spacing: 0) {
                    // Products
                    List(subscriptionsManager.products, id: \.self) { product in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12.5)
                                .stroke(selectedProduct == product ? .blue : .black, lineWidth: 1.0)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white)) // Optional: Add a white background
                            
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
                    .scrollDisabled(true)
                    .listStyle(.plain)
                    .listRowSpacing(2.5)
                    
                    VStack(alignment: .center, spacing: 20, content: {
                        Button(action: {
                            if let selectedProduct = selectedProduct {
                                print("Purchased \(selectedProduct.displayName) for \(selectedProduct.displayPrice)")
                            } else {
                                print("Please select a product before purchasing.")
                            }
                        }, label: {
                            RoundedRectangle(cornerRadius: 12.5)
                                .overlay {
                                    Text("Purchase")
                                        .foregroundStyle(.white)
                                        .font(.system(size: 16.5, weight: .semibold, design: .rounded))
                                }
                        })
                        .padding(.horizontal, 20)
                        .frame(height: 46)
                        .disabled(selectedProduct == nil)
                        
                        Button("Restore Purchases") {
                        }
                        .font(.system(size: 14.0, weight: .regular, design: .rounded))
                        .frame(height: 10, alignment: .center)
                    })
                    .frame(height: 76)
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .task {
            await subscriptionsManager.loadProducts()
        }
    }
}

#Preview {
    ContentView()
}
