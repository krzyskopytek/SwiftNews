//
//  MainViewModel.swift
//  SwiftNews
//
//  Created by Krzysztof Kopytek on 2020-09-21.
//  Copyright © 2020 Kopytek. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewModel {
    
    let title: String
    var imageThumb: String? = ""
    var image: UIImage?
    var text: String = ""
    
    // Dependency Injection (DI)
    init(article: Article) {
        self.title = article.title
        if article.thumbnail == "self" || article.thumbnail == "default" {
            self.image = nil
        }
        else {
            self.imageThumb = article.thumbnail
        }
        self.text = article.selftext
        
    }
    
}
