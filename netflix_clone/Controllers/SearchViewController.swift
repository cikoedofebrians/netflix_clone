//
//  SearchViewController.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 23/06/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    var discoverList: [Title] = [Title]()
    let table: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultViewController())
        searchController.searchBar.placeholder = "Search for a film or a TV show"
        searchController.definesPresentationContext = true
       return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("is this get loaded again?")
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        searchController.searchResultsUpdater = self
        fetchDiscoverData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    private func fetchDiscoverData(){
        APICaller.shared.getDiscoverMovies { results in
            switch results{
            case .success(let titles):
                self.discoverList = titles
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        
        }
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar =  searchController.searchBar
        
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, query.trimmingCharacters(in: .whitespaces).count >= 3, let resultController = searchController.searchResultsController as? SearchResultViewController else {
            print("something gone wrong")
            return}
        
        APICaller.shared.search(with: query) { results in
            switch results {
            case .success(let titles):
                DispatchQueue.main.async {
                    resultController.titles = titles
                    resultController.searchResultCollectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        discoverList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for:  indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        cell.configure(with: TitleViewModel(posterURL: discoverList[indexPath.row].poster_path ?? "", titleName: discoverList[indexPath.row].original_name ?? discoverList[indexPath.row].original_title ?? "Unknown Title" ))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}
