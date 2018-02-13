//
//  NYTTopSportsArticlesAPI.swift
//  NYTSports
//
//  Created by Karim ElNaggar on 2/6/18.
//  Copyright © 2018 karimelnaggar. All rights reserved.
//

import Foundation

class NYTTopSportsArticlesAPI {
    // MARK:- API EndPoint Constants
    fileprivate static let url = "https://api.nytimes.com/svc/topstories/v2/sports.json"
    fileprivate static let apiKey = "4502f94f83294af38486f1cd662babba"
    
    // MARK:- URLRequest Properties
    private var request: URLSessionDataTask?
    
    // MARK:- Helper Computed Properties
    private var session: URLSession {
        return URLSession.shared
    }
    
    fileprivate static let parameters = [
        "api-key": "4502f94f83294af38486f1cd662babba"
    ]
    
    private var urlRequest: URLRequest {
        var components = URLComponents(string: NYTTopSportsArticlesAPI.url)!
        components.queryItems = NYTTopSportsArticlesAPI.parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Content-Type": "application/json",
        ]
        return urlRequest
    }
    
    // MARK:- Actions
    func fetch(_ completionClosure: @escaping ([SportsArticle]) -> Void) {
        if let _ = self.request {
            self.request?.cancel()
            self.request = nil
        }
        request = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) else {
                return
            }
            guard let jsonResponse = jsonObject as? jsonDict else {
                return
            }
            guard let sportsArticlesJson = jsonResponse["results"] as? [jsonDict] else {
                return
            }
            let sportsArticles = SportsArticle.parseList(sportsArticlesJson)
            completionClosure(sportsArticles)
        })
        request?.resume()
    }
}
