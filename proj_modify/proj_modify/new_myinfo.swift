//
//  new_myinfo.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 13..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase

let Tiers:[String] = ["Challenger", "Master", "Diamond", "Platinum", "Gold", "Silver", "Bronze", "Unranked"]
let Nums1:[String] = ["0"]
let Nums2:[String] = ["1", "2", "3", "4", "5"]
var cur_user = mod_user()

class new_myinfo: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var modify_userID: UITextField!
    

    @IBOutlet weak var Free_Rank_Container: UIView!
    @IBOutlet weak var Free_image: UIImageView!
    @IBOutlet weak var Free_Tier: UILabel!
    
    @IBOutlet weak var Solo_Rank_Container: UIView!
    @IBOutlet weak var Solo_image: UIImageView!
    @IBOutlet weak var Solo_Tier: UILabel!
    
    @IBOutlet weak var position_1: UILabel!
    @IBOutlet weak var position_2: UILabel!
    
    @IBOutlet weak var introduce: UITextView!
    @IBOutlet weak var modify_introduce: UITextField!
    
    @IBOutlet weak var free_rank_picker: UIPickerView!
    @IBOutlet weak var free_rank_num_picker: UIPickerView!
    
    @IBOutlet weak var solo_rank_picker: UIPickerView!
    @IBOutlet weak var solo_rank_num_picker: UIPickerView!
    
  
    @IBOutlet weak var modify_free_tier_container: UIView!
    @IBOutlet weak var modify_solo_tier_container: UIView!
    
    @IBOutlet weak var Line_1_container: UIView!
    @IBOutlet weak var Line_2_container: UIView!
    @IBOutlet weak var Line_1_label: UILabel!
    @IBOutlet weak var Line_2_label: UILabel!
    
    @IBOutlet weak var modify_Line_1_container: UIView!
    @IBOutlet weak var modify_Line_2_container: UIView!
    
    @IBOutlet weak var Line_1: UISegmentedControl!
    @IBOutlet weak var Line_2: UISegmentedControl!
    
    
    
    @IBOutlet weak var modify_button_outlet: UIButton!
    
    @IBOutlet weak var modify_ok_button_outlet: UIButton!
    
    var is_initial:Bool = false
    //
    
    var sol_rank: String = ""
    var fre_rank: String = ""
    
    var user_id: String = ""
    
    let user = FIRAuth.auth()?.currentUser
    
    
    //var ref : FIRDatabaseReference!
    let rootRef = FIRDatabase.database().reference()
    
    func modify_mode() {
        modify_userID.isHidden = false
        userID.isHidden = true
        
        modify_free_tier_container.isHidden = false
        modify_solo_tier_container.isHidden = false
        
        Free_Rank_Container.isHidden = true
        Solo_Rank_Container.isHidden = true
        
        modify_Line_1_container.isHidden = false
        modify_Line_2_container.isHidden = false
        
        Line_1_container.isHidden = true
        Line_2_container.isHidden = true
        
        modify_introduce.isHidden = false
        introduce.isHidden = true
        
        modify_button_outlet.isHidden = true
        modify_ok_button_outlet.isHidden = false
        
        for i in 0...4 {
            if Line_1.titleForSegment(at: i) == cur_user.Line_1
            {
                Line_1.selectedSegmentIndex = i
            }
            if Line_2.titleForSegment(at: i) == cur_user.Line_2
            {
                Line_2.selectedSegmentIndex = i
            }
        }
        
        
        modify_userID.textAlignment = .center
        modify_userID.text = cur_user.ID
        
        modify_introduce.text = cur_user.introduce
        
    }
    
    func non_modify_mode() {
        modify_userID.isHidden = true
        userID.isHidden = false
        
        modify_free_tier_container.isHidden = true
        modify_solo_tier_container.isHidden = true
        
        Free_Rank_Container.isHidden = false
        Solo_Rank_Container.isHidden = false
        
        modify_Line_1_container.isHidden = true
        modify_Line_2_container.isHidden = true
        
        Line_1_container.isHidden = false
        Line_2_container.isHidden = false
        
        modify_introduce.isHidden = true
        introduce.isHidden = false
        
        modify_button_outlet.isHidden = false
        modify_ok_button_outlet.isHidden = true
        
        userID.text = cur_user.ID
        Free_Tier.text = cur_user.Rank_Free
        Solo_Tier.text = cur_user.Rank_Solo
        introduce.text = cur_user.introduce
        
        Line_1_label.text = cur_user.Line_1
        Line_2_label.text = cur_user.Line_2

        
        var tmp_free_tier:String = ""
        var tmp_solo_tier:String = ""

        for str in Tiers {
            if(cur_user.Rank_Solo?.contains(str) == true){
                tmp_solo_tier = str
                break
            }
        }
        
        for str in Tiers {
            if(cur_user.Rank_Free?.contains(str) == true){
                tmp_free_tier = str
                break
            }
        }
        
        if(tmp_solo_tier == "unranked") {
            Solo_image.image = UIImage()
        }
        else {
            Solo_image.image = UIImage(named: tmp_solo_tier)
        }
        
        if(tmp_free_tier == "unranked") {
            Free_image.image = UIImage()
        }
        else {
            Free_image.image = UIImage(named: tmp_free_tier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userID.textAlignment = .center

        
        solo_rank_picker.delegate = self
        solo_rank_num_picker.delegate = self
        free_rank_picker.delegate = self
        free_rank_num_picker.delegate = self
        
        var UserRef = rootRef.child("users").child(user!.uid).child("Info")
        UserRef.observe(.value){ ( snap: FIRDataSnapshot) in
            if  snap.exists() {
                if let dictionary = snap.value as? [String: AnyObject] {
                    let tmp = mod_user(dictionary: dictionary)
                    cur_user = tmp
                    self.non_modify_mode()
                }
            }
            else {
                self.modify_mode()
            }
        }
       
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == solo_rank_picker || pickerView == free_rank_picker {
            return Tiers.count
        }
        else if pickerView == solo_rank_num_picker {
            switch solo_rank_picker.selectedRow(inComponent: 0) {
            case 0...1:
                return 0
            case 2...6:
                return Nums2.count
            case 7:
                return 0
            default:
                return 0
            }
        }
        else {
            switch free_rank_picker.selectedRow(inComponent: 0) {
            case 0...1:
                return 0
            case 2...6:
                return Nums2.count
            case 7:
                return 0
            default:
                return 0
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == solo_rank_picker{
            solo_rank_num_picker.selectRow(0, inComponent: 0, animated: true)
            self.solo_rank_num_picker.reloadAllComponents()
            return Tiers[row]
        }
        else if pickerView == solo_rank_num_picker {
            switch solo_rank_picker.selectedRow(inComponent: 0) {
            case 0...1:
                return ""
            case 2...6:
                return Nums2[row]
            case 7:
                return ""
            default:
                return ""
            }
        }
        else if pickerView == free_rank_picker {
            free_rank_num_picker.selectRow(0, inComponent: 0, animated: true)
            self.free_rank_num_picker.reloadAllComponents()
            return Tiers[row]
        }
        else {
            switch free_rank_picker.selectedRow(inComponent: 0) {
            case 0...1:
                return ""
            case 2...6:
                return Nums2[row]
            case 7:
                return ""
            default:
                return ""
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == solo_rank_picker || pickerView == solo_rank_num_picker {
            let solo_rank = solo_rank_picker.selectedRow(inComponent: 0)
            let t:String = Tiers[solo_rank]
            var n:String = ""
            if solo_rank != 0 && solo_rank != 1 && solo_rank != 7 {
                n = Nums2[solo_rank_num_picker.selectedRow(inComponent: 0)]
            }
            sol_rank = t + "" + n
            
        }
        else {
            let free_rank = free_rank_picker.selectedRow(inComponent: 0)
            let t:String = Tiers[free_rank]
            var n:String = ""
            if free_rank != 0 && free_rank != 1 && free_rank != 7 {
                n = Nums2[free_rank_num_picker.selectedRow(inComponent: 0)]
            }
            fre_rank = t + "" + n
            
        }
    }
    
    func alert_window(title_ : String) {
        let dialog = UIAlertController(title: title_, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let okaction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
        
        dialog.addAction(okaction)
        
        self.present(dialog, animated:true, completion:nil)
    }
    
    @IBAction func modify_ok(_ sender: Any) {
        let source_name = String(userID.text!)
        
        //ID 안적었을 때
        if (modify_userID.text?.isEmpty)! {
            alert_window(title_: "enter your ID")
            return
        }
        if (modify_introduce.text?.isEmpty)! {
            alert_window(title_: "enter your introduce")
            return
        }
        
        // Firebase에 유저 정보 저장(롤 아이디, 라인, 모스트챔피언 등 //
        let user = FIRAuth.auth()?.currentUser
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(user!.uid).child("Info").child("ID").setValue(source_name)
        
        //라벨만 뜬 상태에서 다른 거 수정한다고 done을 눌리면 피커뷰는 아무 것도 설정 안된 상태라서 공백이 들어가게 되고 그럼 라벨에 공백이 떠서 랭크에 아무것도 안보이게 됨.
        ref.child("users").child(user!.uid).child("Info").child("Rank_Solo").setValue(sol_rank)
            ref.child("users").child(user!.uid).child("Info").child("Rank_Free").setValue(fre_rank)
            is_initial = false

        
        //선호라인 데아터베이스 업데이트
        ref.child("users").child(user!.uid).child("Info").child("Line_1").setValue(Line_1.titleForSegment(at: Line_1.selectedSegmentIndex)!)
        ref.child("users").child(user!.uid).child("Info").child("Line_2").setValue(Line_2.titleForSegment(at: Line_2.selectedSegmentIndex)!)
        
        ref.child("users").child(user!.uid).child("Info").child("introduce").setValue(modify_introduce.text)
        
        //ref.child("users").child(user!.uid).child("Info").child("Line_1").setValue(Line_1.debugDescription)
        //ref.child("users").child(user!.uid).child("Info").child("Line_2").setValue(fre_rank
        alert_window(title_:
        "수정 완료")
        
        non_modify_mode()
    }
    
    
    @IBAction func modify_button(_ sender: Any) {
        self.modify_mode()
        
    }
    @IBAction func show_score(_ sender: Any) {
        var link = "https://www.op.gg/summoner/userName="
        link.append(self.userID.text!)
        //https://www.op.gg/summoner/userName=
        if let url = NSURL(string: link){
            UIApplication.shared.openURL(url as URL)
        }
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
