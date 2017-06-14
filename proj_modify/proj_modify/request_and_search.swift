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
    
    
    
    var requests = [request]()
    
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
                print(snapshot)
                print(req.sender_)
                print(cur_user.ID)
                
                if(req.sender_ == cur_user.ID){
                    self.requests.append(req)
                    //print(self.users[0].ID)
                    //print(self.users.count)
                }
            }
            
            self.SendTableView.reloadData()
            self.ReceiveTableView.reloadData()
            
        }, withCancel: nil)
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requests.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == SendTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sendtablecell", for: indexPath) as! SendTableViewCell
            //let temp = requests[indexPath.row]
        
            cell.receiver.text = requests[indexPath.row].receiver_
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "receivetablecell", for: indexPath) as! ReceiveTableViewCell
            //let temp = requests[indexPath.row]
            
            cell.sender.text = requests[indexPath.row].sender_
            return cell
        }
    }
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == SendTableView {
            return "보낸 요청"
        }
        else {
            return "받은 요청"
        }
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
