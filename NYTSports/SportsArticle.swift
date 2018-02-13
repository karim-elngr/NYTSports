//
//  SportsArticle.swift
//  NYTSports
//
//  Created by Karim ElNaggar on 2/6/18.
//  Copyright © 2018 karimelnaggar. All rights reserved.
//

import Foundation

struct MultiMediaItem {
    let url: String
    let format: String
    let height: Int
    let width: Int
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    
    init?(_ json: jsonDict) {
        guard let url = json["url"] as? String,
            let format = json["format"] as? String,
            let height = json["height"] as? Int,
            let width = json["width"] as? Int,
            let type = json["type"] as? String,
            let subtype = json["subtype"] as? String,
            let caption = json["caption"] as? String,
            let copyright = json["copyright"] as? String else {
            return nil
        }
        
        self.url = url
        self.format = format
        self.height = height
        self.width = width
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
    }
}

struct SportsArticle {
    // MARK: - Instance Properties
    let section: String
    let subsection: String
    let title: String
    let abstract: String
    let url: String
    let byline: String
    let itemType: String
    let updatedDate: String
    let multimediaItems: [MultiMediaItem]
    
    
    // MARK: - Initializers
    init?(_ json: jsonDict) {
        guard let section = json["section"] as? String,
            let subsection = json["subsection"] as? String,
            let title = json["title"] as? String,
            let abstract = json["abstract"] as? String,
            let url = json["url"] as? String,
            let byline = json["byline"] as? String,
            let itemType = json["item_type"] as? String,
            let updatedDate = json["updated_date"] as? String,
            let multimedia = json["multimedia"] as? [jsonDict] else {
            return nil
        }
        
        var multimediaItems: [MultiMediaItem] = []
        for item in multimedia {
            if let item = MultiMediaItem(item) {
                multimediaItems.append(item)
            }
        }
        
        self.section = section
        self.subsection = subsection
        self.title = title
        self.abstract = abstract
        self.url = url
        self.byline = byline
        self.itemType = itemType
        self.updatedDate = updatedDate
        self.multimediaItems = multimediaItems
    }
    
    // MARK: - Static Actions
    static func parseList(_ json: [jsonDict]) -> [SportsArticle] {
        var articles: [SportsArticle] = []
        for article in json {
            if let article = SportsArticle(article) {
                articles.append(article)
            }
        }
        return articles
    }
}
