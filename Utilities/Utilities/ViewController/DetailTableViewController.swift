//
//  DetailTableViewController.swift
//  TODOLIST
//
//  Created by Adakhanau on 27/04/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemSubtitle: UILabel!
    
    var titleString = String()
    var subtitleString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemTitle.text = titleString
        itemSubtitle.text = subtitleString
    }
}
