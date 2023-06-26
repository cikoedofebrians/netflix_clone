//
//  HomeViewController.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 23/06/23.
//

import UIKit
import CryptoKit


class HomeViewController: UIViewController {
    
    
    private var headerView: HeroHeaderUIView?
    let sectionList: [String] = ["Trending Movies",  "Trending Tv", "Popular","Upcoming Movies", "Top Rated"]
    let homeTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        homeTable.delegate = self
        homeTable.dataSource = self
        view.addSubview(homeTable)
        configureNavbar()
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeTable.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTable.frame = view.bounds
    }
    
    func configureNavbar(){
        navigationController?.navigationBar.tintColor = .white
        var netflixLogo = UIImage(named: "netflixLogo")
        netflixLogo = netflixLogo?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem =   UIBarButtonItem(image: netflixLogo, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let result):
                    guard let randomElementImageURL = result.randomElement()?.poster_path else {
                        return
                    }
                    self.headerView?.configure(with: randomElementImageURL)
                    cell.configure(with: result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTv { result in
                switch result {
                case .success(let result):
                    cell.configure(with: result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result {
                case .success(let result):
                    cell.configure(with: result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let result):
                    cell.configure(with: result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies{ result in
                switch result {
                case .success(let result):
                    cell.configure(with: result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.textColor = .white
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}


extension String {
    func md5() -> String {
        Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}


extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapped(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async {
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
     
    }
}

