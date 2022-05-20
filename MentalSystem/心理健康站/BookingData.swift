//
//  BookingData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/10.
//

import Foundation
import Alamofire
import SwiftyJSON

struct bookingContent:Identifiable {
    var id:Int = 0;
    var bookingID: Int = 0;
    var admin:String = "";
    var abstract:String = "";
    var phone:String = "";
    var date:String = "";
    var room:String = "";
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class BookingData:ObservableObject {
    
    @Published var bookingList:[bookingContent]     //预约列表
    var count = 0     //用于计数
    
    //利用bookingContent进行初始化
    init(){
        
        self.bookingList = []
        
        //请求查询列表
        AF.request(RequestURL.init().url+"booking/findBooking").responseJSON{ (response) in
            
            switch response.result {
            //成功接收
            case .success(let data):
                //获取jason
                let json = JSON(data)
                
                for temp in json{
                    self.bookingList.append(bookingContent(id: self.count,bookingID:temp.1["id"].intValue,admin: temp.1["username"].stringValue, abstract: temp.1["introduction"].stringValue, phone: temp.1["phone"].stringValue, date: temp.1["time"].stringValue, room: temp.1["room"].stringValue))
                    self.count += 1
                }
                
                //按照由近到远时间顺序
                self.sort()
                
                break
                
            case .failure(let error):
                print("错误信息:\(error)")
                break
            }
        }
    }
    
    //排序
    func sort(){
        self.bookingList.sort(by: {(data1,data2) in
            return data1.date < data2.date
        })
        //下标重新更新
        for i in 0..<self.bookingList.count {
            self.bookingList[i].id = i
        }
    }
}
