//
//  ViewController.swift
//  ShuffleTableTask
//
//  Created by Andrii's Macbook  on 12.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private lazy var stringArray: [String] = []
    var selectedIndex: [IndexPath] = []
    
    var items: [Item] = [
        Item(title: "0"),
        Item(title: "1"),
        Item(title: "2"),
        Item(title: "3"),
        Item(title: "4"),
        Item(title: "5"),
        Item(title: "6"),
        Item(title: "7"),
        Item(title: "8"),
        Item(title: "9"),
        Item(title: "10"),
        Item(title: "11"),
        Item(title: "12"),
        Item(title: "13"),
        Item(title: "14"),
        Item(title: "15"),
        Item(title: "16"),
        Item(title: "17"),
        Item(title: "18"),
        Item(title: "19"),
        Item(title: "20"),
        Item(title: "21"),
        Item(title: "22"),
        Item(title: "21"),
        Item(title: "23"),
        Item(title: "24"),
        Item(title: "25"),
        Item(title: "26"),
        Item(title: "27"),
        Item(title: "28"),
        Item(title: "29"),
        Item(title: "30")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let numbersArray = Array(0...30)
        stringArray = numbersArray.map { String($0) }
        
    }
    
    @IBAction func shuffleAction(_ sender: UIBarButtonItem) {
        items.shuffle()
        tableView.reloadData()
        tableView.layoutIfNeeded()
        UIView.transition(with: tableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() },
                          completion: nil)
    }
    
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ////        let selectedItem = stringArray.remove(at: indexPath.row)
        ////        stringArray.insert(selectedItem, at: 0)
        ////        tableView.beginUpdates()
        ////        tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
        ////        tableView.endUpdates()
        //
        //
        //        // Deselect the row if you want
        //        //tableView.deselectRow(at: IndexPath(row: 0, section: 0), animated: true)
        //        print("TYT")
        //        print(indexPath)
        //        if let index = selectedIndex.firstIndex(of: indexPath) {
        //            selectedIndex.remove(at: index)
        //        } else {
        //            let selectedItem = stringArray.remove(at: indexPath.row)
        //            stringArray.insert(selectedItem, at: 0)
        //            tableView.beginUpdates()
        //            tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
        //            tableView.endUpdates()
        ////            if let index = selectedIndex.firstIndex(of: indexPath) {
        ////            let indexPath = selectedIndex.remove(at: index)
        ////            self.selectedIndex = selectedIndex.map { (var item) in
        ////                item = IndexPath(row: 0, section: 0)
        ////            }
        ////            }
        //            selectedIndex.append(IndexPath(row: 0, section: 0))
        //        }
        //
        //        // Update the table view with animation
        //
        //
        //        // Reload the selected row to update the checkmark
        //
        //        self.tableView.reloadData()
        
        //        tableView.deselectRow(at: indexPath, animated: true)
        //
        //        if items[indexPath.row].isChecked {
        //            items[indexPath.row].isChecked = false
        //            tableView.reloadRows(at: [indexPath], with: .automatic)
        //            return
        //        }
        //
        //        var item = items[indexPath.row]
        //        item.isChecked = true
        //
        //        if indexPath.row != 0 {
        //            items.remove(at: indexPath.row)
        //            items.insert(item, at: 0)
        //
        //            let firstIndexPath = IndexPath(row: 0, section: 0)
        //            tableView.performBatchUpdates({
        //                //tableView.beginUpdates()
        //                tableView.moveRow(at: indexPath, to: firstIndexPath)
        //                //tableView.endUpdates()
        //                tableView.reloadRows(at: [firstIndexPath], with: .automatic)
        //            }, completion: nil)
        //        } else {
        //            items[0] = item
        //            tableView.reloadRows(at: [indexPath], with: .automatic)
        //        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if items[indexPath.row].isChecked {
            // Simply uncheck and reload if the item is already checked.
            items[indexPath.row].isChecked = false
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else if indexPath.row == 0 {
            // If it's already the first item, simply update its checked state.
            items[0].isChecked = true
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            // For other items, move the selected item to the top and set it as checked.
            var selectedItem = items[indexPath.row]
            selectedItem.isChecked = true
            items.remove(at: indexPath.row)
            items.insert(selectedItem, at: 0)
            
            tableView.performBatchUpdates({
                tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
                tableView.reloadData()
                // tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }, completion: nil)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        //        print("here-1")
        //        print(selectedIndex)
        //        print("here-2")
        //        print(indexPath)
        //        cell.textLabel?.text = stringArray[indexPath.row]
        //        if selectedIndex.contains(indexPath) {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }
        //        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        
        if items[indexPath.row].isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}


struct Item {
    var title: String
    var isChecked: Bool = false
}

final class NumberTableViewCell: UITableViewCell {
    
}
