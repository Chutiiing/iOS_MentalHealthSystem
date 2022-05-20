//
//  TestData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/28.
//

import Foundation
import Alamofire
import SwiftyJSON

//量表内容
struct testContent:Identifiable {
    var id:Int = 0              //标识
    var tableid:Int = 0         //量表标识
    var title:String = ""       //量表名称
    var introduction:String = ""    //量表简介
    var admin:String = ""       //发布人
    var time:String = ""        //发布时间
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class TestData:ObservableObject {
    
    @Published var testContentList:[testContent]     //量表内容列表
    var count = 0     //用于计数
    
    //利用testContent数组进行初始化
    init(){
        self.testContentList = []
        
        //请求查询列表
        AF.request(RequestURL.init().url+"test/findAll").responseJSON{ (response) in
            
            switch response.result {
            //成功接收
            case .success(let data):
                //获取jason
                let json = JSON(data)
                
                for temp in json{
                    self.testContentList.append(testContent(id:self.count,tableid:temp.1["tableid"].intValue,title: temp.1["title"].stringValue, introduction: temp.1["introduction"].stringValue, admin:temp.1["admin"].stringValue, time: temp.1["time"].stringValue))
                    self.count += 1;
                }
                
                //按时间顺序排序
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
        self.testContentList.sort(by: {(data1,data2) in
            return data1.time > data2.time
        })
        //下标重新更新
        for i in 0..<self.testContentList.count {
            self.testContentList[i].id = i
        }
    }
}
