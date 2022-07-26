//
//  HomeModel.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation

enum HomeCategory: String {
    case search = "Search"
    case popular = "Popular"
    case mostViewed = "Most Viewed"
    case mostShared = "Most Shared"
    case mostEmailed = "Most Emailed"
}

struct SelectedHomeCategory {
    let category: HomeCategory
    let subCategory: [HomeCategory]
    
    init(category: HomeCategory, subCategory: [HomeCategory]) {
        self.category = category
        self.subCategory = subCategory
    }
}
