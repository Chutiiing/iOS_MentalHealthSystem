//
//  NegativeCount.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/21.
//

import Foundation

class NegativeCount{
    
    var countList:[Int]
    
    //单例模式
    static let shareCount = NegativeCount()
    
    init(){
        self.countList = []
    }
}
