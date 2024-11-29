//
//  ContentView.swift
//  PlayTakeHomeAssignment
//
//  Created by SatangBiiger Jaydeestan on 29/11/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach($viewModel.products, id: \.id) { $item in
                    HStack {
                        Button(action: {
                            item.isSelected.toggle()
                            viewModel.calulatePrice()
                        }) {
                            Image(systemName: item.isSelected ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                            }

                            Text(item.name)
                                .font(.system(size: 18))
                                .padding(.leading, 10)
                                
                            Spacer()
                                
                            Text(String(format: "$%.2f", item.price))
                                .font(.system(size: 18))
                        }
                    }
                }
            .listStyle(PlainListStyle())

            Divider()
            Button {
                viewModel.isShowDiscountDropdown.toggle()
            } label: {
                Text(viewModel.discountSelected?.type == DiscountType.none ? "Select Discount" : viewModel.discountSelected?.name ?? "Select Discount")
            }
            if viewModel.isShowDiscountDropdown {
                List {
                    ForEach($viewModel.discounts, id: \.id) { $item in
                        HStack {
                            Button(action: {
                                viewModel.selectedDiscount(item: item)
                                viewModel.isShowDiscountDropdown.toggle()
                                viewModel.calulatePrice()
                            }) {
                                Image(systemName: item.isSelected ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(.blue)
                                    .imageScale(.large)
                                }

                                Text(item.name)
                                    .font(.system(size: 18))
                                    .padding(.leading, 10)
                            }
                        }
                    }
                .listStyle(PlainListStyle())
            }
            Divider()
            HStack {
                Text("Total Price:")
                    .font(.headline)
                Spacer()
                Text(String(format: "%.2f THB", viewModel.totalPrice))
                    .font(.headline)
                    .foregroundColor(.green)
                }
                .padding()
            }
            .navigationTitle("Shopping Cart")
    }
}

#Preview {
    ContentView()
}
