//
//  Item.swift
//  FilteringInPractice
//
//  Created by Mohamed osama on 04/11/2021.
//

import Foundation

enum SizeType: String{
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct Item{
    var txt: String?
    var sizeType: SizeType?
}
