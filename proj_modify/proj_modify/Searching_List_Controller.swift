//
//  Searching_List_Controller.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 8..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase

let Tiers_hierarchy:[String:Int] = ["Challenger":0, "Master":1, "Diamond":2, "Platinum":3, "Gold":4, "Silver":5, "Bronze":6, "Unranked":7]
let Tiers_hierarchy_int_first:[Int:String] = [0:"Challenger", 1:"Master", 2:"Diamond", 3:"Platinum", 4:"Gold", 5:"Silver", 6:"Bronze", 7:"Unranked"]

class Searching_List_Controller: UITableViewController {
    
    var users = [mod_user]()
    var me = mod_user()
    var selected_users = [mod_user]()
    let user = FIRAuth.auth()?.currentUser
    let rootRef = FIRDatabase.database().reference()
    var user_tier:String = ""
    

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
        
        
       // fetchUser()
        selected_fetchUser()
        
    }
    
    // selec_rank_type_2 ( Tiers_hierarchy[cur_user.tier] )
    
    func select_rank_type_2 (hier: Int) -> [String] {
        var tmp_tier_list = [String]()
        tmp_tier_list.append(Tiers_hierarchy_int_first[hier]!)
        if hier != 0 {
            tmp_tier_list.append(Tiers_hierarchy_int_first[hier - 1]!)
        }
        if hier != 7 {
            tmp_tier_list.append(Tiers_hierarchy_int_first[hier + 1]!)
        }
        
        return tmp_tier_list
    }
    
    
    // 내 티어 이상
    func select_rank_type_3 (hier: Int) -> [String] {
        var tmp_tier_list = [String]()
        tmp_tier_list.append(Tiers_hierarchy_int_first[hier]!)
        if hier != 0 {
            tmp_tier_list.append(Tiers_hierarchy_int_first[hier-1]!)
        }
        
        return tmp_tier_list
    }

    
    func selected_fetchUser() {
        users = []
        
        var chk:Bool = false
        var tmp:Int = 0
        var rank_type_2 = [String]()
        var rank_type_3 = [String]()

        
        if info_list.rank_type == 2 || info_list.rank_type == 3 {
            for str in Tiers {
                if(info_list.is_Solo == true && cur_user.Rank_Solo?.contains(str) == true){
                    break
                }
                else if(info_list.is_Solo == false && cur_user.Rank_Free?.contains(str) == true){
                    break
                }
                tmp += 1
            }
            rank_type_2 = select_rank_type_2(hier: tmp)
            rank_type_3 = select_rank_type_3(hier: tmp)
            print(rank_type_3)
        }
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if (snapshot.value as? [String: AnyObject]) != nil {
                //개인 auth키
                let ky = snapshot.key
                
                FIRDatabase.database().reference().child("users").child(ky).observe(.childAdded, with: { (snapshot) in
                    
                    
                    chk = false
                    
                    switch info_list.rank_type {
                        //unrelated to rank
                    case 0:
                        if ky == self.user?.uid {
                            break
                        }
                        chk = false
                        for childSnap in  snapshot.children.allObjects {
                        let snap = childSnap as! FIRDataSnapshot
                            if snap.key == "Line_1" || snap.key == "Line_2" {
                                for str in info_list.position {
                                    if(chk == true){
                                        break
                                    }
                                    if snap.value as! String? == str {
                                        if let dictionary = snapshot.value as? [String: AnyObject] {
                                            let tmp = mod_user(dictionary: dictionary)
                                            self.users.append(tmp)
                                            chk = true
                                        }
                                    }
                                    
                                }
                            }
                        }
                        break
                    
                    case 1:
                        if ky == self.user?.uid {
                            break
                        }
                        chk = false
                        for childSnap in  snapshot.children.allObjects {
                            let snap = childSnap as! FIRDataSnapshot
                           // print(snap.key) // 제대로 동작
                            if snap.key == "Line_1" || snap.key == "Line_2" {
                                for str in info_list.position {
                                    if snap.value as! String? == str {
                                        chk = true
                                    }
                                }
                            }
                            if(snap.key == "Rank_Solo" && info_list.is_Solo == true && chk == true){
                                if snap.value as! String? == "Unranked" {
                                    if let dictionary = snapshot.value as? [String: AnyObject] {
                                        let tmp = mod_user(dictionary: dictionary)
                                        self.users.append(tmp)
                                    }
                                }
                            }
                            else if(snap.key == "Rank_Free" && info_list.is_Solo == false && chk == true) {
                                if snap.value as! String? == "Unranked" {
                                    if let dictionary = snapshot.value as? [String: AnyObject] {
                                        let tmp = mod_user(dictionary: dictionary)
                                        self.users.append(tmp)
                                    }
                                }
                            }
                        }
                        break
                        
                        // 내티어 위아래 또는 내티어
                    case 2:
                        if ky == self.user?.uid {
                            break
                        }
                        chk = false
                        for childSnap in  snapshot.children.allObjects {
                            let snap = childSnap as! FIRDataSnapshot
                            if snap.key == "Line_1" || snap.key == "Line_2" {
                                for str in info_list.position {
                                    if snap.value as! String? == str {
                                        chk = true
                                    }
                                }
                            }
                            if(snap.key == "Rank_Solo" && info_list.is_Solo == true && chk == true){
                                for str in rank_type_2 {
                                    if (snap.value as! String?)?.contains(str) == true {
                                        if let dictionary = snapshot.value as? [String: AnyObject] {
                                            let tmp = mod_user(dictionary: dictionary)
                                            self.users.append(tmp)
                                        }
                                    }
                                }
                            }
                            else if(snap.key == "Rank_Free" && info_list.is_Solo == false && chk == true) {
                                for str in rank_type_2 {
                                    if (snap.value as! String?)?.contains(str) == true {
                                        if let dictionary = snapshot.value as? [String: AnyObject] {
                                            let tmp = mod_user(dictionary: dictionary)
                                            self.users.append(tmp)
                                        }
                                    }
                                }
                            }
                            
                        }
                        break
                    case 3:
                        if ky == self.user?.uid {
                            break
                        }
                        chk = false
                        for childSnap in  snapshot.children.allObjects {
                            let snap = childSnap as! FIRDataSnapshot
                            if snap.key == "Line_1" || snap.key == "Line_2" {
                                for str in info_list.position {
                                    if snap.value as! String? == str {
                                        chk = true
                                    }
                                }
                            }
                            if(snap.key == "Rank_Solo" && info_list.is_Solo == true && chk == true){
                                for str in rank_type_3 {
                                    if (snap.value as! String?)?.contains(str) == true {
                                        if let dictionary = snapshot.value as? [String: AnyObject] {
                                            let tmp = mod_user(dictionary: dictionary)
                                            self.users.append(tmp)
                                        }
                                    }
                                }
                            }
                            else if(snap.key == "Rank_Free" && info_list.is_Solo == false && chk == true) {
                                for str in rank_type_3 {
                                    if (snap.value as! String?)?.contains(str) == true {
                                        if let dictionary = snapshot.value as? [String: AnyObject] {
                                            let tmp = mod_user(dictionary: dictionary)
                                            self.users.append(tmp)
                                        }
                                    }
                                }
                            }
                            
                        }
                        break                    /*
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let tmp = mod_user(dictionary: dictionary)
                        self.users.append(tmp)
                  */
                    default: return
                    }
                   
                    self.tableView.reloadData()
                }
                    , withCancel: nil)
                
            }
            
        } , withCancel: nil)
        
    
    }
    
    func fetchUser() {
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if (snapshot.value as? [String: AnyObject]) != nil {
                
                //개인 auth키
                let ky = snapshot.key
               
                FIRDatabase.database().reference().child("users").child(ky).observe(.childAdded, with: { (snapshot) in
                    
                    /*
                    for childSnap in  snapshot.children.allObjects {
                        let snap = childSnap as! FIRDataSnapshot
                        print(snap.key) // 제대로 동작
                    }
                    */
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let tmp = mod_user(dictionary: dictionary)
                        self.users.append(tmp)
                        //print(self.users[0].ID)
                        //print(self.users.count)
                    }
                        /*
                        if let dict = snapshot.value as? NSDictionary, let postContent = dict["ID"] as? String {
                        //content = postContent
                            print(postContent)
                        } else {
                        //content = ""
                            print("else")
                        }
 */
                    
                    //Once you created all your users, you should call tableView.reloadData()
                     self.tableView.reloadData()
                    }
                    , withCancel: nil)
                /*
                if let dict = snapshot.value as? NSDictionary, let postContent = dict["email"] as? NSDictionary {
                    //content = postContent
                    print(temp)
                } else {
                    //content = ""
                    print("else")
                }
                 */
               // print(snapshot) // info 전체랑 email이랑 name출력
                
                //this will crash because of background thread, so lets use dispatch_async to fix
            }
            
        } , withCancel: nil)
        //print(users.count)
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
        //print(self.users.count)

    
       return users.count
    }
 

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SearchingListTableViewCell
        cell.User_name.text = users[indexPath.row].ID!
        
        cell.User_Tier_Text.text = users[indexPath.row].Rank_Solo!
        for str in Tiers {
            if(users[indexPath.row].Rank_Solo?.contains(str) == true){
                cell.User_Tier_image.image = UIImage(named: str)
                break
            }
        }
        cell.User_Tier_Text2.text = users[indexPath.row].Rank_Free!
        for str in Tiers {
                if(users[indexPath.row].Rank_Free?.contains(str) == true){
                cell.User_Tier_image2.image = UIImage(named: str)
                break
            }
        }
        cell.User_intro.text = users[indexPath.row].introduce
        
        cell.icon.layer.borderWidth = 1
        cell.icon.layer.masksToBounds = false
        cell.icon.layer.borderColor = UIColor.black.cgColor
        cell.icon.layer.cornerRadius = cell.icon.frame.height/2
        cell.icon.clipsToBounds = true
        cell.icon.image = UIImage(named: users[indexPath.row].Champion1!)
        //cell.User_intro.text = users[indexPath.row].Line_1! + " " + users[indexPath.row].Line_2!
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
        if segue.identifier == "selected_user_segue" {
            if let destination = segue.destination as? searched_user_info {
                if let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                    destination.selected_user = users[selectedIndex] as mod_user
                    destination.display_type = 1
                }
            }
        }
    }
    

}
