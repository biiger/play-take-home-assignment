//
//  ProductItemModel.swift
//  PlayTakeHomeAssignment
//
//  Created by SatangBiiger Jaydeestan on 29/11/2567 BE.
//

import Foundation


struct ProductItemModel {
    var id = UUID()
    var name: String
    var price: Double
    var isSelected: Bool = false
    var category: ProductCategory
}

enum ProductCategory {
    case clothing
    case accessories
    case electronics
    case none
}
