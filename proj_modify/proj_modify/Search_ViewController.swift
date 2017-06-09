//
//  Search_ViewController.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 9..
//  Copyright © 2017년 sujin. All rights reserved.
//

import UIKit

var info_list = search_info()

class Search_ViewController: UIViewController {
    
    @IBOutlet weak var search_support: UISegmentedControl!
    @IBOutlet weak var search_mid: UISegmentedControl!
    @IBOutlet weak var search_longdeal: UISegmentedControl!
    @IBOutlet weak var search_jungle: UISegmentedControl!
    @IBOutlet weak var search_top: UISegmentedControl!
    @IBOutlet weak var search_rank: UISegmentedControl! //rank_type
    @IBOutlet weak var solo_or_free: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func search_button(_ sender: Any) {
        info_list = search_info()
        
        if solo_or_free.selectedSegmentIndex == 0 {
            info_list.is_Solo = true
        }
        
        info_list.rank_type = search_rank.selectedSegmentIndex
        
        if search_top.selectedSegmentIndex == 0 {
            info_list.is_top = true
            info_list.position.append("탑")
        }
        if search_jungle.selectedSegmentIndex == 0 {
            info_list.is_jungle = true
            info_list.position.append("정글")

        }
        if search_mid.selectedSegmentIndex == 0 {
            info_list.is_mid = true
            info_list.position.append("미드")

        }
        if search_support.selectedSegmentIndex == 0 {
            info_list.is_support = true
            info_list.position.append("서폿")

        }
        if search_longdeal.selectedSegmentIndex == 0 {
            info_list.is_longdeal = true
            info_list.position.append("원딜")

        }
        //print(info_list)
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
