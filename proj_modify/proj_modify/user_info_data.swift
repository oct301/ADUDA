//
//  user_info_data.swift
//  proj_modify
//
//  Created by sujin on 2017. 5. 25..
//  Copyright © 2017년 sujin. All rights reserved.
//

import Foundation

struct R {
    var Tier:String
    var Tier_num:Int
}

struct User{
    var Name:String
    var Rank_Solo:R?
    var Rank_Free:R?
    var Request:[User]=[]
    init(){
        Name = ""
    }
   /* init(name: String, rank: String, rank_num: Int){
        Name = name
        
    }*/
    
}
