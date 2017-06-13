//
//  user_info_data.swift
//  proj_modify
//
//  Created by sujin on 2017. 5. 25..
//  Copyright © 2017년 sujin. All rights reserved.
//

import Foundation
import Firebase

var initLine1:L = L(line: "Top", cham1:"Garen", cham2:"Galio")
var initLine2:L = L(line: "Jungle", cham1:"Gangplank", cham2:"Graves")
var initUserInfo:User = User(name:"", Rank_Solo:"", Rank_Free:"", Line1:initLine1, Line2:initLine2)

var myinfo = MyInfo(myInfo:initUserInfo)
var userlist = UserList()

class mod_user {
    var ID:String?
    var Line_1:String?
    var Line_2:String?
    var Rank_Free:String?
    var Rank_Solo:String?
    var introduce:String?
    init(dictionary: [String: Any]) {
        self.ID = dictionary["ID"] as? String ?? ""
        self.Line_1 = dictionary["Line_1"] as? String ?? ""
        self.Line_2 = dictionary["Line_2"] as? String ?? ""
        self.Rank_Free = dictionary["Rank_Free"] as? String ?? ""
        self.Rank_Solo = dictionary["Rank_Solo"] as? String ?? ""
        self.introduce = dictionary["introduce"] as? String ?? ""
    }
    init() {
        self.ID = ""
        self.Line_1 = ""
        self.Line_2 = ""
        self.Rank_Free = ""
        self.Rank_Solo = ""
        self.introduce = ""
    }
}



class MyInfo {
    var myInfo:User
    init(myInfo:User) {
        self.myInfo = myInfo
    }
}
class UserList{
    var givingUserInfolist:[User] = []
    var takingUserInfolist:[User] = []
    init(){
        
    }
    func Addgiving(user:User) {
        givingUserInfolist += [user]
    }
    func Addtaking(user:User) {
        takingUserInfolist += [user]
    }
}

class User {
    var ID:String
    var Rank_Solo_Tier:String
    var Rank_Free_Tier:String
    var Line1:L
    var Line2:L
   // var message:String
    init(name:String, Rank_Solo:String, Rank_Free:String, Line1:L, Line2:L){
        self.ID = name
        self.Rank_Solo_Tier = Rank_Solo
        self.Rank_Free_Tier = Rank_Free
        self.Line1 = Line1
        self.Line2 = Line2
        //self.message = message
    }
}

struct L {
    var line:String
    var cham1:String
    var cham2:String
}
