//
//  NewsDetailsViewController.swift
//  Machine Test Cloudium
//
//  Created by Deepu Stanly on 23/09/21.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var news : News!

    @IBOutlet weak var newsTitleLbl: UILabel!
    @IBOutlet weak var contentLbl: UITextView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsAuthorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    func configureViews() {
        title = news.section
        newsTitleLbl.text = news.title
        contentLbl.text = news.abstract
        dateLbl.text = news.updatedDate
        if let imageUrl = news.media.first?.photos[2].url{
            let url = URL(string: imageUrl)
            newsImageView.kf.setImage(with: url)
        }
        newsAuthorLbl.text = news.author
    }

}
