//
//  Model.swift
//  TODOLIST
//
//  Created by Adakhanau on 26/04/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import Foundation

class Tasks : Codable {
    let name: String
    let description: String
    var completed: Bool
    
    init(name: String, description: String, completed: Bool) {
        self.name = name
        self.description = description
        self.completed = completed
    }
}

var todoTasks = [Tasks]()

// MARK: Functions
// Add task in todoTasks
func addItem(nameItem: String, descriptionItem: String, isCompleted: Bool = false) {
    todoTasks.append(Tasks(name: nameItem, description: descriptionItem, completed: isCompleted))
}

// Delete task from todoTasks
func removeItem(at index: Int) {
    todoTasks.remove(at: index)
}

//  Replace indexies of tasks
func moveItem(fromIndex: Int, toIndex: Int) {
    let from = todoTasks[fromIndex]
    todoTasks.remove(at: fromIndex)
    todoTasks.insert(from, at: toIndex)
}

// Check task
func changeState(at item: Int) -> Bool {
    todoTasks[item].completed = !(todoTasks[item].completed)
    
    return (todoTasks[item].completed)
}

// Save data in UserDefaults
func saveData() {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(todoTasks), forKey:"todo")
    
}

// load data from UserDefaults
func loadData() {
    if let data = UserDefaults.standard.value(forKey:"todo") as? Data {
        let task = try? PropertyListDecoder().decode(Array<Tasks>.self, from: data)
        todoTasks = task!
    }
}
