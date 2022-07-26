//
//  HomeTableViewCell.swift
//  Sicpa-iOS-Ashraf
//
//  Created by Snappy on 25/07/2022.
//

import Foundation
import UIKit

final class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.font = .boldSystemFont(ofSize: 14)
    }
    
    var viewModel: SelectedHomeCategory? = nil {
        
        didSet {
            guard let viewModel = self.viewModel else { return }
            self.categoryLabel.text = viewModel.category.rawValue
        }
    }
}
