//
//  DiscountModel.swift
//  PlayTakeHomeAssignment
//
//  Created by SatangBiiger Jaydeestan on 29/11/2567 BE.
//

import Foundation

struct DiscountModel: Hashable {
    var id = UUID()
    var name: String
    var type: DiscountType
    var discount: Double?
    var everyDiscount: Double?
    var percent: Double?
    var productCategory: ProductCategory = .none
    var isSelected: Bool = false
}

enum DiscountType {
    case fixedAmount
    case percentageDiscount
    case discountByItem
    case discountByPoint
    case specialCampaigns
    case none
}
