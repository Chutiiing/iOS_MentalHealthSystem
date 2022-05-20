//
//  WriteTestView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/20.
//

import SwiftUI

struct WriteTestView: View {
    
    //量表数据
    @ObservedObject var tableData:QuestionData = QuestionData()
    
    var title:String
    
    @State var confirmDeletion = false;
    
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
            
            NavigationLink(destination:{
                Text("测评结果")
            }){
                Text("完成测评")
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.size.width/2+20, height: 50, alignment: .center)
                    .background(Color(.sRGB, red: 133/255, green: 175/255, blue: 235/255))
                    .cornerRadius(15)
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
            Button(action:{
                
            }){
                Text("是")
                    .fontWeight(.bold)
                    .frame(width: 350, height: 40)
                    .foregroundColor(Color(.sRGB, red:80/255, green: 80/255, blue: 80/255))
                    .background(Rectangle()
                                    .foregroundColor(Color(.sRGB, red: 235/255, green: 228/255, blue: 249/255))
                                    .cornerRadius(10))
            }
            Button(action:{
                
            }){
                Text("否")
                    .fontWeight(.bold)
                    .frame(width: 350, height: 40)
                    .foregroundColor(Color(.sRGB, red:80/255, green: 80/255, blue: 80/255))
                    .background(Rectangle()
                                    .foregroundColor(Color(.sRGB, red: 210/255, green: 228/255, blue: 249/255))
                                    .cornerRadius(10))
            }
            .padding(.bottom)
        }
        .cornerRadius(20)
        .background(Rectangle().foregroundColor(Color.white))
        .cornerRadius(20)
        .shadow(radius: 3)
        
    }
}

//struct WriteTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        WriteTestView()
//    }
//}
