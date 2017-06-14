//
//  user_info_data.swift
//  proj_modify
//
//  Created by sujin on 2017. 5. 25..
//  Copyright © 2017년 sujin. All rights reserved.
//

import Foundation
import Firebase

var userlist = UserList()

class mod_user {
    var ID:String?
    var Line_1:String?
    var Line_2:String?
    var Rank_Free:String?
    var Rank_Solo:String?
    var introduce:String?
    var Champion1:String?
    var Champion2:String?
    var Champion3:String?
    var Champion4:String?
    var like:Int = 0
    var dislike:Int = 0
    init(dictionary: [String: Any]) {
        self.ID = dictionary["ID"] as? String ?? ""
        self.Line_1 = dictionary["Line_1"] as? String ?? ""
        self.Line_2 = dictionary["Line_2"] as? String ?? ""
        self.Rank_Free = dictionary["Rank_Free"] as? String ?? ""
        self.Rank_Solo = dictionary["Rank_Solo"] as? String ?? ""
        self.introduce = dictionary["introduce"] as? String ?? ""
        self.Champion1 = dictionary["Champion1"] as? String ?? ""
        self.Champion2 = dictionary["Champion2"] as? String ?? ""
        self.Champion3 = dictionary["Champion3"] as? String ?? ""
        self.Champion4 = dictionary["Champion4"] as? String ?? ""


    }
    init() {
        self.ID = ""
        self.Line_1 = ""
        self.Line_2 = ""
        self.Rank_Free = ""
        self.Rank_Solo = ""
        self.introduce = ""
        self.Champion1 = "Garen"
        self.Champion2 = "Galio"
        self.Champion3 = "Gangplank"
        self.Champion4 = "Gragas"
        self.like = 0
        self.dislike = 0
    }
}



class UserList{
    var givingUserInfolist:[mod_user] = []
    var takingUserInfolist:[mod_user] = []
    init(){
        
    }
    func Addgiving(user:mod_user) {
        givingUserInfolist += [user]
    }
    func Addtaking(user:mod_user) {
        takingUserInfolist += [user]
    }
}
