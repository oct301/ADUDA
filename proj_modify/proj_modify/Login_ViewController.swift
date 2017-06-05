//
//  Login_ViewController.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 5..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase

class Login_ViewController: UIViewController {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name_: UITextField!
    @IBOutlet weak var nameSeparateView: UIView!
    @IBOutlet weak var emailSeparateView: UIView!
    @IBOutlet weak var input_container: UIView!
    @IBOutlet weak var login_register_outlet: UISegmentedControl!
    @IBOutlet weak var password_: UITextField!
    @IBOutlet weak var email_: UITextField!
    
    @IBOutlet weak var loginRegisterButton: UIButton!
    
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        weak var name: UITextField!
        super.viewDidLoad()
        input_container.translatesAutoresizingMaskIntoConstraints = false
        name_.translatesAutoresizingMaskIntoConstraints = false
        email_.translatesAutoresizingMaskIntoConstraints = false
        password_.translatesAutoresizingMaskIntoConstraints = false
        nameSeparateView.translatesAutoresizingMaskIntoConstraints = false
        emailSeparateView.translatesAutoresizingMaskIntoConstraints = false
        password_.isSecureTextEntry = true

        login_register_outlet.selectedSegmentIndex = 1
        
        input_container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        input_container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        input_container.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = input_container.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true

        
        

        name_.leftAnchor.constraint(equalTo: input_container.leftAnchor, constant: 12).isActive = true
        name_.topAnchor.constraint(equalTo: input_container.topAnchor).isActive = true
        
        name_.widthAnchor.constraint(equalTo: input_container.widthAnchor).isActive = true
        
        nameSeparateView.leftAnchor.constraint(equalTo: input_container.leftAnchor).isActive = true
        nameSeparateView.topAnchor.constraint(equalTo: name_.bottomAnchor).isActive = true
        nameSeparateView.widthAnchor.constraint(equalTo: input_container.widthAnchor).isActive = true
        nameSeparateView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        nameTextFieldHeightAnchor = name_.heightAnchor.constraint(equalTo: input_container.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        

        email_.leftAnchor.constraint(equalTo: input_container.leftAnchor, constant: 12).isActive = true
        email_.topAnchor.constraint(equalTo: name_.bottomAnchor).isActive = true
        
        email_.widthAnchor.constraint(equalTo: input_container.widthAnchor).isActive = true
        
        emailSeparateView.leftAnchor.constraint(equalTo: input_container.leftAnchor).isActive = true
        emailSeparateView.topAnchor.constraint(equalTo: email_.bottomAnchor).isActive = true
        emailSeparateView.widthAnchor.constraint(equalTo: input_container.widthAnchor).isActive = true
        emailSeparateView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextFieldHeightAnchor = email_.heightAnchor.constraint(equalTo: input_container.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        
        password_.leftAnchor.constraint(equalTo: input_container.leftAnchor, constant: 12).isActive = true
        password_.topAnchor.constraint(equalTo: email_.bottomAnchor).isActive = true
        
        password_.widthAnchor.constraint(equalTo: input_container.widthAnchor).isActive = true

        passwordTextFieldHeightAnchor = password_.heightAnchor.constraint(equalTo: input_container.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true

        

        
        logo.image = UIImage(named: "lol_logo.png")
        logo.contentMode = .scaleAspectFill
        
        
        input_container.layer.cornerRadius = 5
        input_container.layer.masksToBounds = true;
        
        name_.placeholder = "Name"
        email_.placeholder = "Email"
        password_.placeholder = "Password"
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func login_register_segmented(_ sender: Any) {
        let title = login_register_outlet.titleForSegment(at: login_register_outlet.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: UIControlState())

        inputsContainerViewHeightAnchor?.constant = login_register_outlet.selectedSegmentIndex == 0 ? 100 : 150
        
        // change height of nameTextField
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = name_.heightAnchor.constraint(equalTo: input_container.heightAnchor, multiplier: login_register_outlet.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        name_.isHidden = login_register_outlet.selectedSegmentIndex == 0
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = email_.heightAnchor.constraint(equalTo: input_container.heightAnchor, multiplier: login_register_outlet.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = password_.heightAnchor.constraint(equalTo: input_container.heightAnchor, multiplier: login_register_outlet.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
    }
    
    func alert_window(title_ : String) {
        let dialog = UIAlertController(title: title_, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let okaction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
        
        dialog.addAction(okaction)
        
        self.present(dialog, animated:true, completion:nil)
    }

    @IBAction func register(_ sender: Any) {
        
        if login_register_outlet.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    func handleLogin() {
        guard let email = email_.text, let password = password_.text else {
            print("Form is not valid")
            return
        }
        
        if email == "" || password == "" {
            alert_window(title_: "Enter you ID or PW")
            return
        }
        //var is_login: Bool = false
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if let error = error {
                self.alert_window(title_: "invalid")

                print(error)
                return
            }
            
            if error == nil {
                //self.alert_window(title_: "sign in")
                //self.dismiss(animated: true, completion: nil) // 빨리 사라짐 그리고 뒤에꺼 실행 안시키게 함.
                
                //다음 스토리보드로 넘어감( 세그 없이 넘어감)
                 let nextViewController = self.navigationController?.storyboard?.instantiateViewController(withIdentifier: "myVC") as! UITableViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
 
                //self.performSegue(withIdentifier: "logged_in_segue", sender: nil)
                /*
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "myVC") as! UITableViewController
                self.present(initViewController, animated: true, completion: nil)
            */
                
                return
            }
            
            //successfully logged in our user
            //self.dismiss(animated: true, completion: nil)
            
        })
    }
    
    func handleRegister() {
        guard let email = email_.text, let password = password_.text, let name = name_.text else {
            print("Form is not valid")
            return
        }
        
        if email_.text == "" || password_.text == "" || name_.text == "" {
           alert_window(title_: "failed")
            
            return
        }
        
        if password_.text!.characters.count <= 5 {
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

/*
        guard let email = email_.text, let password = password_.text, let name = name_.text else {
            print("Form is not valid")
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
                
                print("Saved user successfully into Firebase db")
                
            })
            
        })

        
    }
 */
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
