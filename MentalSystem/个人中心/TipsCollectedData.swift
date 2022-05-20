//
//  TipsCollectedData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import Foundation
import Alamofire
import SwiftyJSON

struct tipsCollectedContent:Identifiable {
    var id:Int = 0;
    var tipsId:Int = 0;
    var tipsContent:String = "";      //贴士内容
    var date:String = "";             //收藏时间
    
    var deleted = false;      //判断是否被删除
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class TipsCollectedData:ObservableObject {
    
    @Published var tipsCollectedList:[tipsCollectedContent]     //收藏贴士列表
    var count = 0     //用于计数
    
    //利用tipsCollectedContent进行初始化
    init(){
        
        self.tipsCollectedList = []
        
        //存取用户信息
        let user = UserDefaults.standard
        let stu:String = user.string(forKey: "sno") ?? ""
        
        //请求查询列表
        AF.request(RequestURL.init().url+"tips/starList/"+stu,
                   encoding: URLEncoding.default).responseJSON{ (response) in
            
            switch response.result {
            //成功接收
            case .success(let data):
                //获取jason
                let json = JSON(data)
                
                for temp in json{
                    self.tipsCollectedList.append(tipsCollectedContent(id: self.count,tipsId: temp.1["tipsId"].intValue, tipsContent: temp.1["content"].stringValue, date: temp.1["time"].stringValue))
                    self.count += 1;
                }
                self.sort()
                
                print(self.tipsCollectedList)
                
                break
                
            case .failure(let error):
                print("错误信息:\(error)")
                break
            }
        }
    }
    
    //删除
    func del(id: Int){
        self.tipsCollectedList[id].deleted = true
        self.sort()
        
    }
    
    //排序
    func sort(){
        self.tipsCollectedList.sort(by: {(data1,data2) in
            return data1.date > data2.date
        })
        //下标重新更新
        for i in 0..<self.tipsCollectedList.count {
            self.tipsCollectedList[i].id = i
        }
    }
}

