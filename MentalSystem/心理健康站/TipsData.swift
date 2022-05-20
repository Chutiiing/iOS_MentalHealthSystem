//
//  TipsData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/20.
//

import Foundation
import Alamofire
import SwiftyJSON

//量表内容
struct tipsContent:Identifiable {
    var id:Int = 0              //标识
    var tipsId:Int = 0         //贴士标识
    var content:String = ""       //量表名称
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class TipsData:ObservableObject {
    
    @Published var tipsContentList:[tipsContent]     //贴士内容列表
    var count = 0     //用于计数
    
    //利用tipsContent数组进行初始化
    init(){
        self.tipsContentList = []
        
        //请求查询列表
        AF.request(RequestURL.init().url+"tips/findAll").responseJSON{ (response) in
            
            switch response.result {
            //成功接收
            case .success(let data):
                //获取jason
                let json = JSON(data)
                
                print("??????")
                print(json)
                
                for temp in json{
                    self.tipsContentList.append(tipsContent(id: self.count, tipsId: temp.1["id"].intValue, content: temp.1["content"].stringValue))
                    self.count += 1;
                }
                
                print(self.tipsContentList)
                
                break
                
            case .failure(let error):
                print("错误信息:\(error)")
                break
            }
        }
    }
    
}
