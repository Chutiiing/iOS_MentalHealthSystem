//
//  TestHistoryData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import Foundation

//测评历史记录内容
struct testHistoryContent:Identifiable {
    var id:Int = 0;              //标识符
    var title:String = "";        //量表名称
    var result:String = "";       //测试结果
    var date:String = "";         //测评时间
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class TestHistoryData:ObservableObject {
    
    @Published var testHistoryContentList:[testHistoryContent]     //测评记录列表
    var count = 0     //用于计数
    
    init() {
        self.testHistoryContentList = [];
    }
    
    //利用testHistoryContent进行初始化
    init(data:[testHistoryContent]){
        self.testHistoryContentList = []
        for item in data {
            self.testHistoryContentList.append(testHistoryContent(id: self.count, title: item.title, result: item.result, date: item.date))
            count += 1
        }
    }
}
