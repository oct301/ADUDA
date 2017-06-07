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
var Tiers:Dictionary = ["Challenger":[0], "Master":[0], "Diamond":[1, 2, 3, 4, 5], "Platinum":[1, 2, 3, 4, 5], "Gold":[1, 2, 3, 4, 5], "Silver":[1, 2, 3, 4, 5], "Bronze":[1, 2, 3, 4, 5]]

extension String {
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
}

class My_info_ViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var solo_rank_picker: UIPickerView!
    
    @IBOutlet weak var solo_rank_num_picker: UIPickerView!

    @IBOutlet weak var free_rank_picker: UIPickerView!
    @IBOutlet weak var introduction: UITextField!
    
    @IBOutlet weak var free_rank_num_picker: UIPickerView!
    
    var user_id: String = ""
    
    
    //var ref : FIRDatabaseReference!
    let rootRef = FIRDatabase.database().reference()
    
    var dataFilePath: String?
    //var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.placeholder = "Name";
       
        
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
