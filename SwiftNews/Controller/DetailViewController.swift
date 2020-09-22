//
//  DetailViewController.swift
//  SwiftNews
//
//  Created by Krzysztof Kopytek on 2020-09-21.
//  Copyright © 2020 Kopytek. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleText: UITextView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    var detailItem: ArticleViewModel? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }


    func configureView() {
        if let detail = detailItem {
            if let image = articleImage {
                image.image = detail.image
            }
            if let text = articleText {
                text.text = detail.text
            }
            if let title = navigationTitle {
                title.title = detail.title
            }
        }
    }


}

