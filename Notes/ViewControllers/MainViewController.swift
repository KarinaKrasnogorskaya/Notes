//
//  ViewController.swift
//  Notes
//
//  Created by Карина on 10.01.2023.
//

import UIKit

protocol EditTableViewControllerDelegate {
    func sendText(name: String, descriptio: String, isFavorite: Bool) 
}

class MainViewController: UITableViewController {
    
    var objects = [
        Notes(nameLabel: "Тут будет заголовок", description: "Тут будет описание", isFavorite: false)
    ]
    
  
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Заметки"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let customButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonItem))
        
        self.navigationItem.rightBarButtonItem = customButton
    
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    

   
    
    @objc
    func addButtonItem() {
        let editVC = EditTableViewController()
        let navigationVC = UINavigationController(rootViewController: editVC)
        present(navigationVC, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath)"
        
        var content = cell.defaultContentConfiguration()
        let object = objects[indexPath.row]
        content.text = object.nameLabel
        content.secondaryText = object.description
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedNotes = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedNotes, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let destination = EditTableViewController()
        destination.nameTF.text = objects[indexPath.row].nameLabel
        destination.descriptionTF.text = objects[indexPath.row].description
        destination.title = "Edit"
        destination.delegate = self
      navigationController?.pushViewController(destination, animated: true)
    }
    
    
}


extension MainViewController: EditTableViewControllerDelegate {

    func sendText(name: String, descriptio: String, isFavorite: Bool) {
        let newElement = Notes(nameLabel: name, description: descriptio, isFavorite: false)
        
        let newIndexPath = IndexPath(row: objects.count, section: 0)
        objects.append(newElement)
        tableView.insertRows(at: [newIndexPath], with: .fade)
    }
}


