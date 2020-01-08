//
//  PresBoard.swift
//  QRPres
//
//  Created by Sanved on 11/15/19.
//  Copyright © 2020 Sanved. All rights reserved.
//

import UIKit
import CoreData

class PresBoard: UITableViewController {
    
    var itemArray = [Pres]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadItems(with request: NSFetchRequest<Pres> = Pres.fetchRequest(), predicate: NSPredicate? = nil) {
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PresCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        let msg = "\nMorning - " + String(item.morning) + ", Afternoon - " + String(item.afternoon) + ", Night - " + String(item.night)
        
        cell.textLabel?.text = item.name! + msg
        
        return cell
    }

}
