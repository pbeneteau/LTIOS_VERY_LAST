//
//  SettingsViewController.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-31.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit

class SettingsViewController: ModalViewViewController {
    
    private var profilePictureView = RoundImageView()
    
    private let publicName = UILabel()
    private let email = UILabel()
    
    private var tableView = SettingsTableView()
    
    internal var settingsModel = SettingsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        profilePictureView.image = UIImage(named: "profilePicture")
        profilePictureView.contentMode = .scaleAspectFill
        
        publicName.font = UIFont(name: "Roboto-Medium", size: 23)
        publicName.textColor = UIColor(red:0.00, green:0.05, blue:0.25, alpha:1.0)
        publicName.textAlignment = .left
        
        email.font = UIFont(name: "Roboto-Regular", size: 18)
        email.textColor = .gray
        email.textAlignment = .left
        
        profilePictureView.alpha = 0
        publicName.alpha = 0
        email.alpha = 0
        tableView.alpha = 0
        
        initData()
        
        view.addSubview(profilePictureView)
        view.addSubview(publicName)
        view.addSubview(email)
        view.addSubview(tableView)
        
        view.setNeedsUpdateConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: TimeInterval(0.5), animations: {
            self.profilePictureView.alpha = 1
            self.publicName.alpha = 1
            self.email.alpha = 1
            self.tableView.alpha = 1
        })
    }
    
    func initData() {
        
        profilePictureView.image = mainUserInstance.photo
        publicName.text = mainUserInstance.publicName
        email.text = mainUserInstance.mail
        
        let userSettings = [0: [0: true, 1: false, 2: false],
                            1: [0: true, 1: true],
                            2: [0: false]]
        
        settingsModel = SettingsModel(userSettings: userSettings)
        
        tableView.reloadData()
    }
    
}

// MARK: Table View Delegate & Datasource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsModel.getTotalSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModel.getTotalRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SettingsCell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        
        let section = indexPath.section
        let row = indexPath.row
        
        cell.titleLabel.text = settingsModel.getName(section: section, row: row)
        cell.descriptionLabel.text = settingsModel.getDescription(section: section, row: row)
        cell.switchButton.isOn = settingsModel.getState(section: section, row: row)
        cell.type = settingsModel.getType(section: section, row: row)
        cell.section = section
        cell.row = row
        
        if (row == 0) {
            cell.containerView.position = .first
        } else if (row == settingsModel.getTotalRows(section: section) - 1) {
            cell.containerView.position = .last
        } else {
            cell.containerView.position = .middle
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SettingsHeader") as? SettingsHeaderView else {
            return nil
        }
        
        header.titleLabel.text = settingsModel.getSectionName(section: section)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 2 && indexPath.row == 0) { // Snapchat
            print("Snapchat cell touched")
            
            let SnapchatVC = SnapchatLoginViewController()
            present(SnapchatVC, animated: true, completion: nil)
        }
    }
    
}


// MARK: Constraints
extension SettingsViewController {
    
    override func updateViewConstraints() {
        
        profilePictureView.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(95)
            make.left.equalTo(25)
            make.top.equalTo(25)
        }
        
        publicName.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).multipliedBy(0.7)
            make.height.equalTo(25)
            make.left.equalTo(profilePictureView.snp.right).offset(20)
            make.top.equalTo(40)
        }
        
        email.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view).multipliedBy(0.7)
            make.height.equalTo(20)
            make.top.equalTo(publicName.snp.bottom).offset(10)
            make.left.equalTo(publicName)
        }
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.8)
            make.bottom.equalTo(view)
            make.centerX.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
    
}

