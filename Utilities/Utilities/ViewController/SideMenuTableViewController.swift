//
//  SideMenuTableViewController.swift
//  TODOLIST
//
//  Created by Adakhanau on 10/05/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        switch indexPath.row {
        case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowTodolist"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowStopwatch"), object: nil)
        default: break
        }
    }
}
