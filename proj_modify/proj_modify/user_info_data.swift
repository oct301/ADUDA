//
//  user_info_data.swift
//  proj_modify
//
//  Created by sujin on 2017. 5. 25..
//  Copyright © 2017년 sujin. All rights reserved.
//

import Foundation
var initRank:R = R(Tier: "platinum",Tier_num: 5)
var initLine1:L = L(line: "Top", cham1:"Garen", cham2:"Galio")
var initLine2:L = L(line: "Jungle", cham1:"Gangplank", cham2:"Graves")
var initUserInfo:User = User(name:"skehrks", Rank_Solo:initRank, Rank_Free:initRank, Line1:initLine1, Line2:initLine2, message:"")

var myinfo = MyInfo(myInfo:initUserInfo)
var userlist = UserList()

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
    var name:String
    var Rank_Solo:R
    var Rank_Free:R
    var Line1:L
    var Line2:L
    var message:String
    init(name:String, Rank_Solo:R, Rank_Free:R, Line1:L, Line2:L, message:String){
        self.name = name
        self.Rank_Solo = Rank_Solo
        self.Rank_Free = Rank_Free
        self.Line1 = Line1
        self.Line2 = Line2
        self.message = message
    }
}

struct L {
    var line:String
    var cham1:String
    var cham2:String
}

struct R {
    var Tier:String
    var Tier_num:Int
}
