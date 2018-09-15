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
    
    private var tableView = UITableView()
    
    private var settings = [[Settings]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePictureView.image = UIImage(named: "profilePicture")
        profilePictureView.contentMode = .scaleAspectFill
        
        publicName.font = UIFont(name: "Roboto-Medium", size: 23)
        publicName.textColor = UIColor(red:0.00, green:0.05, blue:0.25, alpha:1.0)
        publicName.textAlignment = .left
        
        email.font = UIFont(name: "Roboto-Regular", size: 18)
        email.textColor = .gray
        email.textAlignment = .left
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.allowsMultipleSelection = false
        tableView.alwaysBounceVertical = true
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        profilePictureView.alpha = 0
        publicName.alpha = 0
        email.alpha = 0
        tableView.alpha = 0
        
        initData()
        
        tableView.reloadData()
        
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
        
        let sections = ["Notifications", "Social", "Privacy"]
        
        for i in 0..<3 {
            
            settings.append([Settings]())
            
            for j in 0..<4 {
             
                settings[i].append(Settings(sectionName: sections[i], name: "Push Notifications \(j)", type: .onOff))
            }
        }
    }
    
}

// MARK: Table View Delegate
extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Section: \(settings[indexPath.section][indexPath.row].sectionName)")
        print("Row: \(settings[indexPath.section][indexPath.row].name)")
    }
    
    
}

// MARK: Table View Datasource
extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(settings[indexPath.section][indexPath.row].name)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings[section][0].sectionName
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
