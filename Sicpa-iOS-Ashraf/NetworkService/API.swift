//
//  API.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation

fileprivate let api_key = "P979U9nqzOFdHCE4ZKumlkpd3W38oz97"

struct URLConstants {
    static let baseUrl = "https://api.nytimes.com"
    static let mostViewed = "/svc/mostpopular/v2/viewed/7"
    static let mostShared = "/svc/mostpopular/v2/shared/7"
    static let mostEmailed = "/svc/mostpopular/v2/emailed/7"
    static let search = "/svc/search/v2/articlesearch"
}

class APIService : ServiceProtocol {
    
    func fetchArticleList(type: HomeCategory, completion: @escaping ([Article]?) -> Void) {
        loadData({ articles in
            completion(articles)
        }, type: type)
    }
    
    func fetchSearchArticle(keyword: String, completion: @escaping ([SearchArticle]?) -> Void) {
        loadData({ articles in
            completion(articles)
        }, keyword: keyword)
    }
    
    private func loadData(_ completion: @escaping ([Article]?) -> Void, type: HomeCategory) {
        var url = ""
        
        switch type {
        case .search:
            url = "\(URLConstants.baseUrl)\(URLConstants.search).json"
        case .popular:
            url = "\(URLConstants.baseUrl)\(URLConstants.mostViewed).json"
        case .mostViewed:
            url = "\(URLConstants.baseUrl)\(URLConstants.mostViewed).json"
        case .mostShared:
            url = "\(URLConstants.baseUrl)\(URLConstants.mostShared).json"
        case .mostEmailed:
            url = "\(URLConstants.baseUrl)\(URLConstants.mostEmailed).json"
        }
        
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        
        components.queryItems = [URLQueryItem(name: "api-key", value: api_key)]
        
        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(request.description)
        URLSession.shared.dataTask(with: request){ (data, _, _) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            guard let articles = try? JSONDecoder().decode(ArticlesResponse.self, from: data) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(articles.articles)
            }
            
        }.resume()
    }
    
    private func loadData(_ completion: @escaping ([SearchArticle]?) -> Void, keyword: String?) {
        let url = "\(URLConstants.baseUrl)\(URLConstants.search).json"
        
        guard var components = URLComponents(string: url) else {
            print("Error: cannot create URLCompontents")
            return
        }
        
        components.queryItems = [URLQueryItem(name: "api-key", value: api_key)]
        components.queryItems?.append(URLQueryItem(name: "q", value: keyword))
        
        guard let url = components.url else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(request.description)
        URLSession.shared.dataTask(with: request){ (data, _, _) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            guard let articles = try? JSONDecoder().decode(SearchArticleResponse.self, from: data) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(articles.response.results)
            }
            
        }.resume()
    }
    
}
