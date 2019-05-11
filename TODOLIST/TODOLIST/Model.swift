//
//  Model.swift
//  TODOLIST
//
//  Created by Adakhanau on 26/04/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import Foundation


class Tasks {
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


func addItem(nameItem: String, descriptionItem: String, isCompleted: Bool = false) {
    todoTasks.append(Tasks(name: nameItem, description: descriptionItem, completed: isCompleted))
}

func removeItem(at index: Int) {
    todoTasks.remove(at: index)
}

func moveItem(fromIndex: Int, toIndex: Int) {
    let from = todoTasks[fromIndex]
    todoTasks.remove(at: fromIndex)
    todoTasks.insert(from, at: toIndex)
}

func changeState(at item: Int) -> Bool {
    todoTasks[item].completed = !(todoTasks[item].completed)
    
    return (todoTasks[item].completed)
}




