//
//  new_login.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 10..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase

class new_login: UIViewController {

    @IBOutlet weak var name_container: UIView!
    @IBOutlet weak var name_text: UITextField!
    
    @IBOutlet weak var email_text: UITextField!
    
    @IBOutlet weak var password_text: UITextField!
    @IBOutlet weak var login_register_select: UISegmentedControl!
    @IBOutlet weak var login_register_button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "ADUDA"
        
        name_container.isHidden = true // 이거 만으로도 텍스트까지 숨김
        
        password_text.isSecureTextEntry = true
        
        login_register_select.selectedSegmentIndex = 0
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "zedd.jpeg")!)

        //view.addBackground(imageName: "zedd.jpeg", contextMode: .scaleAspectFit)
        // Do any additional setup after loading the view.
    }
    
    func alert_window(title_ : String) {
        let dialog = UIAlertController(title: title_, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let okaction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
        
        dialog.addAction(okaction)
        
        self.present(dialog, animated:true, completion:nil)
    }
    
    
    @IBAction func log_regi_button(_ sender: Any) {
        if login_register_select.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        guard let email = email_text.text, let password = password_text.text else {
            print("Form is not valid")
            return
        }
        
        if email == "" || password == "" {
            alert_window(title_: "Enter you ID or PW")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if let error = error {
                self.alert_window(title_: "invalid")
                
                print(error)
                return
            }
            
            if error == nil {
                 self.performSegue(withIdentifier: "logged_in_segue", sender: nil)
                return
            }
            
        })
    }
    
    func handleRegister() {
        guard let email = email_text.text, let password = password_text.text, let name = name_text.text else {
            print("Form is not valid")
            return
        }
        
        if email_text.text == "" || password_text.text == "" || name_text.text == "" {
            alert_window(title_: "fill all forms")
            
            return
        }
        
        if password_text.text!.characters.count <= 5 {
            alert_window(title_: "at least 6 length of password")
            
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            //successfully authenticated user
            let ref = FIRDatabase.database().reference()
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if let err = err {
                    print(err)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            })
            
        })
        alert_window(title_: "Success!")
    }


    @IBAction func log_regi_select(_ sender: Any) {
        let title = login_register_select.titleForSegment(at: login_register_select.selectedSegmentIndex)
        login_register_button.setTitle(title, for: UIControlState())
        
        if(login_register_select.selectedSegmentIndex == 1) {
            name_container.isHidden = false
        }
        else {
            name_container.isHidden = true
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
