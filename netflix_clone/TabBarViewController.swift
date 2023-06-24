//
//  ViewController.swift
//  netflix_clone
//
//  Created by Ciko Edo Febrian on 23/06/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.title = "Home"
        
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc2.title = "Upcoming"
        
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.title = "Search"
        
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        vc4.title = "Downloads"
        
        
        tabBar.tintColor = .label
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }


    
    
}

