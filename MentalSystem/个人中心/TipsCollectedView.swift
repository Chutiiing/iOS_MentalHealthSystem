//
//  TipsCollectedView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct TipsCollectedView: View {
    
    @ObservedObject var tipsCollectedData:TipsCollectedData = TipsCollectedData()
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Text("贴士收藏")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,40)
                    .padding(.leading,30)
                Spacer()
                Image("花1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .padding(.leading,20)
            }
            ScrollView(.vertical,showsIndicators: true){
                VStack(){
                    ForEach(self.tipsCollectedData.tipsCollectedList){item in
                        //没有被删掉
                        if !item.deleted{
                            tipsCollectedItem(index: item.id)
                                .environmentObject(self.tipsCollectedData)
                                .padding(.vertical, 5.0)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
        
    }
}

struct tipsCollectedItem:View {
    
    //表单数据
    @EnvironmentObject var tableData:TipsCollectedData
    //下标
    var index:Int
    
    var body: some View{
        VStack(spacing: 10) {
            HStack{
                Circle()
                    .frame(width: 15, height: 20, alignment: .leading)
                    .padding(.leading,10)
                    .foregroundColor(Color.white)
                Spacer()
                Button(action: {
                    
                    let user = UserDefaults.standard
                    //存取用户信息
                    let stu:String = user.string(forKey: "sno") ?? ""
                    
                    AF.request(RequestURL.init().url+"tips/delStar",
                               method: .delete,
                               parameters: ["sno":stu,"tipsId":String(self.tableData.tipsCollectedList[index].tipsId)],
                               encoding: JSONEncoding.default).responseJSON{ (response) in
                        switch response.result {
                        //成功接收
                        case .success(let data):
                            
                            let res = JSON(data).boolValue
                            //删除后界面刷新,移除数据
                            if res {
                                self.tableData.del(id: index);
                            }
                            
                            break
                        case .failure(let error):
                            print("错误信息:\(error)")
                            break
                        }
                        
                    }
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.red)
                }
                .padding(.trailing,12)
            }
            .padding(.top,6)
            
            Text(self.tableData.tipsCollectedList[index].tipsContent)
                .padding(.horizontal)
            
            HStack(){
                Image(systemName: "clock")
                Text(self.tableData.tipsCollectedList[index].date)
                Spacer()
            }
            .padding(.horizontal)
            .font(.system(size: 14))
            .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
            .padding(.bottom)
        }
        .background(Rectangle()
                        .foregroundColor(Color(.sRGB, red: 210/255, green: 228/255, blue: 249/255)))
        .cornerRadius(20)
        .shadow(radius: 5,x:3,y:3)

    }
}

struct TipsCollectedView_Previews: PreviewProvider {
    static var previews: some View {
        TipsCollectedView()
    }
}
