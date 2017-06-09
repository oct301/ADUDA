//
//  search_data.swift
//  proj_modify
//
//  Created by sujin on 2017. 6. 9..
//  Copyright © 2017년 sujin. All rights reserved.
//

import Foundation

class search_info {
    var is_Solo:Bool // solo, free
    var rank_type:Int // 0~3
    var is_top:Bool
    var is_jungle:Bool
    var is_mid:Bool
    var is_longdeal:Bool
    var is_support:Bool
    var position:[String]
    init() {
        is_Solo = false
        rank_type = 0
        is_top = false
        is_jungle = false
        is_mid = false
        is_longdeal = false
        is_support = false
        position = []
    }
    init(solo: Bool, rank: Int, T:Bool, J:Bool, M:Bool, L:Bool, S:Bool){
        is_Solo = solo
        rank_type = rank
        is_top = T
        is_jungle = J
        is_mid = M
        is_longdeal = L
        is_support = S
        position = []
    }
}
