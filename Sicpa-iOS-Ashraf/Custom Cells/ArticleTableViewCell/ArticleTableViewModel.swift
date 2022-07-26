//
//  ArticleTableViewModel.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation

class ArticlesDetailsViewModel: NSObject {
    var title: String
    var date: String
    var category: HomeCategory

    
    init(article: Article) {
        title = article.title ?? ""
        date = article.published_date ?? ""
        category = article.category ?? .mostEmailed
    }
}
