//
//  request_and_search.swift
//  proj_modify
//
//  Created by 이경준 on 2017. 6. 14..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase

var send_requests = [request]()
var receive_requests = [request]()
var send_users = [mod_user]()
var receive_users = [mod_user]()

class request_and_search: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var SendTableView: UITableView!
    @IBOutlet weak var ReceiveTableView: UITableView!
    @IBAction func F5(_ sender: Any) {
        print(send_requests.count)
        print(send_users.count)
        send_users = [mod_user]()
        receive_users = [mod_user]()
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if (snapshot.value as? [String: AnyObject]) != nil {
                
                //개인 auth키
                let ky = snapshot.key
                
                FIRDatabase.database().reference().child("users").child(ky).observe(.childAdded, with: { (snapshot) in
                    
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let tmp = mod_user(dictionary: dictionary)
                        
                        for req in send_requests {
                            if req.receiver_ == tmp.ID {
                                send_users.append(tmp)
                            }
                        }
                        
                        for req in receive_requests {
                            if req.sender_ == tmp.ID {
                                receive_users.append(tmp)
                            }
                        }
                        //self.users.append(tmp)
                        //print(self.users[0].ID)
                        //print(self.users.count)
                        self.SendTableView.reloadData()
                        self.ReceiveTableView.reloadData()
                    }
                    
                    //Once you created all your users, you should call tableView.reloadData()
                }, withCancel: nil)
                
                //this will crash because of background thread, so lets use dispatch_async to fix
            }
        }, withCancel: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SendTableView.delegate = self
        self.SendTableView.dataSource = self
        self.ReceiveTableView.delegate = self
        self.ReceiveTableView.dataSource = self
        
        send_requests = [request]()
        receive_requests = [request]()
        send_users = [mod_user]()
        receive_users = [mod_user]()
        let user = FIRAuth.auth()?.currentUser
        
        let ref = FIRDatabase.database().reference()
        
        let UserRef = ref.child("users").child(user!.uid).child("Info")
        UserRef.observe(.value){ ( snap: FIRDataSnapshot) in
            if  snap.exists() {
                if let dictionary = snap.value as? [String: AnyObject] {
                    cur_user = mod_user(dictionary: dictionary)
                }
            }
        }
        
    FIRDatabase.database().reference().child("request").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let req = request(dictionary: dictionary)
    
                //보낸 요청
                if(req.sender_ == cur_user.ID && req.status_ == "waiting"){
                    send_requests.append(req)
                }
                else if(req.receiver_ == cur_user.ID && req.status_ == "waiting"){
                    receive_requests.append(req)
                }
        }
        self.SendTableView.reloadData()
        self.ReceiveTableView.reloadData()
        
    }, withCancel: nil)
        
    FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
        if (snapshot.value as? [String: AnyObject]) != nil {
                
            //개인 auth키
            let ky = snapshot.key
                
            FIRDatabase.database().reference().child("users").child(ky).observe(.childAdded, with: { (snapshot) in
                    
                    
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let tmp = mod_user(dictionary: dictionary)
                        
                    for req in send_requests {
                        if req.receiver_ == tmp.ID {
                            send_users.append(tmp)
                        }
                    }
                        
                    for req in receive_requests {
                        if req.sender_ == tmp.ID {
                            receive_users.append(tmp)
                        }
                    }
                    //self.users.append(tmp)
                    //print(self.users[0].ID)
                    //print(self.users.count)
                }
                    
                //Once you created all your users, you should call tableView.reloadData()
            }, withCancel: nil)
            
            //this will crash because of background thread, so lets use dispatch_async to fix
        }
        
        self.SendTableView.reloadData()
        self.ReceiveTableView.reloadData()
        
    }, withCancel: nil)

}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        
        if tableView == self.SendTableView {
            count = send_requests.count
        }
        
        if tableView == self.ReceiveTableView {
            count =  receive_requests.count
        }
        
        return count!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == SendTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sendtablecell", for: indexPath) as! SendTableViewCell
            print(send_requests.count)
            print(send_users.count)
            cell.receiver.text = send_requests[indexPath.row].receiver_
            //cell.Most_cham.image = UIImage(named: send_users[indexPath.row].Champion1! + "_0")
            //cell.intro.text = self.send_users[indexPath.row].introduce!
            cell.icon.layer.masksToBounds = false
            cell.icon.layer.borderColor = UIColor.black.cgColor
            cell.icon.layer.cornerRadius = cell.icon.frame.height/2
            cell.icon.clipsToBounds = true
            /*cell.icon.layer.borderWidth = 1
            
            print(send_users.count)
            cell.Tier_text.text = send_users[indexPath.row].Rank_Solo
            for str in Tiers {
                if(send_users[indexPath.row].Rank_Solo!.contains(str) == true){
                    cell.Tier_image.image = UIImage(named: str)
                    break
                }
            }*/
            return cell
           
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receivetablecell", for: indexPath) as! ReceiveTableViewCell
            
            cell.sender.text = receive_requests[indexPath.row].sender_
            //cell.Most_cham.image = UIImage(named: receive_users[indexPath.row].Champion1! + "_0")
            //cell.intro.text = receive_users[indexPath.row].introduce!
            cell.icon.layer.masksToBounds = false
            cell.icon.layer.borderColor = UIColor.black.cgColor
            cell.icon.layer.cornerRadius = cell.icon.frame.height/2
            cell.icon.clipsToBounds = true

            /*cell.icon.layer.borderWidth = 1
             
            cell.Tier_text.text = receive_users[indexPath.row].Rank_Solo
            for str in Tiers {
                if(receive_users[indexPath.row].Rank_Solo!.contains(str) == true){
                    cell.Tier_image.image = UIImage(named: str)
                    break
                }
            }*/
            return cell
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    func find_as_id (name: String, completion: @escaping (mod_user) -> ()) {
        var result:mod_user?
        
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
                        print("aaaa ")
                        if(us.ID == id){
                            dest_user = us
                            print(dest_user)

                        }
                    }
                    destination.selected_user = dest_user as mod_user
                    destination.display_type = 3
                }
            }
        }
        self.SendTableView.reloadData()
        self.ReceiveTableView.reloadData()
    }
}
