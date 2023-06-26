//
//  SearchResultViewController.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 25/06/23.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func searchResultViewControllerDidTapCell(_ model: TitlePreviewViewModel)
}

class SearchResultViewController: UIViewController {
    
    
    public var titles: [Title] = [Title]()
    weak var delegate: SearchResultViewControllerDelegate?
    public let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 15
        let  collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
    
}

extension SearchResultViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchResultCollectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: titles[indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTitle = titles[indexPath.row]
        let selectedTitleName = selectedTitle.original_name ?? selectedTitle.original_title ?? ""
        APICaller.shared.getMovie(with: "\(selectedTitleName) trailer") { result in
            switch result {
            case .success(let youtubeData):
                let previewModel = TitlePreviewViewModel(title: selectedTitleName, youtubeId: youtubeData.id
                    .videoId, overview: selectedTitle.overview ?? "")
                self.delegate?.searchResultViewControllerDidTapCell(previewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

    }
    
    
}
