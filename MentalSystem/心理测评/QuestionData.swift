//
//  QuestionData.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/20.
//

import Foundation
import Alamofire
import SwiftyJSON

//量表内容
struct questionContent:Identifiable {
    var id:Int = 0              //标识
    var questionId:Int = 0         //问题标识
    var content: String = ""     //问题
    var flag:Int = 0;         //问题种类
}

//类用来实例化量表数据
//@Published为了实现视图的实时刷新
class QuestionData:ObservableObject {
    
    @Published var questionContentList:[questionContent]     //量表内容列表
    var count = 0     //用于计数
    
    init(){
        self.questionContentList = []
        
        //获取是哪张表
        let currentTable:Int = UserDefaults.standard.integer(forKey: "tableid")
        
        //请求查询列表
        AF.request(RequestURL.init().url+"test/findContent/"+String(currentTable),
                   encoding: URLEncoding.default).responseJSON{ (response) in
            
            switch response.result {
            //成功接收
            case .success(let data):
                //获取jason
                let json = JSON(data)
                
                for temp in json{
                    self.questionContentList.append(questionContent(id: self.count, questionId: temp.1["id"].intValue, content: temp.1["content"].stringValue, flag: temp.1["flag"].intValue))
                    self.count += 1;
                }
                
                break
                
            case .failure(let error):
                print("错误信息:\(error)")
                break
            }
        }
    }
}
