//
//  TabBarControllerViewController.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 7..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit

class TabBarControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.items?[0].title = "내 정보"
        tabBar.items?[1].title = "찾기"
        tabBar.items?[2].title = "받은 요청"
        tabBar.items?[3].title = "보낸 요청"


        // Do any additional setup after loading the view.
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
