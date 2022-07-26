//
//  Articles.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation

typealias Articles = [Article]

// MARK: - Employee
struct ArticlesResponse : Codable {
    
    let status      : String?
    let copyright   : String?
    let num_results : Int?
    let articles    : [Article]?
    
    enum CodingKeys: String, CodingKey {
        
        case status      = "status"
        case copyright   = "copyright"
        case num_results = "num_results"
        case articles    = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values  = try decoder.container(keyedBy: CodingKeys.self)
        status      = try values.decodeIfPresent(String.self, forKey: .status)
        copyright   = try values.decodeIfPresent(String.self, forKey: .copyright)
        num_results = try values.decodeIfPresent(Int.self, forKey: .num_results)
        articles    = try values.decodeIfPresent([Article].self, forKey: .articles)
    }
    
}

struct Article : Codable, Identifiable {
    let id : Int?
    let published_date : String?
    let type : String?
    let title : String?
    let category : HomeCategory?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case published_date = "published_date"
        case type = "type"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        category = nil
    }
    
    init(heading: String, date: String, categoryType: HomeCategory) {
        title = heading
        published_date = date
        category = categoryType
        type = nil
        id = nil
    }

}
