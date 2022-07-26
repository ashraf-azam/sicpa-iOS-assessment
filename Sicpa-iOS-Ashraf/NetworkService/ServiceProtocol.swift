//
//  ServiceProtocol.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation

protocol ServiceProtocol {
    func fetchArticleList(type: HomeCategory, completion: @escaping ([Article]?) -> Void)
    func fetchSearchArticle(keyword: String, completion: @escaping ([SearchArticle]?) -> Void)
}
