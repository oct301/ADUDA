//
//  received_request.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 13..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase
/*

class received_request: UITableViewController {
    var requests = [request]()
    var users = [mod_user]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = FIRAuth.auth()?.currentUser
        
        let ref = FIRDatabase.database().reference()
        
        var UserRef = ref.child("users").child(user!.uid).child("Info")
        UserRef.observe(.value){ ( snap: FIRDataSnapshot) in
            if  snap.exists() {
                if let dictionary = snap.value as? [String: AnyObject] {
                    let tmp = mod_user(dictionary: dictionary)
                    cur_user = tmp
                    //print(cur_user.ID)
                }
            }
            self.tableView.reloadData()
        }
        
        FIRDatabase.database().reference().child("request").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let req = request(dictionary: dictionary)
                
                //print("cur_user: " + cur_user.ID!)
                if(req.receiver_ == cur_user.ID && req.status_ == "waiting"){
                    self.requests.append(req)
                    //print(self.users[0].ID)
                    //print(self.users.count)
                }
            }
            
            self.tableView.reloadData()
            
        }, withCancel: nil)
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                //개인 auth키
                let ky = snapshot.key
                
                FIRDatabase.database().reference().child("users").child(ky).observe(.childAdded, with: { (snapshot) in
                    
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let tmp = mod_user(dictionary: dictionary)
                        
                        for req in self.requests {
                            if req.sender_ == tmp.ID {
                                self.users.append(tmp)
                            }
                        }
                        //self.users.append(tmp)
                        //print(self.users[0].ID)
                        //print(self.users.count)
                    }
                    
                    //Once you created all your users, you should call tableView.reloadData()
                    self.tableView.reloadData()
                }
                    , withCancel: nil)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
            }
            
        } , withCancel: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requests.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "received_user_cell", for: indexPath)
        //print(users.count)
        let temp = requests[indexPath.row]
        
        
        cell.textLabel?.text? = requests[indexPath.row].sender_
        
        return cell
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { if segue.identifier == "received_user_segue" {
        print("users cnt: ", users.count)
        if let destination = segue.destination as? searched_user_info {
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                let id = requests[selectedIndex].sender_
                var dest_user = mod_user()
                for us in users {
                    if(us.ID == id){
                        dest_user = us
                    }
                }
                destination.selected_user = dest_user as mod_user
                destination.display_type = 3
            }
        }
        }
    }
}*/
