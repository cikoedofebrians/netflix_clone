//
//  HeroHeaderUIView.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 23/06/23.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
//        button.widthAnchor.constraint(equalToConstant: 100)
        button.layer.cornerRadius = 8.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func addGradient(){
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor,
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [playButton, downloadButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addGradient()
        backgroundColor = .systemRed
        addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            horizontalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            horizontalStackView.widthAnchor.constraint(equalToConstant: 250),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageView.frame = bounds
    }
    
    public func configure(with imageURL: String){
        let rawUrl = "\(Constant.imageBaseUrl)/t/p/w500\(imageURL)?api_key=\(Constant.tmdbAPIKey)"
        guard let url = URL(string: rawUrl) else {return}
        imageView.sd_setImage(with: url)
    }
}
