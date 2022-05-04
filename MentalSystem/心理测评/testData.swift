//
//  TestData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/28.
//

import Foundation

//量表内容
struct testContent:Identifiable {
    var id:Int = 0              //标识
    var title:String = ""       //量表名称
    var abstract:String = ""    //量表简介
    var admin:String = ""       //发布人
    var date:String = ""        //发布时间
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class TestData:ObservableObject {
    
    @Published var testContentList:[testContent]     //量表内容列表
    var count = 0     //用于计数
    
    init() {
        self.testContentList = [];
    }
    
    //利用testContent数组进行初始化
    init(data:[testContent]){
        self.testContentList = []
        for item in data {
            self.testContentList.append(testContent(id: self.count, title: item.title, abstract: item.abstract, admin: item.admin, date: item.date))
            count += 1
        }
    }
    
}
