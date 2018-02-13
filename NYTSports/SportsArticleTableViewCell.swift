//
//  SportsArticleTableViewCell.swift
//  NYTSports
//
//  Created by Karim ElNaggar on 2/13/18.
//  Copyright © 2018 karimelnaggar. All rights reserved.
//

import UIKit
import Kingfisher

class SportsArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var controller: SportsArticle! {
        didSet {
            self.updateView(controller)
        }
    }
    
    override func prepareForReuse() {
        self.thumbImageView.image = nil
        self.textLabel?.text = nil
    }
    
    func updateView(_ sportsArticle: SportsArticle) {
        let multimediaItem = controller.multimediaItems[3]
        self.thumbImageView.kf.setImage(with: URL(string: multimediaItem.url)!)
        self.titleLabel.text = sportsArticle.title
    }

}
