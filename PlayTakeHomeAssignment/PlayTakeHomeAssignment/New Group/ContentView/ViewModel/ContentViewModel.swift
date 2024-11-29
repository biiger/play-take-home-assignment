//
//  ContentViewModel.swift
//  PlayTakeHomeAssignment
//
//  Created by SatangBiiger Jaydeestan on 29/11/2567 BE.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var products: [ProductItemModel] = [
        ProductItemModel(name: "T-Shirt", price: 350.0, isSelected: false, category: .clothing),
        ProductItemModel(name: "Hat", price: 250.0, isSelected: false, category: .clothing),
        ProductItemModel(name: "Belt", price: 230.0, isSelected: false, category: .accessories),
        ProductItemModel(name: "Hoodie", price: 700.0, isSelected: false, category: .clothing),
        ProductItemModel(name: "Watch", price: 850.0, isSelected: false, category: .electronics),
        ProductItemModel(name: "Bag", price: 640.0, isSelected: false, category: .accessories),
    ]
    @Published var totalPrice: Double = 0.0
    @Published var discountSelected: DiscountModel? = nil
    @Published var isShowDiscountDropdown: Bool = false
    
    var discounts: [DiscountModel] = [
        DiscountModel(name: "None", type: .none, discount: 0.0),
        DiscountModel(name: "Discount 50 THB", type: .fixedAmount, discount: 50.0),
        DiscountModel(name: "Discount 10%", type: .percentageDiscount, percent: 10.0),
        DiscountModel(name: "Discount 15% Off on Clothing", type: .discountByItem, percent: 15.0, productCategory: .clothing),
        DiscountModel(name: "Discount 68 Points", type: .discountByPoint, discount: 68.0),
        DiscountModel(name: "Discount 230 Points", type: .discountByPoint, discount: 230.0),
        DiscountModel(name: "Discount 40 THB Every 300 THB", type: .specialCampaigns, discount: 40, everyDiscount: 300.0),
        
    ]
    
    func selectedDiscount(item: DiscountModel) {
        discountSelected = item
        for (index, _) in discounts.enumerated() {
            discounts[index].isSelected = false
        }
        if let index = discounts.firstIndex(of: item) {
            discounts[index].isSelected.toggle()
        }
    }
    
    func calulatePrice() {
        let list = products.filter({ $0.isSelected })
        totalPrice = 0.0
        for item in list {
            totalPrice += item.price
        }
        
        if let discountSelected = discountSelected {
            switch discountSelected.type {
            case .fixedAmount:
                totalPrice = totalPrice - (discountSelected.discount ?? 0.0)
            case .percentageDiscount:
                totalPrice = totalPrice - (totalPrice*((discountSelected.percent ?? 0)/100))
            case .discountByItem:
                let productByCateList = list.filter({ $0.category == discountSelected.productCategory })
                var total = totalPrice
                for item in productByCateList {
                    total -= item.price - (item.price*((discountSelected.percent ?? 0)/100))
                }
                totalPrice = total
            case .discountByPoint:
                if (discountSelected.discount ?? 0.0) > 200.0 {
                    totalPrice = totalPrice - 200.0
                } else {
                    totalPrice = totalPrice - (discountSelected.discount ?? 0.0)
                }
            case .specialCampaigns:
                totalPrice = totalPrice - ((discountSelected.discount ?? 0.0)*(totalPrice/(discountSelected.everyDiscount ?? 0.0)))
            case .none:
                print("none")
            }
        }
    }
}
