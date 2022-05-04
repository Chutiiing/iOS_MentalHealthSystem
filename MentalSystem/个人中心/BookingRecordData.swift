//
//  BookingRecordData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import Foundation

struct bookingRecordContent:Identifiable {
    var id:Int = 0;
    var admin:String = "";
    var abstract:String = "";
    var date:String = "";
    var room:String = "";
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class BookingRecordData:ObservableObject {
    
    @Published var bookingRecordList:[bookingRecordContent]     //收藏贴士列表
    var count = 0     //用于计数
    
    init() {
        self.bookingRecordList = [];
    }
    
    //利用bookingRecordContent进行初始化
    init(data:[bookingRecordContent]){
        self.bookingRecordList = []
        for item in data {
            self.bookingRecordList.append(bookingRecordContent(id: self.count, admin: item.admin, abstract: item.abstract, date: item.date, room: item.room))
            count += 1
        }
    }
}
