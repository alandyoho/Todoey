//
//  CategoriesTableViewController.swift
//  Todoey
//
//  Created by Alan D. Yoho on 2/24/18.
//  Copyright © 2018 Alan D. Yoho. All rights reserved.
//

import UIKit
import CoreData

class CategoriesTableViewController: UITableViewController {
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
        //array of items
        //context
        
        //ibaction toadd
        //save function
        //load function
        
    }
    
    //MARK: - TableView Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
  
    
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
            
        }
    
    
    
    
    //MARK: - Data Manipulation Metods
    
    
    

    @IBAction func addNewCategory(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "New Category", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add", style: .default) {(alertAction) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.save()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "add new category"
        }
        present(alert, animated: true, completion: nil)
    }

    
    
    func save() {
        do {
            try context.save()
        } catch {
            print("error: \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    func load() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loading data from context: \(error)")
        }
        tableView.reloadData()
        
    }
}
