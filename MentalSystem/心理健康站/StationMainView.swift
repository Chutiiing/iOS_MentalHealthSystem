//
//  StationMainView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/29.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct StationMainView: View {
    
    @State var isPushed = false
    
    //贴士数据
    @ObservedObject var tableData:TipsData = TipsData()
    
    var body: some View {
        VStack {
            ZStack {
                VStack(spacing:0) {
                    
                    //小贴士
                    ScrollView(.horizontal,showsIndicators: false){
                        HStack(){
                            ForEach(self.tableData.tipsContentList){item in
                                tipsView(index: item.id)
                                    .environmentObject(self.tableData)
                                    .padding(.vertical, 5.0)
                                    .padding(.horizontal,5)
                            }
                        }
                    }
                    .padding(.top,30)
                    
                    //线下咨询室按钮
                    VStack(spacing:10){
                        HStack{
                            Text("美好总会出现在下一个转弯")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        //咨询室预约
                        NavigationLink(destination:
                                        BookingView(isPushed: self.$isPushed),
                                       isActive: self.$isPushed)  {
                            bookingButton()
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.top,30)
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Spacer()
                        Image("花1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                    }
                    Spacer()
                }
            }
            Image("组合花")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.size.width)
        }
    }
}

struct tipsView:View{
    
    @State var isStar = false    //判断是否收藏,默认未收藏
    
    //子视图使用了副视图的类
    //@EnvironmentObject保证刷新
    @EnvironmentObject var tableData:TipsData
    //下标
    var index:Int
    
    var body: some View{
        VStack(spacing:20) {
            Rectangle()
                .frame(height: 10)
                .foregroundColor(Color(.sRGB, red: 133/255, green: 175/255, blue: 225/255))
            HStack{
                Spacer()
                Text("Tips")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            ScrollView(.vertical,showsIndicators: false){
                Text(self.tableData.tipsContentList[index].content)
                    .foregroundColor(Color(.sRGB, red:50/255, green: 50/255, blue: 50/255))
            }
            .frame(height: 135)
            .padding(.horizontal)
            //收藏按钮
            Button(action: {
                let user = UserDefaults.standard
                //存取用户信息
                let stu:String = user.string(forKey: "sno") ?? ""
                //目前为收藏，点击按钮则取消收藏
                if self.isStar {
                    AF.request(RequestURL.init().url+"tips/delStar",
                               method: .delete,
                               parameters: ["sno":stu,"tipsId":String(self.tableData.tipsContentList[index].tipsId)],
                               encoding: JSONEncoding.default).responseJSON{ (response) in
                        switch response.result {
                        //成功接收
                        case .success(let data):
                            
                            let res = JSON(data).boolValue
                            
                            if res {
                                self.isStar = false
                            }
                            
                            break
                        case .failure(let error):
                            print("错误信息:\(error)")
                            break
                        }
                        
                    }
                }
                //目前未收藏，则为收藏
                else{
                    AF.request(RequestURL.init().url+"tips/star",
                               method: .post,
                               parameters: ["sno":stu,"tipsId":String(self.tableData.tipsContentList[index].tipsId)],
                               encoding: JSONEncoding.default).responseJSON{ (response) in
                        switch response.result {
                        //成功接收
                        case .success(let data):
                            
                            let res = JSON(data).boolValue
                            
                            if res {
                                self.isStar = true
                            }
                            
                            break
                        case .failure(let error):
                            print("错误信息:\(error)")
                            break
                        }
                        
                    }
                }
                
                //self.isStar = !self.isStar
            }){
                Image(systemName: self.isStar ? "star.fill" : "star")
                    .font(.title2)
                    .foregroundColor(self.isStar ? .yellow : .black)
            }
            .padding(.bottom)
        }
        .frame(width: UIScreen.main.bounds.size.width - 40)
        .background(Rectangle()
                        .foregroundColor(.white))
        .cornerRadius(10)
        .shadow(radius: 2)
        .onAppear{
            
            let user = UserDefaults.standard
            //存取用户信息
            let stu:String = user.string(forKey: "sno") ?? ""

            //请求查询列表
            AF.request(RequestURL.init().url+"tips/isStar/"+stu+"/"+String(self.tableData.tipsContentList[index].tipsId),
                       encoding: URLEncoding.default).responseJSON{ (response) in
                
                switch response.result {
                //成功接收
                case .success(let data):
                    
                    //获取jason
                    let res = JSON(data).boolValue
                    
                    //表示收藏过
                    if res {
                        self.isStar = true;
                    }
                    else {
                        self.isStar = false
                    }
                    
                    break
                //错误
                case .failure(let error):
                    print("错误信息:\(error)")
                    break
                }
            }
        }
    }
}

struct bookingButton:View{
    var body: some View{
        HStack {
            Image("岛")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .padding(.leading)
            Text("线下咨询室预约")
                .font(.system(size: 18))
            Spacer()
            Image(systemName: "chevron.right")
                .padding(.trailing)
        }
        .background(Rectangle()
                        .foregroundColor(.white))
        .cornerRadius(10)
        .shadow(radius:2)
    }
}

struct StationMainView_Previews: PreviewProvider {
    static var previews: some View {
        StationMainView()
    }
}
