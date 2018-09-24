//
//  SettingsHeaderView.swift
//  LTios
//
//  Created by Paul Bénéteau on 15/09/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import UIKit

class SettingsHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
                
        autoresizingMask = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
