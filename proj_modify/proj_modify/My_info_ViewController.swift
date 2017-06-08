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
let Tiers:[String] = ["Challenger", "Master", "Diamond", "Platinum", "Gold", "Silver", "Bronze", "Unranked"]
let Nums1:[String] = ["0"]
let Nums2:[String] = ["1", "2", "3", "4", "5"]

extension String {
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
}

class My_info_ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var solo_rank_text: UILabel!
    @IBOutlet weak var solo_rank_picker: UIPickerView!
    
    @IBOutlet weak var solo_rank_num_picker: UIPickerView!

    @IBOutlet weak var free_rank_text: UILabel!
    @IBOutlet weak var free_rank_picker: UIPickerView!
    
    @IBOutlet weak var free_rank_num_picker: UIPickerView!
    
    var user_id: String = ""
    
    
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
        solo_rank_text.text = "Unranked"
        free_rank_text.text = "Unranked"
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
            solo_rank_text.text = t + "" + n
        }
        else {
            let free_rank = free_rank_picker.selectedRow(inComponent: 0)
            let t:String = Tiers[free_rank]
            var n:String = ""
            if free_rank != 0 && free_rank != 1 && free_rank != 7 {
                n = Nums2[free_rank_num_picker.selectedRow(inComponent: 0)]
            }
            free_rank_text.text = t + "" + n
            
        }
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 로그인한 유저의 롤 아이디를 띄워줌.
        let user = FIRAuth.auth()?.currentUser
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
        var link = "http://fow.kr/find/"
        link.append(self.name.text!)
        //http://fow.kr/find/수진
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

        
        
        // let dialog = UIAlertController(title: "생성 완료", message: nil, preferredStyle: .alert)
        let dialog = UIAlertController(title: "생성 완료", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        //dialog.addTextField()
        // let okAction = UIAlertAction(title: "확인", style: .default)
        let okaction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
        //let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        dialog.addAction(okaction)
        //dialog.addAction(cancelAction)
        
        //self.show(dialog, sender: nil)
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
