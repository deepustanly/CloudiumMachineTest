//
//  HomeViewModel.swift
//  Machine Test Cloudium
//
//  Created by Deepu Stanly on 23/09/21.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didFetchResults()
    func didFailFetch(message: String)
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    let title = "NY Times Most Popular"
    let cellName = "NewsTableViewCell"
    let reuseIdentifier = "NewsCellVC"
    let segue = "NewsDetailsVC"
    
    private var news : [News]?
    
    init() {
        getNews()
    }
    
    private func getNews() {
        let req: NetworkRouter = .news
        NetworkingLayer.shared.request(req, type: [News].self) { (response) in
            if let news = response.results {
                self.fetchSucessfull(news: news)
            } else {
                self.failedFetch(message: response.message)
            }
        }
    }
    
    func failedFetch(message: String) {
        self.delegate?.didFailFetch(message: message)
    }
    
    func fetchSucessfull(news: [News]) {
        self.news = news
        self.delegate?.didFetchResults()
    }
    
    var numberOfRows: Int {
        news?.count ?? 0
    }
    
    func newsAt(index: Int) -> News {
        guard let news = news?[index] else {
            fatalError("News is expected")
        }
        return news
    }
    
}
