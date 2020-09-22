//
//  ArticleViewCell.swift
//  SwiftNews
//
//  Created by Krzysztof Kopytek on 2020-09-21.
//  Copyright © 2020 Kopytek. All rights reserved.
//

import UIKit

class ArticleViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    var onReuse: () -> Void = {}
    
    var articleViewModel: ArticleViewModel! {
        didSet {
            titleLabel?.text = articleViewModel.title
        }
    }

    override func prepareForReuse() {
      super.prepareForReuse()
      onReuse()
      thumbImage.image = nil
    }
    
}
