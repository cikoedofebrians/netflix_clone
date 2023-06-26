//
//  TitlePreviewViewController.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 26/06/23.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello Sir"
        label.font = .systemFont(ofSize: 22, weight: .bold)
    
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overviewLabel: UILabel = {
        
        let label = UILabel()
        label.text = "This is for overview"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let trailerView: WKWebView = {
        let view = WKWebView()
        view
            .translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        view.addSubview(trailerView)
        configureConstraint()
    }
    
    func configureConstraint(){
        let trailerConstraint = [
            trailerView.topAnchor.constraint(equalTo: view.topAnchor),
            trailerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trailerView.heightAnchor.constraint(equalToConstant: 300)
        
        ]
        
        let titleLabelConstraint = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  20),
            titleLabel.topAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: 20)
        ]
        
        let overviewConstraint = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        
        let downloadButtonConstraint = [
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        
        NSLayoutConstraint.activate(trailerConstraint)
        NSLayoutConstraint.activate(titleLabelConstraint)
        NSLayoutConstraint.activate(overviewConstraint)
        NSLayoutConstraint.activate(downloadButtonConstraint)
    }
    
    
    public func configure(with model: TitlePreviewViewModel){
        
        titleLabel.text = model.title
        overviewLabel.text = model.overview
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeId)") else {return}
        trailerView.load(URLRequest(url: url))
    }

}
