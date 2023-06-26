//
//  DownloadsViewController.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 23/06/23.
//

import UIKit

class DownloadsViewController: UIViewController {
    var downloadedArray:[Titles] = [Titles]()
    let table: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Downloads"
        table.delegate = self
        table.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(table)
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchDownloadedData()
            
        }
    
        fetchDownloadedData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func fetchDownloadedData(){
        PersistentDataManager.shared.fetchTitles { result in
            switch result{
            case .success(let titles):
                self.downloadedArray = titles
                self.table.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        downloadedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        cell.configure(with: TitleViewModel(posterURL: downloadedArray[indexPath.row].poster_path ?? "", titleName: downloadedArray[indexPath.row].original_name ?? downloadedArray[indexPath.row].original_title ?? "Unknown Title" ))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            PersistentDataManager.shared.deleteTitle(model: downloadedArray[indexPath.row]) { result in
                switch result {
                case .success():
                    self.downloadedArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
  
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let titleName = downloadedArray[indexPath.row].original_name ?? downloadedArray[indexPath.row].original_title ?? ""
        APICaller.shared.getMovie(with: "\(titleName) trailer") { result in
            switch result {
            case .success(let youtubeData ):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeId: youtubeData.id.videoId, overview: self.downloadedArray[indexPath.row].overview ?? ""))
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
