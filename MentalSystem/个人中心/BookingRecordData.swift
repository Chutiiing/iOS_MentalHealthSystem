//
//  BookingRecordData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import Foundation
import Alamofire
import SwiftyJSON

struct bookingRecordContent:Identifiable {
    var id:Int = 0;
    var bookingID: Int = 0;
    var admin:String = "";
    var abstract:String = "";
    var phone:String = "";
    var date:String = "";
    var room:String = "";
    
    var deleted = false;      //判断是否被删除
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class BookingRecordData:ObservableObject {
    
    @Published var bookingRecordList:[bookingRecordContent]     //收藏贴士列表
    var count = 0     //用于计数
    
    init(){
        self.bookingRecordList = []
        
        let user = UserDefaults.standard
        //存取用户信息
        let stu:String = user.string(forKey: "sno") ?? ""
        
        //请求查询列表
        AF.request(RequestURL.init().url+"booking/findStuBooking/" + stu,
                   encoding: URLEncoding.default).responseJSON{ (response) in
            
            switch response.result {
            //成功接收
            case .success(let data):
                //获取jason
                let json = JSON(data)
                
                for temp in json{
                    self.bookingRecordList.append(bookingRecordContent(id: self.count,bookingID:temp.1["id"].intValue,admin: temp.1["username"].stringValue, abstract: temp.1["introduction"].stringValue, phone: temp.1["phone"].stringValue, date: temp.1["time"].stringValue, room: temp.1["room"].stringValue))
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
    
    //删除
    func del(id: Int){
        self.bookingRecordList[id].deleted = true
        self.sort()
        
    }
    
    //排序
    func sort(){
        self.bookingRecordList.sort(by: {(data1,data2) in
            return data1.date > data2.date
        })
        //下标重新更新
        for i in 0..<self.bookingRecordList.count {
            self.bookingRecordList[i].id = i
        }
    }
}
