//
//  TestResultView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/21.
//

import SwiftUI

struct TestResultView: View {
    
    var state:String
    
    var body: some View {
        VStack{
            
            ZStack{
    
                Text("测评结果")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.top,30)
                
                HStack{
                    Spacer()
                    Image("花1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .padding(.leading,20)
                }
            }
            .padding(.bottom,30)
            
            
            VStack{
                Rectangle()
                    .frame(height: 10)
                    .foregroundColor(Color(.sRGB, red: 133/255, green: 175/255, blue: 225/255))
                VStack{
                    HStack{
                        Text("本次的测评结果为：")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top,15)
                    
                    Text(self.state)
                        .font(.system(size: 26))
                        .fontWeight(.bold)
                        .padding(.vertical,40)
                    
                    Text(self.state == "良好" ? "基于本次测评的结果您的心理状态较为良好，平时也多注意放松休息，记得时刻保持快乐心情哦！" : "测评结果显示您目前的心理健康状态存在风险，请尽快和心理老师联系！进行咨询、治疗，缓解和消除心理压力" )
                        .padding(.horizontal)
                        .padding(.bottom,15)
                        .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                    
                }
                
            }
            .background(Rectangle()
                            .foregroundColor(.white))
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal)
            
            //返回
            Button(action: {
                //界面跳转
                if let window = UIApplication.shared.windows.first
                {
                    window.rootViewController = UIHostingController(rootView: TabBarView())
                    window.makeKeyAndVisible()
                }
            }){
                Text("返回")
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.size.width/2+20, height: 50, alignment: .center)
                    .background(Color(.sRGB, red: 133/255, green: 175/255, blue: 235/255))
                    .cornerRadius(15)
            }
            .padding(.top,30)
            
            Spacer()
            Image("组合花")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.size.width)
        }
        
    }
}

//struct TestResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestResultView()
//    }
//}
