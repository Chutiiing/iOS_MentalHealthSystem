//
//  WriteTestView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/20.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct WriteTestView: View {
    
    //量表数据
    @ObservedObject var tableData:QuestionData = QuestionData()
    
    var title:String
    
    @State var confirmDeletion = false;
    
    //提示信息
    struct AlertData:Identifiable{
        var id = UUID()
        var message:String
    }

    @State var alertData:AlertData?
    @State var stuState:String = ""
    
    
    var body: some View {
        VStack {
            VStack{
                HStack {
                    Text(self.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action:{
                        self.confirmDeletion = true
                    }){
                        Image(systemName: "stop.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(.black)
                            .padding(.trailing)
                    }
                }
                .padding([.top,.leading])
                
                HStack {
                    Text("本测评量表共有"+String(self.tableData.questionContentList.count)+"题")
                        .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                        .font(.system(size: 15))
                    Spacer()
                }
                .padding(.leading)
                .padding(.vertical,5)
                //问题
                ScrollView(.vertical,showsIndicators: true){
                    VStack(){
                        ForEach(self.tableData.questionContentList){item in
                            questionItem(index: item.id)
                                .environmentObject(self.tableData)
                                .padding(.vertical, 5.0)
                                .padding(.horizontal)
                            
                        }
                    }
                }
            }
            .padding(.vertical)
            .navigationBarHidden(true)
            .confirmationDialog(
                "是否提前结束测评？（测评记录不会保存）",
                isPresented: $confirmDeletion,
                titleVisibility: .visible
            ) {
                Button("确定", role: .destructive) {
                    
                    DispatchQueue.main.async {
                        Task {
                            //界面跳转
                            if let window = UIApplication.shared.windows.first
                            {
                                window.rootViewController = UIHostingController(rootView: TabBarView())
                                window.makeKeyAndVisible()
                            }
                        }
                    }
                }
                
                Button("取消", role: .cancel) {}
            }
            
            //完成测评
            Button(action: {
                if NegativeCount.shareCount.countList.count != self.tableData.questionContentList.count {
                    self.alertData = AlertData(message: "还未完成测评，请耐心完成")
                }
                else{
                    //计算消极个数
                    var count = 0
                    for temp in NegativeCount.shareCount.countList{
                        if temp == 1 {
                            count += 1
                        }
                    }
                    
                    if count/self.tableData.questionContentList.count < 9/30{
                        self.stuState = "良好"
                    }
                    else{
                        self.stuState = "危险"
                    }
                    
                    let sno:String = UserDefaults.standard.string(forKey: "sno") ?? ""
                    let tableid:Int = UserDefaults.standard.integer(forKey: "id")
                    
                    //添加测评记录
                    AF.request(RequestURL.init().url+"testHistory/insert",
                               method: .post,
                               parameters: ["sno":sno,"tableid":String(tableid),"result":self.stuState],
                               encoding: JSONEncoding.default).responseJSON{ (response) in
                        switch response.result {
                        //成功接收
                        case .success(let data):
                            
                            let res = JSON(data).boolValue
                            
                            print(res)
                            
                            break
                        case .failure(let error):
                            print("错误信息:\(error)")
                            break
                        }
                        
                    }
                    
                    //更新学生状态
                    AF.request(RequestURL.init().url+"students/updateState",
                               method: .post,
                               parameters: ["sno":sno,"state":self.stuState],
                               encoding: JSONEncoding.default).responseJSON{ (response) in
                        switch response.result {
                        //成功接收
                        case .success(let data):
                            
                            let res = JSON(data).boolValue
                            
                            print(res)
                            
                            break
                        case .failure(let error):
                            print("错误信息:\(error)")
                            break
                        }
                        
                    }
                    
                    //界面跳转
                    if let window = UIApplication.shared.windows.first
                    {
                        window.rootViewController = UIHostingController(rootView: TestResultView(state: self.stuState))
                        window.makeKeyAndVisible()
                    }
                }
                
            }){
                Text("完成测评")
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.size.width/2+20, height: 50, alignment: .center)
                    .background(Color(.sRGB, red: 133/255, green: 175/255, blue: 235/255))
                    .cornerRadius(15)
            }
            .alert(item: $alertData){ alertData in
        
                Alert(title: Text("提示"), message: Text(alertData.message), dismissButton: .default(Text("确认")))
                
            }
            
        }
    }
}

struct questionItem:View{
    
    //子视图使用了副视图的类
    //@EnvironmentObject保证刷新
    @EnvironmentObject var tableData:QuestionData
    //下标
    var index:Int
    
    //是否选中:0表示都不选，1表示Yes，2表示No,选择后不可修改
    @State var selected:Int = 0;
    @State var finish = false
    
    var body: some View{
        VStack(){
            Rectangle()
                .frame(height: 10)
                .foregroundColor(Color(.sRGB, red: 133/255, green: 175/255, blue: 225/255))
            Text(self.tableData.questionContentList[index].content)
                .font(.system(size: 18))
                .padding([.horizontal,.top])
            Rectangle()
                .frame(width:350,height: 1)
                .foregroundColor(Color(.sRGB, red:220/255, green: 220/255, blue: 220/255))
            
            //选择是
            Button(action:{
                
                if !self.finish {
                    self.selected = 1
                    
                    if self.tableData.questionContentList[index].flag == 0 {
                        NegativeCount.shareCount.countList.append(1)
                    }
                    else{
                        NegativeCount.shareCount.countList.append(0)
                    }
                }
                
                self.finish = true
                
            }){
                Text("是")
                    .fontWeight(.bold)
                    .frame(width: 350, height: 40)
                    .foregroundColor(Color(.sRGB, red:80/255, green: 80/255, blue: 80/255))
                    .background(Rectangle()
                                    .foregroundColor(self.selected == 1 && self.finish ? Color(.sRGB, red: 250/255, green: 206/255, blue: 167/255) : Color(.sRGB, red: 235/255, green: 228/255, blue: 249/255))
                                    .cornerRadius(10))
            }
            .buttonStyle(StaticButtonStyle())
            
            //选择否
            Button(action:{
                
                if !self.finish {
                    
                    self.selected = 2
            
                    if self.tableData.questionContentList[index].flag == 1 {
                        NegativeCount.shareCount.countList.append(1)
                    }
                    else{
                        NegativeCount.shareCount.countList.append(0)
                    }
                }
                
                self.finish = true
                
            }){
                Text("否")
                    .fontWeight(.bold)
                    .frame(width: 350, height: 40)
                    .foregroundColor(Color(.sRGB, red:80/255, green: 80/255, blue: 80/255))
                    .background(Rectangle()
                                    .foregroundColor(self.selected == 2 && self.finish ? Color(.sRGB, red: 250/255, green: 206/255, blue: 167/255) : Color(.sRGB, red: 210/255, green: 228/255, blue: 249/255))
                                    .cornerRadius(10))
            }
            .padding(.bottom)
            .buttonStyle(StaticButtonStyle())
        }
        .cornerRadius(20)
        .background(Rectangle().foregroundColor(Color.white))
        .cornerRadius(20)
        .shadow(radius: 3)
        
    }
}

struct StaticButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

//struct WriteTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        WriteTestView()
//    }
//}
