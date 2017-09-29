//
//  CommitsViewController.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import UIKit
import URLNavigator
import EZAlertController

final class CommitsViewController: UIViewController {

    //MARK: Constants
    let userName : String
    let repoName : String
    let reuseIdentifier = "repoCell"
    
    //MARK: Properties
    var tableView = UITableView()
    var navigationBar : UINavigationBar!
    var commits = [Commit]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    
    //MARK: Inits
    init(userName: String, repoName: String) {
        self.userName = userName
        self.repoName = repoName
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

        let navItem = UINavigationItem(title: repoName)
        self.navigationBar.setItems([navItem], animated: true)
        let backItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.plain, target: nil, action: #selector(pressBackButton))
        backItem.tintColor = UIColor.darkGray
        navItem.leftBarButtonItem = backItem
        navigationBar.setItems([navItem], animated: false)
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
        ServiceManager.instance.getCommits (userName: userName, repoName: repoName, since: Date().getDateMonthAgo() ?? Date(), completion: {
            [weak self] (commits, error) in
            guard self != nil else {
                return
            }
            if commits != nil {
                self?.commits = commits!
            } else if error != nil {
                EZAlertController.alert("Error", message: error!.getErrorMessage(), acceptMessage: "OK") {}
            }
        })
    }
    
    //MARK: Actions
    func pressBackButton(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK : Extentions

// MARK: - UITableViewDelegate

extension CommitsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RepoTableViewCell
        let commit = self.commits[indexPath.row]
        cell.headerLabel.text = commit.author
        cell.additionalInfoLabel.text = commit.hash
        cell.dateLabel.text = commit.dateString
        cell.contentLabel.text = commit.message
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

//MARK: Navigator

extension CommitsViewController: URLNavigable {
    convenience init?(navigation: Navigation) {
        let userName = navigation.values["userName"] as? String?
        let repoName = navigation.values["repoName"] as? String?
        guard userName != nil && repoName != nil else {
            return nil
        }
        
        self.init(userName : userName!!, repoName: repoName!!)
    }
}


