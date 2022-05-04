//
//  TipsCollectedData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import Foundation

struct tipsCollectedContent:Identifiable {
    var id:Int = 0;
    var tipsContent:String = "";      //贴士内容
    var date:String = "";             //收藏时间
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class TipsCollectedData:ObservableObject {
    
    @Published var tipsCollectedList:[tipsCollectedContent]     //收藏贴士列表
    var count = 0     //用于计数
    
    init() {
        self.tipsCollectedList = [];
    }
    
    //利用tipsCollectedContent进行初始化
    init(data:[tipsCollectedContent]){
        self.tipsCollectedList = []
        for item in data {
            self.tipsCollectedList.append(tipsCollectedContent(id: self.count, tipsContent: item.tipsContent, date: item.date))
            count += 1
        }
    }
}

