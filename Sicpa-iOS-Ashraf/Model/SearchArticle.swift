//
//  SearchArticle.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation

struct SearchArticleResponse: Codable {
    let response: SearchArticleResults
    
    enum CodingKeys: String, CodingKey {
        case response   = "response"
    }
    
}

struct SearchArticleResults: Codable {
    let results: [SearchArticle]?
    
    enum CodingKeys: String, CodingKey {
        case results = "docs"
    }
}

struct SearchArticle: Codable {
    let id: String?
    let publishedDate: String?
    let headline: ArticleHeadline?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case publishedDate = "pub_date"
        case headline
    }
}

struct ArticleHeadline: Codable {
    let printHeadline: String?
    let main: String?
    
    enum CodingKeys: String, CodingKey {
        case printHeadline = "print_headline"
        case main = "main"
    }
}
