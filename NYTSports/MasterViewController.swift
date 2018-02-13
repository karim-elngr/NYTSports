//
//  MasterViewController.swift
//  NYTSports
//
//  Created by Karim ElNaggar on 2/6/18.
//  Copyright © 2018 karimelnaggar. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    let nytTopSportsArticlesAPI: NYTTopSportsArticlesAPI = NYTTopSportsArticlesAPI()
    var sportsArticles: [SportsArticle]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        nytTopSportsArticlesAPI.fetch({[weak self] (sportsArticles) in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.sportsArticles = sportsArticles
            }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).viewControllers.last! as! DetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.controller = sportsArticles![indexPath.row]
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportsArticles?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SportsArticleTableViewCell", for: indexPath) as! SportsArticleTableViewCell
        cell.controller = sportsArticles?[indexPath.row]
        return cell
    }
}

