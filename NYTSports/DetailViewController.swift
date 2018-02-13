//
//  DetailViewController.swift
//  NYTSports
//
//  Created by Karim ElNaggar on 2/6/18.
//  Copyright © 2018 karimelnaggar. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftWebVC

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    var controller: SportsArticle! {
        didSet {
            if let _ = self.viewIfLoaded {
                scrollView.isHidden = false
                configureView()
            }
        }
    }


    func configureView() {
        let multimediaItem = controller.multimediaItems.last!
        self.articleImageView.kf.setImage(with: URL(string: multimediaItem.url)!)
        self.dateLabel.text = controller.updatedDate.padding(toLength: 10, withPad: " ", startingAt: 0)
        self.authorLabel.text = controller.byline
        self.titleLabel.text = controller.title
        self.abstractLabel.text = controller.abstract
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = controller {
            scrollView.isHidden = false
            configureView()
        } else {
            scrollView.isHidden = true
        }
    }
    
    @IBAction func readFullArticleButtonDidPress(_ sender: UIButton) {
        let webVC = SwiftModalWebVC(urlString: controller.url)
        self.present(webVC, animated: true, completion: nil)
    }
}

