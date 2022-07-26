//
//  MockService.swift
//  Sicpa-iOS-AshrafTests
//
//  Created by Snappy on 26/07/2022.
//

import Foundation
@testable import Sicpa_iOS_Ashraf

class MockService : ServiceProtocol {
    func fetchSearchArticle(keyword: String, completion: @escaping ([SearchArticle]?) -> Void) {
        completion(mockSearchArticleData)
    }
    
    func fetchArticleList(type: HomeCategory, completion: @escaping ([Article]?) -> Void) {
        completion(mockArticleData)
    }
    
    let mockArticleData: [Article]?
    let mockSearchArticleData: [SearchArticle]?
    
    init(mockArticleData: [Article]?, mockSearchArticleData: [SearchArticle]?) {
        self.mockArticleData = mockArticleData
        self.mockSearchArticleData = mockSearchArticleData
    }
    
}
