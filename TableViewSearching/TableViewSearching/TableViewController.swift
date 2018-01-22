//
//  TableViewController.swift
//  TableViewSearching
//
//  Created by Laxmikanth on 1/12/18.
//  Copyright © 2018 BRN. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController,UISearchResultsUpdating,UISearchBarDelegate {

    var contactAArray = ["Akhil","Anvesh","Achary","AmirKhan","AkshayKumar","Akhira","Ali","AmirKhan","Ajay"]
    var contactBArray = ["Bhanu","Balu","Bhaji","Bhargav","Ballaladeva","Bijjaladeva","Bhargavi","Balaji"]
    var contactCArray = ["Chandu","Chandrakala","Chintu","Cherry","Chandamama","Charusheela"]
    var contactsArray = ["Ajay","Ramesh","Rahul","Suresh","Akhil","Ajesh","Karan","KapilDev","Sunil"]
    
    var bullObj = BullShit()
    
    
    //var gg =
    
    
    
    
    var searchControllerObj = UISearchController(searchResultsController: nil)
    
    
    var filteredAArray:[String]?
    var filteredBArray:[String]?
    var filteredCArray:[String]?
    
    
    
  
    
        override func viewDidLoad() {
        super.viewDidLoad()

            self.searchControllerObj.dimsBackgroundDuringPresentation=false
            // this hide search bar on next VC,
            self.definesPresentationContext=true
            
            //self.searchControllerObj.searchBar.sizeToFit()
            //self.searchDisplayController?.searchResultsTableView.allowsMultipleSelection = true
        self.clearsSelectionOnViewWillAppear = true
        
            contactsArray.sort(by: {$0 < $1})
            print(contactsArray)
        //self.searchControllerObj.lay
        self.searchControllerObj.searchResultsUpdater=self
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.tableHeaderView=self.searchControllerObj.searchBar
    }

    
   
    
    
    func updateSearchResults(for searchController: UISearchController)
    {
        print("Typed Letter is \(String(describing: searchController.searchBar.text))")
        
        
        let predicate = NSPredicate(format: "SELF beginswith[c] %@", self.searchControllerObj.searchBar.text!)
        
        
        filteredAArray=(self.contactAArray as NSArray).filtered(using: predicate) as? [String]
        
        filteredBArray=(self.contactBArray as NSArray).filtered(using: predicate) as? [String]
        filteredCArray=(self.contactCArray as NSArray).filtered(using: predicate) as? [String]
        self.tableView.reloadData()
        print("Typed letter contains in \(String(describing: filteredAArray))")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section==0 {
            if self.searchControllerObj.isActive==true
            {
                return (self.filteredAArray?.count)!
            }
            else
            {
                return self.contactAArray.count
            }

        }
        else if section==1
        {
            if self.searchControllerObj.isActive==true
            {
                return (self.filteredBArray?.count)!
            }
            else
            {
                return self.contactBArray.count
            }
        }
        else
        {
            if self.searchControllerObj.isActive==true
            {
                return (self.filteredCArray?.count)!
            }
            else
            {
                return self.contactCArray.count
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0 {
            return "A"
        }
        else if section==1
        {
            return "B"
        }
        else
        {
            return "C"
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let displayRef = self.storyboard?.instantiateViewController(withIdentifier: "DisplaySID")as! DisplayingVC
        
        if searchControllerObj.isActive==true
        {
           print("You are in this Filtered Section")
            
        }
        else
        {
            print("You are not in this Filtered Section")
        }
        self.navigationController?.pushViewController(displayRef, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactID", for: indexPath)

        if indexPath.section==0
        {
            if self.searchControllerObj.isActive==true
            {
                self.filteredAArray?.sort(by: {$0<$1})
                cell.textLabel?.text=self.filteredAArray?[indexPath.row]
            }
            else
            {
                self.contactAArray.sort(by: {$0<$1})
              cell.textLabel?.text=self.contactAArray[indexPath.row]
            }
        }
        else if indexPath.section==1
        {
            if self.searchControllerObj.isActive==true
            {
                cell.textLabel?.text=self.filteredBArray?[indexPath.row]
            }
            else
            {
                cell.textLabel?.text=self.contactBArray[indexPath.row]
            }
        }
        else
        {
            if self.searchControllerObj.isActive==true
            {
                cell.textLabel?.text=self.filteredCArray?[indexPath.row]
            }
            else
            {
                
                cell.textLabel?.text=self.contactCArray[indexPath.row]
                
            }
       }
      return cell
    }
    

    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool
    {
        return false
    }
    
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
