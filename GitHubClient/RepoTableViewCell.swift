//
//  RepoTableViewCell.swift
//  GitHubClient
//
//  Created by Nadezhda Demidovich on 9/1/17.
//  Copyright © 2017 Nadezhda Demidovich. All rights reserved.
//

import UIKit
import AutoLayoutHelperSwift

class RepoTableViewCell: UITableViewCell {

    //MARK: Properties
    var headerLabel = UILabel()
    var contentLabel = UILabel()
    var dateLabel = UILabel()
    var additionalInfoLabel = UITextView()
    
    //MARK: Constants
    let arialFontName = "Arial"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.additionalInfoLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Font settings
        headerLabel.font = UIFont(name: arialFontName, size: 16)
        contentLabel.font = UIFont(name: arialFontName, size: 12)
        dateLabel.font = UIFont(name: arialFontName, size: 9)
        dateLabel.textAlignment = .right
        additionalInfoLabel.font = UIFont(name: arialFontName, size: 13)
        contentLabel.isUserInteractionEnabled = false
        additionalInfoLabel.isUserInteractionEnabled = false
        
        //Autolayout
        headerLabel.addLeftConstraint(toView: contentView, attribute: .left, relation: .equal, constant: 15)
        headerLabel.addHeightConstraint(toView: nil, relation: .equal,constant: 20)
        headerLabel.addWidthConstraint(toView: nil, relation: .lessThanOrEqual, constant: 500)
        headerLabel.addTopConstraint(toView: contentView, attribute: .top, relation: .equal, constant: 15)
        
        dateLabel.addRightConstraint(toView: contentView, attribute: .right, relation: .equal, constant: -15)
        dateLabel.addWidthConstraint(toView: nil, relation: .equal, constant: 110)
        dateLabel.addHeightConstraint(toView: nil, relation: .equal, constant: 20)
        dateLabel.addTopConstraint(toView: contentView, attribute: .top, relation: .equal, constant: 15)
        dateLabel.addLeftConstraint(toView: headerLabel, attribute: .right, relation: .greaterThanOrEqual, constant: 10)
        
        additionalInfoLabel.addLeftConstraint(toView: contentView, attribute: .left, relation: .equal, constant: 15)
        additionalInfoLabel.addHeightConstraint(toView: nil, relation: .equal,constant: 25)
        additionalInfoLabel.addWidthConstraint(toView: nil, relation: .lessThanOrEqual, constant: 400)
        additionalInfoLabel.addTopConstraint(toView: headerLabel, attribute: .bottom, relation: .equal, constant: 5)
        additionalInfoLabel.addRightConstraint(toView: contentView, attribute: .right, relation: .greaterThanOrEqual, constant: -15)
        

        contentLabel.numberOfLines = 5
        contentLabel.addLeftConstraint(toView: contentView, attribute: .left, relation: .equal, constant: 15)
        contentLabel.addHeightConstraint(toView: nil, relation: .greaterThanOrEqual,constant: 50)
        contentLabel.addWidthConstraint(toView: nil, relation: .lessThanOrEqual, constant: 400)
        contentLabel.addRightConstraint(toView: contentView, attribute: .right, relation: .lessThanOrEqual, constant: -15)
        contentLabel.addTopConstraint(toView: additionalInfoLabel, attribute: .bottom, relation: .equal, constant: 5)
        contentLabel.addBottomConstraint(toView: contentView, attribute: .bottom, relation: .lessThanOrEqual, constant: -15)
        
        
    }
}
