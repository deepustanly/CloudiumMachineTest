//
//  NewsTableViewCell.swift
//  Machine Test Cloudium
//
//  Created by Deepu Stanly on 21/09/21.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var autherLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newsImageView.layer.cornerRadius = newsImageView.frame.height/2
    }
    
    func fillData(newsData: News){
        titleLbl.text = newsData.title
        autherLbl.text = newsData.author
        dateLbl.text = newsData.date
        
        if let imageUrl = newsData.media.first?.photos.first?.url{
            let url = URL(string: imageUrl)
            newsImageView.kf.setImage(with: url)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
