//
//  TableViewController.swift
//  TODOLIST
//
//  Created by Adakhanau on 26/04/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var itemTitle1 = ""
    var itemSubtitle1 = ""
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredTasks = [Tasks]()
    
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Tasks"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        tableView.reloadData()
        
        // SIDE BAR
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
    }
    
    
    //MARK: SERCH BAR
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredTasks = todoTasks.filter({( task : Tasks) -> Bool in
            return task.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering() {
            return filteredTasks.count
        }
        
        return todoTasks.count
    }
    

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let task: Tasks
        if isFiltering() {
            task = filteredTasks[indexPath.row]
        } else {
            task = todoTasks[indexPath.row]
        }
        
        let currentItem = task

        itemTitle1 = currentItem.name
        itemSubtitle1 = currentItem.description
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
        cell.accessoryType = .detailDisclosureButton

        
        let task: Tasks
        if isFiltering() {
            task = filteredTasks[indexPath.row]
        } else {
            task = todoTasks[indexPath.row]
        }
        
        cell.textLabel?.text = (task.name)
        cell.detailTextLabel?.text = (task.description)
        
        
        if (task.completed) == true {
            cell.imageView?.image = UIImage(named: "check.png")
        } else {
            cell.imageView?.image = UIImage(named: "uncheck.png")
        }
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {}
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index: Int
        
        if isFiltering() {
            let currentTask = filteredTasks[indexPath.row]
            let currentIndex = (todoTasks.firstIndex(where: {$0 === currentTask}))
            index = currentIndex!
        } else {
            index = indexPath.row
        }
        
        if changeState(at: index)  {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check.png")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "uncheck.png")
        }
       
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row )
        tableView.reloadData()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let DetailTableViewController = segue.destination as! DetailTableViewController
        DetailTableViewController.subtitleString = itemSubtitle1
        DetailTableViewController.titleString = itemTitle1
    }
  
}

extension TableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
