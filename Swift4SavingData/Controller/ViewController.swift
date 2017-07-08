//
//  ViewController.swift
//  Swift4SavingData
//
//  Created by Saif Khan on 7/7/17.
//  Copyright © 2017 App Dev Inc. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Constants
    fileprivate let alertTextColor: UIColor = UIColor(red: 0, green: 248, blue: 229, alpha: 1.0)
    
    // MARK: - Private Variables
    fileprivate var people = [Person]()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCoreDataFetchRequest()
    }
    
    // MARK: - IBAction
    @IBAction func addButtonPressed() {
        self.configureTextFieldAddAction()
    }
    
    // MARK: - Private Functions
    fileprivate func createCoreDataFetchRequest() {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            let people = try PersistenceService.context.fetch(fetchRequest)
            self.people = people
            self.tableView.reloadData()
        } catch let error as NSError {
                print(error.localizedDescription)
        }
        
    }
    
    fileprivate func configureTextFieldAddAction() {
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Age"
            textField.keyboardType = .numberPad
        }
        
        let action = UIAlertAction(title: "Post", style: .default) { (UIAlertAction) in
            let name = alert.textFields!.first!.text!
            let age = alert.textFields!.last!.text!
            let person = Person(context: PersistenceService.context)
            person.name = name
            person.age = Int16(age)!
            PersistenceService.saveContext()
            self.people.append(person)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancelAction)
        
        alert.view.tintColor = self.alertTextColor
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension 1 - UITableViewDelegate & UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    // MARK: Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: Number of Rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    // MARK: Cell Configuration and Label Population
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PersonTableViewCell
        cell.nameLabel?.text = ("Name: \(String(describing: people[indexPath.row].name!)) ")
        cell.ageLabel?.text = ("Age: \(String(people[indexPath.row].age))")
        
        return cell
    }
    
    // MARK: Delete Functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            let context: NSManagedObjectContext = PersistenceService.context
            context.delete(people[indexPath.row])
            self.tableView.beginUpdates()
            people.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error.localizedDescription)")
            }
        default:
            return
        }
    }
}
