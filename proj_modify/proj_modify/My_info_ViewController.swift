//
//  My_info_ViewController.swift
//  proj_modify
//
//  Created by sujin on 2017. 5. 25..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase
//var users = User()
//var Tiers:Dictionary = ["Challenger":[0], "Master":[0], "Diamond":[1, 2, 3, 4, 5], "Platinum":[1, 2, 3, 4, 5], "Gold":[1, 2, 3, 4, 5], "Silver":[1, 2, 3, 4, 5], "Bronze":[1, 2, 3, 4, 5]]

extension String {
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
}

class My_info_ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var free_rank_label: UILabel!
    @IBOutlet weak var solo_rank_label: UILabel!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var solo_rank_picker: UIPickerView!
    
    @IBOutlet weak var solo_rank_num_picker: UIPickerView!

    @IBOutlet weak var free_rank_picker: UIPickerView!
    
    @IBOutlet weak var free_rank_num_picker: UIPickerView!
    
    // 데이터베이스 찾기를 위해 임시로
    @IBOutlet weak var Line_1: UISegmentedControl!
    
    @IBOutlet weak var Line_2: UISegmentedControl!
    
    var is_initial:Bool = false
    //
    
    var sol_rank: String = ""
    var fre_rank: String = ""
    
    var user_id: String = ""
    
    let user = FIRAuth.auth()?.currentUser
    
    
    //var ref : FIRDatabaseReference!
    let rootRef = FIRDatabase.database().reference()
    
    var dataFilePath: String?
    //var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.placeholder = "Name";
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
                }
            }
        }

        
        UserRef = rootRef.child("users").child(user!.uid).child("Info").child("Rank_Free")
        UserRef.observe(.value){ ( snap: FIRDataSnapshot) in
            if  snap.exists() {
                //self.user_id =  snap.value as! String
                //self.name.text = self.user_id
                self.free_rank_label.text = snap.value as! String
                
                self.free_rank_picker.isHidden = true
                self.free_rank_num_picker.isHidden = true
                self.solo_rank_picker.isHidden = true
                self.solo_rank_num_picker.isHidden = true
            }
            else {
                self.is_initial = true
                self.free_rank_label.isHidden = true
            }
        }
        
        UserRef = rootRef.child("users").child(user!.uid).child("Info").child("Rank_Solo")
        UserRef.observe(.value){ ( snap: FIRDataSnapshot) in
            if  snap.exists() {
                //self.user_id =  snap.value as! String
                //self.name.text = self.user_id
                self.solo_rank_label.text = snap.value as! String
            }
            else {
                self.solo_rank_label.isHidden = true
            }
        }


        
        /*
        let filemgr = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        dataFilePath = docsDir.stringByAppendingPathComponent(path: "data.archive")
        
        if filemgr.fileExists(atPath: dataFilePath!) {
            let dataArray = NSKeyedUnarchiver.unarchiveObject(withFile: dataFilePath!) as! [String]
            name.text = dataArray[0]
            //rank.text = dataArray[1]
        }
        */ // ARCHIVING //
 
        
        // Do any additional setup after loading the view.
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
                return Nums.count
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
                return Nums.count
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
                return Nums[row]
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
                return Nums[row]
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
                n = Nums[solo_rank_num_picker.selectedRow(inComponent: 0)]
            }
            sol_rank = t + "" + n
            
        }
        else {
            let free_rank = free_rank_picker.selectedRow(inComponent: 0)
            let t:String = Tiers[free_rank]
            var n:String = ""
            if free_rank != 0 && free_rank != 1 && free_rank != 7 {
                n = Nums[free_rank_num_picker.selectedRow(inComponent: 0)]
            }
            fre_rank = t + "" + n
            
        }
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 로그인한 유저의 롤 아이디를 띄워줌.
        let UserRef = rootRef.child("users").child(user!.uid).child("Info").child("ID")
        UserRef.observe(.value){ ( snap: FIRDataSnapshot) in
            if  snap.exists() {
                self.user_id =  snap.value as! String
                self.name.text = self.user_id
            }
        }
    }
    
    func alert_window(title_ : String) {
        let dialog = UIAlertController(title: title_, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let okaction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
        
        dialog.addAction(okaction)
        
        self.present(dialog, animated:true, completion:nil)
    }

    //전적보기
    @IBAction func Record_Link(_ sender: Any) {
        var link = "https://www.op.gg/summoner/userName="
        link.append(self.name.text!)
        //https://www.op.gg/summoner/userName=
        if let url = NSURL(string: link){
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func Done(_ sender: Any) {
        let source_name = String(name.text!)
        
        //ID 안적었을 때
        if (name.text?.isEmpty)! {
            alert_window(title_: "enter your ID")
            return
        }
        
        // Firebase에 유저 정보 저장(롤 아이디, 라인, 모스트챔피언 등 //
        let user = FIRAuth.auth()?.currentUser
        let ref = FIRDatabase.database().reference()
        ref.child("users").child(user!.uid).child("Info").child("ID").setValue(source_name)
        
        //라벨만 뜬 상태에서 다른 거 수정한다고 done을 눌리면 피커뷰는 아무 것도 설정 안된 상태라서 공백이 들어가게 되고 그럼 라벨에 공백이 떠서 랭크에 아무것도 안보이게 됨.
        if is_initial == true {
            ref.child("users").child(user!.uid).child("Info").child("Rank_Solo").setValue(sol_rank)
            ref.child("users").child(user!.uid).child("Info").child("Rank_Free").setValue(fre_rank)
            is_initial = false
        }
        
        //선호라인 데아터베이스 업데이트
        ref.child("users").child(user!.uid).child("Info").child("Line_1").setValue(Line_1.titleForSegment(at: Line_1.selectedSegmentIndex)!)
        ref.child("users").child(user!.uid).child("Info").child("Line_2").setValue(Line_2.titleForSegment(at: Line_2.selectedSegmentIndex)!)


        solo_rank_label.isHidden = false
        free_rank_label.isHidden = false

        
        
        let dialog = UIAlertController(title: "생성 완료", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let okaction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
        dialog.addAction(okaction)
        
        self.present(dialog, animated:true, completion:nil)
        
        /* ARCHIVING
        var contactArray = [name.text]
        NSKeyedArchiver.archiveRootObject(contactArray, toFile: dataFilePath!)
        */
        
         // firebase database //
        /*
        let ref = FIRDatabase.database().reference()
        let usersReference = ref.child("users").child()
        let values = ["name": name, "email": email]
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err {
                print(err)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        })
        */

        
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
