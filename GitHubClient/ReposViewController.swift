//
//  ReposViewController.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import UIKit
import URLNavigator
import EZAlertController

final class ReposViewController: UIViewController {

    //MARK: Constants
    let userName : String
    let reuseIdentifier = "repoCell"
    
    //MARK: Properties
    var tableView = UITableView()
    var repos = [Repo]() {
        didSet{
            tableView.reloadData()
        }
    }
    var navigationBar : UINavigationBar!
    
    
    //MARK: Inits
    init(userName: String) {
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Table view
        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        //Nav menu
        self.navigationBar = UINavigationBar()
        let navItem = UINavigationItem(title: "Repositories")
        navigationBar.setItems([navItem], animated: true)
        self.view.addSubview(navigationBar)
    }
    
    // MARK: Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let windowWidth = Int(view.bounds.width)
        let windowHeight = Int(view.bounds.height)
        let navigationBarHeight = 44
        tableView.frame = CGRect(x: 0, y: statusBarHeight + navigationBarHeight, width: windowWidth, height: windowHeight - navigationBarHeight - statusBarHeight)
        self.navigationBar.frame = CGRect(x: 0,
                                                           y: statusBarHeight,
                                                           width: windowWidth, height: navigationBarHeight)
        self.navigationBar.barTintColor = UIColor(red: 202.0 / 255.0, green: 217.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ServiceManager.instance.getRepos(userName: userName, completion: {
            [weak self] (repos, error) in
            guard self != nil else {
                return
            }
            if repos != nil {
                self?.repos = repos!
            } else {
                if error != nil {
                    EZAlertController.alert("Error", message: error!.getErrorMessage(), acceptMessage: "OK") {}
                }
            }
        })
    }
}

//MARK : Extentions

// MARK: - UITableViewDelegate

extension ReposViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let repo = self.repos[indexPath.row]
        Navigator.present("navigator://commits/\(userName)/\(repo.name)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RepoTableViewCell
        let repo = self.repos[indexPath.row]
        cell.headerLabel.text = repo.name
        cell.additionalInfoLabel.text = repo.author
        cell.dateLabel.text = repo.date
        cell.contentLabel.text = repo.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}


//MARK: Navigator
extension ReposViewController: URLNavigable {
    convenience init?(navigation: Navigation) {
        let userName = navigation.values["userName"] as? String?
        
        guard userName != nil else {
            return nil
        }
        
        self.init(userName : userName!!)
    }
}
