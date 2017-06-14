//
//  request_and_search.swift
//  proj_modify
//
//  Created by 이경준 on 2017. 6. 14..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase

class request_and_search: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var SendTableView: UITableView!
    @IBOutlet weak var ReceiveTableView: UITableView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    var send_requests = [request]()
    var receive_requests = [request]()
    var send_users = [mod_user]()
    var receive_users = [mod_user]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SendTableView.delegate = self
        self.SendTableView.dataSource = self
        self.ReceiveTableView.delegate = self
        self.ReceiveTableView.dataSource = self
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
            self.SendTableView.reloadData()
            self.ReceiveTableView.reloadData()
        }
        
    FIRDatabase.database().reference().child("request").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let req = request(dictionary: dictionary)
    
                //보낸 요청
                if(req.sender_ == cur_user.ID){
                    self.send_requests.append(req)
                    //print(self.users[0].ID)
                    //print(self.users.count)
                }
                else if(req.receiver_ == cur_user.ID){
                    self.receive_requests.append(req)
                }
            }
            
            self.SendTableView.reloadData()
            self.ReceiveTableView.reloadData()
            
        }, withCancel: nil)
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                //개인 auth키
                let ky = snapshot.key
                
                FIRDatabase.database().reference().child("users").child(ky).observe(.childAdded, with: { (snapshot) in
                    
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let tmp = mod_user(dictionary: dictionary)
                        
                        for req in self.send_requests {
                            if req.receiver_ == tmp.ID {
                                self.send_users.append(tmp)
                            }
                        }
                        
                        for req in self.receive_requests {
                            if req.sender_ == tmp.ID {
                                self.receive_users.append(tmp)
                            }
                        }
                        //self.users.append(tmp)
                        //print(self.users[0].ID)
                        //print(self.users.count)
                    }
                    
                    //Once you created all your users, you should call tableView.reloadData()
                }
                    , withCancel: nil)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
            }
            
        } , withCancel: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.SendTableView {
            count = self.send_requests.count
        }
        
        if tableView == self.ReceiveTableView {
            count =  self.receive_requests.count
        }
        
        return count!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == SendTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "sendtablecell", for: indexPath)
            //let temp = requests[indexPath.row]
        
            cell?.textLabel?.text = self.send_requests[indexPath.row].receiver_
           
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "receivetablecell", for: indexPath)
            //let temp = requests[indexPath.row]
            
             cell?.textLabel?.text = self.receive_requests[indexPath.row].sender_
      
        }
        
        return cell!
    }
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == SendTableView {
            return "보낸 요청"
        }
        else {
            return "받은 요청"
        }
    }*/
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func find_as_id (name: String, completion: @escaping (mod_user) -> ()) {
        var result:mod_user?
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                //개인 auth키
                let ky = snapshot.key
                
                FIRDatabase.database().reference().child("users").child(ky).observe(.childAdded, with: { (snapshot) in
                    
                    /*
                     for childSnap in  snapshot.children.allObjects {
                     let snap = childSnap as! FIRDataSnapshot
                     print(snap.key) // 제대로 동작
                     }
                     */
                    print("Abb")
                    print(name)

                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        print("Aab")

                        let tmp = mod_user(dictionary: dictionary)
                       

                            if tmp.ID == name {
                               
                                result = tmp
                                completion(result!)
                            }
                    }
                }
                    , withCancel: nil)
            }
            
        } , withCancel: nil)

        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sending_user_segue" {
            //print("users cnt: ", users.count)
            if let destination = segue.destination as? searched_user_info {
                //print("a")
                if let selectedIndex = self.SendTableView.indexPathForSelectedRow?.row {
                    let id = send_requests[selectedIndex].receiver_
                    var dest_user = mod_user()
                    for us in send_users {
                        if(us.ID == id){
                            dest_user = us
                            print(dest_user)
                        }
                    }
                    destination.selected_user = dest_user as mod_user
                    destination.display_type = 2
                }
            }
        }
        if segue.identifier == "received_user_segue" {
            //print("users cnt: ", users.count)
            if let destination = segue.destination as? searched_user_info {
                //print("a")
                if let selectedIndex = self.ReceiveTableView.indexPathForSelectedRow?.row {
                    let id = receive_requests[selectedIndex].sender_
                    var dest_user = mod_user()
                    for us in receive_users {
                        if(us.ID == id){
                            dest_user = us
                            print(dest_user)

                        }
                    }
                    destination.selected_user = dest_user as mod_user
                    destination.display_type = 1
                }
            }
        }
        
    }
}
