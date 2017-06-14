//
//  searched_user_info.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 13..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase

class searched_user_info: UIViewController {

    @IBOutlet weak var Most_Cham_image: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var request_duo_outlet: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var introduce: UITextView!
    @IBOutlet weak var solo_rank_image: UIImageView!
    @IBOutlet weak var free_rank_image: UIImageView!
    @IBOutlet weak var solo_rank: UILabel!
    @IBOutlet weak var free_rank: UILabel!
    
    @IBOutlet weak var line_1: UILabel!
    
    @IBOutlet weak var line_2: UILabel!
    @IBOutlet weak var accept_request_outlet: UIButton!
    @IBOutlet weak var cancel_request_outlet: UIButton!
    @IBOutlet weak var reject_request_outlet: UIButton!
    
    
    
    @IBOutlet weak var Cham1: UIImageView!
    @IBOutlet weak var Cham2: UIImageView!
    @IBOutlet weak var Cham3: UIImageView!
    @IBOutlet weak var Cham4: UIImageView!
    
    var req_list = [request]()
    var friend:String?
    
    var selected_user:mod_user?
    var display_type:Int?
    //display_type 1: 찾기에서 보여주는 유저 (듀오 요청 버튼)
    //             2: 보낸 요청에서 보여주는 유저 (듀오 요청 취소 버튼)
    //             3: 받은 요청에서 보여주는 유저 (듀오 수락, 거절 버튼)
    //             4: 친구목록에서 친구 이름만 가져옴.
    
    func friend_search(completion: @escaping (mod_user) -> ()) {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if (snapshot.value as? [String: AnyObject]) != nil {
                
                //개인 auth키
                let ky = snapshot.key
                
                FIRDatabase.database().reference().child("users").child(ky).observe(.childAdded, with: { (snapshot) in
                    
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let tmp = mod_user(dictionary: dictionary)
                        
                        print(self.friend)
                        print(tmp.ID)
                        if tmp.ID == self.friend {
                          
                            completion(tmp)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        
        var myGroup = DispatchGroup()
        
        myGroup.enter()

        
        if(display_type == 1) {
            request_duo_outlet.isHidden = false
            accept_request_outlet.isHidden = true
            reject_request_outlet.isHidden = true
            cancel_request_outlet.isHidden = true
        }
        else if(display_type == 2) {
            request_duo_outlet.isHidden = true
            accept_request_outlet.isHidden = true
            reject_request_outlet.isHidden = true
            cancel_request_outlet.isHidden = false
        }
        else if(display_type == 3) {
            request_duo_outlet.isHidden = true
            accept_request_outlet.isHidden = false
            reject_request_outlet.isHidden = false
            cancel_request_outlet.isHidden = true
        }
        else if display_type == 4 {
            request_duo_outlet.isHidden = true
            accept_request_outlet.isHidden = true
            reject_request_outlet.isHidden = true
            cancel_request_outlet.isHidden = true
            print(friend)
            print("Dd")
            
            friend_search(completion: { result in
                print("result: ", result)
                self.selected_user = result
            })
            /*FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
                if (snapshot.value as? [String: AnyObject]) != nil {
                    
                    //개인 auth키
                    let ky = snapshot.key
                    
                    FIRDatabase.database().reference().child("users").child(ky).observe(.childAdded, with: { (snapshot) in
                        
                        
                        if let dictionary = snapshot.value as? [String: AnyObject] {
                            let tmp = mod_user(dictionary: dictionary)
                            
                            print(self.friend)
                            print(tmp.ID)
                            if tmp.ID == self.friend {
                                print("LOOP: ", self.friend)
                                print("TMP: " ,tmp.ID)
                                self.selected_user = tmp
                                myGroup.leave()
                                return
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
                
            } , withCancel: nil)*/
        }
        
        
        
        print(selected_user)
        Most_Cham_image.image = UIImage(named:  (selected_user?.Champion1)!+"_0")
        Cham1.image = UIImage(named: (selected_user?.Champion1)!)
        Cham2.image = UIImage(named: (selected_user?.Champion2)!)
        Cham3.image = UIImage(named: (selected_user?.Champion3)!)
        Cham4.image = UIImage(named: (selected_user?.Champion4)!)
        //print(selected_user)
        
        username.text = selected_user?.ID
        introduce.text = selected_user?.introduce
        solo_rank.text = selected_user?.Rank_Solo
        free_rank.text = selected_user?.Rank_Free
        line_1.text = selected_user?.Line_1
        line_2.text = selected_user?.Line_2
        
        let ref = FIRDatabase.database().reference()
        
        let user = FIRAuth.auth()?.currentUser
        var sender:String = ""

        let UserRef = ref.child("users").child(user!.uid).child("Info")
        UserRef.observe(.value){ ( snap: FIRDataSnapshot) in
            if let dictionary = snap.value as? [String: AnyObject] {
                cur_user = mod_user(dictionary: dictionary)
                sender = cur_user.ID!
                FIRDatabase.database().reference().child("request").observe(.childAdded, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let req = request(dictionary: dictionary)
                        //print(snapshot)
                        
                        if(req.sender_ == sender){
                            self.req_list.append(req)
                        }
                    }
                }, withCancel: nil)
            }
        }

        
        var tmp_free_tier:String = ""
        var tmp_solo_tier:String = ""
        
        for str in Tiers {
            if(selected_user?.Rank_Solo?.contains(str) == true){
                tmp_solo_tier = str
                break
            }
        }
        
        for str in Tiers {
            if(selected_user?.Rank_Free?.contains(str) == true){
                tmp_free_tier = str
                break
            }
        }
        
        if(tmp_solo_tier == "unranked") {
            solo_rank_image.image = UIImage()
        }
        else {
            solo_rank_image.image = UIImage(named: tmp_solo_tier)
        }
        
        if(tmp_free_tier == "unranked") {
            free_rank_image.image = UIImage()
        }
        else {
            free_rank_image.image = UIImage(named: tmp_free_tier)
        }

        // Do any additional setup after loading the view.
    }
    
    func alert_window(title_ : String) {
        let dialog = UIAlertController(title: title_, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let okaction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
        
        dialog.addAction(okaction)
        
        self.present(dialog, animated:true, completion:nil)
    }
    
    @IBAction func request_duo(_ sender: Any) {
        let sender:String = cur_user.ID!
        let receiver:String = (selected_user?.ID!)!
        let status:String = "waiting"
        let dic:Dictionary = ["sender":sender, "receiver":receiver, "status":status]
        let reqst = request(dictionary: dic)
        
        let ref = FIRDatabase.database().reference()
        var chk:Bool = true
        // print(req_list.count)
        for req in req_list {
            if(req.receiver_ == receiver && status == "waiting") {
                alert_window(title_: "이미 듀오 요청 대기중입니다.")
                chk = false
                break
            }
            if(req.receiver_ == receiver && status == "accept") {
                alert_window(title_: "이미 당신과 듀오입니다.")
                chk = false
                break
            }
        }
        if chk == true {
            alert_window(title_: "듀오를 요청했습니다!")
            req_list.insert(reqst, at: 0)
            ref.child("request").childByAutoId().setValue(dic)
            //request_duo_outlet.titleLabel?.text = "듀오 요청중"
        }
    }
    
    @IBAction func accept_request(_ sender: Any) {
        //var dic:Dictionary = ["sender":self.selected_user?.ID, "receiver":cur_user.ID, "status":"accept"]
        FIRDatabase.database().reference().child("request").observe(.childAdded,with: { snapShot in
            let ky = snapShot.key
            
            if let dictionary = snapShot.value as? [String: AnyObject] {
                //print("sender :" + sender)
                
                let req = request(dictionary: dictionary)
                print(snapShot)
                //print(req.sender_)
                //print(sender)
                
                if req.sender_ == self.selected_user?.ID && req.receiver_ == cur_user.ID && req.status_ == "waiting" {
                    self.alert_window(title_: "듀오가 맺어졌습니다!")
                    FIRDatabase.database().reference().child("request").child(ky).child("status").setValue("accept")
                    self.accept_request_outlet.isHidden = true
                    self.reject_request_outlet.isHidden = true
                    
                    
                }
                
            }
        })
    }
    @IBAction func reject_request(_ sender: Any) {
        FIRDatabase.database().reference().child("request").observe(.childAdded,with: { snapShot in
            let ky = snapShot.key
            
            if let dictionary = snapShot.value as? [String: AnyObject] {
                //print("sender :" + sender)
                
                let req = request(dictionary: dictionary)
                print(snapShot)
                //print(req.sender_)
                //print(sender)
                
                if req.sender_ == self.selected_user?.ID && req.receiver_ == cur_user.ID && req.status_ == "waiting" {
                    self.alert_window(title_: "듀오를 거절했습니다!")
                    FIRDatabase.database().reference().child("request").child(ky).child("status").setValue("reject")
                    FIRDatabase.database().reference().child("request").child(ky).removeValue()
                    //self.performSegue(withIdentifier: "reject_segue", sender: nil)
                   /* DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "reject_sync",sender: self)
                    }*/

                }
                
            }
        })
    }
    @IBAction func cancel_request(_ sender: Any) {
        FIRDatabase.database().reference().child("request").observe(.childAdded,with: { snapShot in
            let ky = snapShot.key
            
            if let dictionary = snapShot.value as? [String: AnyObject] {
                //print("sender :" + sender)
                
                let req = request(dictionary: dictionary)
                print(snapShot)
                //print(req.sender_)
                //print(sender)
                
                if req.sender_ == cur_user.ID && req.receiver_ == self.selected_user?.ID && req.status_ == "waiting" {
                    self.alert_window(title_: "듀오요청을 취소했습니다!")
                    FIRDatabase.database().reference().child("request").child(ky).removeValue()
                    //self.performSegue(withIdentifier: "reject_segue", sender: nil)
                    /* DispatchQueue.main.async {
                     self.performSegue(withIdentifier: "reject_sync",sender: self)
                     }*/
                    
                }
                
            }
        })

    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
