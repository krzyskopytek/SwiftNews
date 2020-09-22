//
//  MainViewController.swift
//  SwiftNews
//
//  Created by Krzysztof Kopytek on 2020-09-21.
//  Copyright © 2020 Kopytek. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var articleViewModels = [ArticleViewModel]()
    let cellId = "articleCell"
    let loader = ImageLoader()


    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }

        fetchData()


    }
    
    fileprivate func fetchData() {
        NewsService.shared.fetchNews { (news, err) in
            if let err = err {
                print("Failed to fetch news:", err)
                return
            }
            self.articleViewModels = news?.articles.map({return ArticleViewModel(article: $0)}) ?? []
            self.tableView.reloadData()
        }
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let articleViewModel = articleViewModels[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = articleViewModel
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ArticleViewCell
        let article = articleViewModels[indexPath.row]

        cell.titleLabel.text = article.title
        
        if article.image != nil {
            cell.thumbImage.image = article.image
        }
        else {
        
        guard let link = article.imageThumb else { return cell }
        
        if article.imageThumb == "" { return cell } // TODO move to viewmodel

        let imageUrl = URL(string: link)!
            
            let token = loader.loadImage(imageUrl) { result in
              do {
                let image = try result.get()
                self.articleViewModels[indexPath.row].image = image
                DispatchQueue.main.async {
                    cell.thumbImage.image = image
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
              } catch {
                print(error)
              }
            }

            cell.onReuse = {
              if let token = token {
                self.loader.cancelLoad(token)
              }
            }
        }
        
        return cell
    }

}

