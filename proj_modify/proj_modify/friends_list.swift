//
//  friends_list.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 15..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase

var friends = [String]()
var friends_ = [mod_user]()

class friends_list: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = FIRAuth.auth()?.currentUser
        
        let ref = FIRDatabase.database().reference()
        
        let UserRef = ref.child("users").child(user!.uid).child("Info")
        UserRef.observe(.value){ ( snap: FIRDataSnapshot) in
            if  snap.exists() {
                if let dictionary = snap.value as? [String: AnyObject] {
                    let tmp = mod_user(dictionary: dictionary)
                    cur_user = tmp
                    //print(cur_user.ID)
                }
            }
        }
        
        FIRDatabase.database().reference().child("request").observe(.childAdded, with: { (snapshot) in
            //print(cur_user.ID)
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let req = request(dictionary: dictionary)
                
                if(req.sender_ == cur_user.ID && req.status_ == "accept"){
                    if(friends.contains(req.receiver_) == false){
                        friends.append(req.receiver_)
                    }
                }
                else if(req.receiver_ == cur_user.ID && req.status_ == "accept") {
                    if(friends.contains(req.sender_) == false){
                        friends.append(req.sender_)
                    }
                }
            }
           self.tableView.reloadData()
            
        }, withCancel: nil)
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if (snapshot.value as? [String: AnyObject]) != nil {
                
                //개인 auth키
                let ky = snapshot.key
                
                FIRDatabase.database().reference().child("users").child(ky).observe(.childAdded, with: { (snapshot) in
                    
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let tmp = mod_user(dictionary: dictionary)
                        
                        for fri in friends {
                            if fri == tmp.ID {
                                friends_.append(tmp)
                            }
                        }
                        
                        //self.users.append(tmp)
                        //print(self.users[0].ID)
                        //print(self.users.count)
                    }
                    
                    //Once you created all your users, you should call  
                   self.tableView.reloadData()
                }
                    
                    , withCancel: nil)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
            }
            
        } , withCancel: nil)

        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        print("num: ", friends_.count)
        // #warning Incomplete implementation, return the number of rows
        return friends_.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friend_cell", for: indexPath) as! SearchingListTableViewCell
        
        
        cell.User_name.text = friends_[indexPath.row].ID!
        cell.background.image = UIImage(named: friends_[indexPath.row].Champion1!+"_0")
        
        cell.User_Tier_Text.text = friends_[indexPath.row].Rank_Solo!
        for str in Tiers {
            if(friends_[indexPath.row].Rank_Solo?.contains(str) == true){
                cell.User_Tier_image.image = UIImage(named: str)
                break
            }
        }
        cell.User_Tier_Text2.text = friends_[indexPath.row].Rank_Free!
        for str in Tiers {
            if(friends_[indexPath.row].Rank_Free?.contains(str) == true){
                cell.User_Tier_image2.image = UIImage(named: str)
                break
            }
        }
        
        cell.icon.layer.borderWidth = 1
        cell.icon.layer.masksToBounds = false
        cell.icon.layer.borderColor = UIColor.black.cgColor
        cell.icon.layer.cornerRadius = cell.icon.frame.height/2
        cell.icon.clipsToBounds = true
        cell.icon.image = UIImage(named: friends_[indexPath.row].Champion1!)
        //cell.User_intro.text = users[indexPath.row].Line_1! + " " + users[indexPath.row].Line_2!
        return cell
        
        // Configure the cell...

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? searched_user_info {
            //print("a")
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                /*let id = friends[selectedIndex]
                var dest_user = mod_user()
                for us in friends_ {
                    if(us.ID == id){
                        dest_user = us
                        print(dest_user)
                    }
                }*/
                destination.friend = friends[selectedIndex]
                destination.selected_user = friends_[selectedIndex]
                destination.display_type = 4
            }
        }
    }
    

}
