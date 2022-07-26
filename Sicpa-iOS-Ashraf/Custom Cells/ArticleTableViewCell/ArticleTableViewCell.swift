//
//  ArticleTableViewCell.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var byLineLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var dateIcon:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .boldSystemFont(ofSize: 14)
        dateLabel.font = .systemFont(ofSize: 12)
    }
    
    var viewModel: ArticlesDetailsViewModel? = nil {
        didSet {
            guard let viewModel = self.viewModel else { return }
            self.titleLabel.text = viewModel.title
            
            if viewModel.category == .search {
                let test = ArticleDateFormatter.dateFromString(string: String(viewModel.date.dropLast(5)), forDateFormat: "yyyy-mm-dd'T'HH:mm:ss")
                if let date = test {
                    let displayDate = ArticleDateFormatter.formatDatePresentation(date: date, to: "dd MMMM yyyy")
                    self.dateLabel.text = displayDate
                }
            } else {
                let test = ArticleDateFormatter.dateFromString(string: viewModel.date, forDateFormat: "yyyy-mm-dd")
                if let date = test {
                    let displayDate = ArticleDateFormatter.formatDatePresentation(date: date, to: "dd MMMM yyyy")
                    self.dateLabel.text = displayDate
                }
            }
        }
    }
    
}
