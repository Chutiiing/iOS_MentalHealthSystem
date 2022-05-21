//
//  TestHistoryData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import Foundation
import Alamofire
import SwiftyJSON

//测评历史记录内容
struct testHistoryContent:Identifiable {
    var id:Int = 0;              //标识符
    var title:String = "";        //量表名称
    var result:String = "";       //测试结果
    var date:String = "";         //测评时间
    
    var deleted = false;      //判断是否被删除
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class TestHistoryData:ObservableObject {
    
    @Published var testHistoryContentList:[testHistoryContent]     //测评记录列表
    var count = 0     //用于计数
    
    //利用testHistoryContent进行初始化
    init(){
        self.testHistoryContentList = []
        //存取用户信息
        let user = UserDefaults.standard
        let stu:String = user.string(forKey: "sno") ?? ""
        
        //请求查询列表
        AF.request(RequestURL.init().url+"testHistory/find/"+stu,
                   encoding: URLEncoding.default).responseJSON{ (response) in
            
            switch response.result {
            //成功接收
            case .success(let data):
                //获取jason
                let json = JSON(data)
                
                for temp in json{
                    self.testHistoryContentList.append(testHistoryContent(id: self.count, title: temp.1["title"].stringValue, result: temp.1["result"].stringValue, date: temp.1["date"].stringValue))
                    self.count += 1;
                }
                self.sort()
                
                print(self.testHistoryContentList)
                
                break
                
            case .failure(let error):
                print("错误信息:\(error)")
                break
            }
        }
    }
    
    //删除
    func del(id: Int){
        self.testHistoryContentList[id].deleted = true
        self.sort()
        
    }
    
    //排序
    func sort(){
        self.testHistoryContentList.sort(by: {(data1,data2) in
            return data1.date > data2.date
        })
        //下标重新更新
        for i in 0..<self.testHistoryContentList.count {
            self.testHistoryContentList[i].id = i
        }
    }
}
