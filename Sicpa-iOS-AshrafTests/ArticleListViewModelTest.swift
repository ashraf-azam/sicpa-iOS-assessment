//
//  ArticleListViewModelTest.swift
//  Sicpa-iOS-AshrafTests
//
//  Created by Snappy on 26/07/2022.
//

import XCTest
@testable import Sicpa_iOS_Ashraf

class ArticleListViewModelTest: XCTestCase {
    
    var sut: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    
    //------------------------------------------
    //MARK: Mock Data
    //------------------------------------------
    let mockJsonSearchArticleResponse = """
        {
           "response":{
              "docs":[
                 {
                    "_id":"1",
                    "pub_date":"2021-05-24T21:35:22+0000",
                    "headline":{
                       "print_headline":"This is a new unit test mock object.",
                        "main":"News 1"
                    }
                 },
                 {
                    "_id":"2",
                    "pub_date":"2021-05-24T21:35:22+0000",
                    "headline":{
                       "print_headline":"This is a new unit test mock object.",
                       "main":"News 2"
                    }
                 },
                 {
                    "_id":"3",
                    "pub_date":"2021-05-24T21:35:22+0000",
                    "headline":{
                       "print_headline":"This is a new unit test mock object.",
                       "main":"News 2"
                    }
                 }
              ]
           }
        }
    """
    
    let mockJsonArticleMostSharedResponse = """
        {
            "num_results":10,
            "results":[
              {
                 "id":1,
                 "title":"1. This is a new unit test most shared mock object",
                 "published_date":"23-12-1995"
              },
              {
                 "id":2,
                 "title":"2. This is a new unit test most shared mock object",
                 "published_date":"23-12-2005"
              },
              {
                 "id":3,
                 "title":"3. This is a new unit test most shared mock object",
                 "published_date":"23-12-2015"
              }
           ]
        }
    """
    
    let mockJsonArticleMostViewedResponse = """
        {
            "num_results":10,
            "results":[
              {
                 "id":1,
                 "title":"1. This is a new unit test most viewed mock object",
                 "published_date":"23-12-1995"
              },
              {
                 "id":2,
                 "title":"2. This is a new unit test most viewed mock object",
                 "published_date":"23-12-2005"
              },
              {
                 "id":3,
                 "title":"3. This is a new unit test most viewed mock object",
                 "published_date":"23-12-2015"
              }
           ]
        }
    """
    
    let mockJsonArticleMostEmailedResponse = """
        {
            "num_results":10,
            "results":[
              {
                 "id":1,
                 "title":"1. This is a new unit test most emailed mock object",
                 "published_date":"23-12-1995"
              },
              {
                 "id":2,
                 "title":"2. This is a new unit test most emailed mock object",
                 "published_date":"23-12-2005"
              },
              {
                 "id":3,
                 "title":"3. This is a new unit test most emailed mock object",
                 "published_date":"23-12-2015"
              }
           ]
        }
    """
    
    //------------------------------------------
    //MARK: Test View Model Data
    //------------------------------------------

    func testArticleEmptyData() {
        let expectedList : Array<Article> = []
        let service = MockService(mockArticleData: expectedList, mockSearchArticleData: nil)
        let viewModel = ArticleListViewModel(service: service)
        viewModel.intent = .mostEmailed
        
        viewModel.loadData(finished: {
            XCTAssertEqual(expectedList.count, 0, "Expected empty list count")
        })
      }

    func testArticleFetchData() {
        let expectedList = [Article.with()!]
        let service = MockService(mockArticleData: expectedList, mockSearchArticleData: nil)
        let viewModel = ArticleListViewModel(service: service)
        viewModel.intent = .mostViewed

        viewModel.loadData(finished: {
            XCTAssertEqual(expectedList.count, 1, "Expected one list count")

        })
    }
    
    func testSearchArticleEmptyData() {
        let expectedList : Array<SearchArticle> = []
        let service = MockService(mockArticleData: nil, mockSearchArticleData: expectedList)
        let viewModel = SearchArticleViewModel(service: service)
        
        viewModel.loadData(finished: {
            XCTAssertEqual(expectedList.count, 0, "Expected empty list count")
        }, keyword: "true")
      }
    
    func testSearchArticleJSONDecoding() throws {
        let mockJsonData = mockJsonSearchArticleResponse.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        XCTAssertNoThrow(try decoder.decode(SearchArticleResults.self, from: mockJsonData))
    }
    
    func testMostSharedArticlesJSONDecoding() throws {
        let mockJsonData = mockJsonArticleMostSharedResponse.data(using: .utf8)!
        let decoder = JSONDecoder()

        XCTAssertNoThrow(try decoder.decode(ArticlesResponse.self, from: mockJsonData))
    }
    
    func testMostViewedArticlesJSONDecoding() throws {
        let mockJsonData = mockJsonArticleMostViewedResponse.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        XCTAssertNoThrow(try decoder.decode(ArticlesResponse.self, from: mockJsonData))
    }
    
    func testMostEmailedArticlesJSONDecoding() throws {
        let mockJsonData = mockJsonArticleMostEmailedResponse.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        XCTAssertNoThrow(try decoder.decode(ArticlesResponse.self, from: mockJsonData))
    }
    
    func testCallSearchArticleWithoutAPIKey() throws {
        let urlString = "\(URLConstants.baseUrl)\(URLConstants.search).json"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sut.dataTask(with: url) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 401)
    }
    
    func testCallMostViewedArticleWithAPIKey() throws {
        let urlString = "\(URLConstants.baseUrl)\(URLConstants.mostViewed).json?api-key=DxZjh5ClH4yd6PzoX0gIdlo7W7F9jjup"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sut.dataTask(with: url) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }

}
