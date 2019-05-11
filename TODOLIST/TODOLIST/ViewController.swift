//
//  ViewController.swift
//  TODOLIST
//
//  Created by Adakhanau on 07/05/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
 
    
    @IBAction func addButton(_ sender: Any) {
        let newName = nameTextField.text
        let newDesc = descriptionTextField.text
        
        if newName != "" {
            addItem(nameItem: newName!, descriptionItem: newDesc!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
}
