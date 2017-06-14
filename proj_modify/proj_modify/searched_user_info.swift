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
    
    var selected_user:mod_user?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        //Most_Cham_image.image = UIImage(named:  추가추가+"_0")
        //print(selected_user)
        
        username.text = selected_user?.ID
        introduce.text = selected_user?.introduce
        solo_rank.text = selected_user?.Rank_Solo
        free_rank.text = selected_user?.Rank_Free
        line_1.text = selected_user?.Line_1
        line_2.text = selected_user?.Line_2

        
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
    
    
    @IBAction func request_duo(_ sender: Any) {
        var sender:String = (cur_user.ID)!
        var receiver:String = (selected_user?.ID)!
        var status:String = "waiting"
        var dic:Dictionary = ["sender":sender, "receiver":receiver, "status":status]
        
        
        let ref = FIRDatabase.database().reference()
        ref.child("request").childByAutoId().setValue(dic)
       /* ref.child("request").child("sender").setValue(sender)
        ref.child("request").child("receiver").setValue(receiver)
        ref.child("request").child("status").setValue(status)*/
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
