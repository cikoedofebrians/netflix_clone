//
//  TitleCollectionViewCell.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 24/06/23.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    

    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: String){
        let rawUrl = "\(Constant.imageBaseUrl)/t/p/w500\(model)?api_key=\(Constant.tmdbAPIKey)"
        guard let url = URL(string: rawUrl) else {return}
        posterImageView.sd_setImage(with: url)
    }
}
