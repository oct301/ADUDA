//
//  TabBarControllerViewController.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 7..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit
import Firebase

class TabBarControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.items?[0].title = "듀오 멤버"
        tabBar.items?[1].title = "내 정보"
        tabBar.items?[2].title = "요청 확인 & 유저 찾기"
        self.navigationController!.navigationBar.topItem!.title = "Logout"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleLogout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        present(new_login(), animated: true, completion: nil)
        
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
