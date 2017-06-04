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
    
    @IBOutlet weak var free_rank_num_picker: UIPickerView!
    
    
    
    
    //var ref : FIRDatabaseReference!
    let rootRef = FIRDatabase.database().reference()

    var dataFilePath: String?
    //var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filemgr = FileManager.default
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let docsDir = dirPaths[0] as String
        dataFilePath = docsDir.stringByAppendingPathComponent(path: "data.archive")
        
        if filemgr.fileExists(atPath: dataFilePath!) {
            let dataArray = NSKeyedUnarchiver.unarchiveObject(withFile: dataFilePath!) as! [String]
            name.text = dataArray[0]
            //rank.text = dataArray[1]
        }
        //Tier_Select.dataSource =
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let conditionRef = rootRef.child("condition")
        rootRef.child("condition").observe(.value){ ( snap: FIRDataSnapshot) in
           // self.name.text = snap.value.debugDescription
        }
        //rootRef.child("name").setValue(self.name.text)
    }
    
    @IBAction func Done(_ sender: Any) {
        let source_name = String(name.text!)
        //let source_rank = String(rank.text!)
 //       users.Name = source_name!
        //users.Rank = source_rank!
        
        
        //itemRef.setValue(users.Name) //데이터베이스에 설정이 안 됨.
        //itemRef.setValue(users.Rank)
        
        
        
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
        
        var contactArray = [name.text]
        NSKeyedArchiver.archiveRootObject(contactArray, toFile: dataFilePath!)
        rootRef.child("name").setValue(self.name.text)
        

        
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
