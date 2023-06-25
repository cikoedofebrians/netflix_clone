//
//  TitleTableViewCell.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 25/06/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    private let playButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImageView)
        contentView.addSubview(label)
        contentView.addSubview(playButton)
        
        applyConstraint()
    }
    
    private func applyConstraint(){
        let posterImageViewConstraint = [

            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  10),
            posterImageView.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]

        let playButtonConstraint = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 50)
        ]
        
        let labelConstraint = [
            label.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant:  -20),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraint)
        NSLayoutConstraint.activate(posterImageViewConstraint)
        NSLayoutConstraint.activate(labelConstraint)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: TitleViewModel){
        label.text = model.titleName
        let rawUrl = "\(Constant.imageBaseUrl)/t/p/w500\(model.posterURL)?api_key=\(Constant.tmdbAPIKey)"
        guard let url = URL(string: rawUrl) else {return}
        posterImageView.sd_setImage(with: url)
    }
    
}
