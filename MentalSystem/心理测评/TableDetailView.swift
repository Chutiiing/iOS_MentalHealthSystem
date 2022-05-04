//
//  TableDetailView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/29.
//

import SwiftUI

struct TableDetailView: View {
    
    //子视图使用了副视图的类
    //@EnvironmentObject保证刷新
    var data:testContent
    
    var body: some View {
        
        VStack {
            ScrollView(.vertical,showsIndicators: false){
                //测评表名
                ZStack{
                    Image("testbg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    ZStack(alignment:.leading){
                        Rectangle()
                            .frame(width: 400, height: 110)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .offset(x: -100,y: 140)
                        VStack(alignment:.leading,spacing: 5){
                            Text(self.data.title)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .frame(width: 270,alignment: .leading)
                                .padding(.top,14)
                            HStack() {
                                Image(systemName: "person").font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                                Text("发布人")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                                Text(self.data.admin)
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                            }.padding(.top,6)
                            HStack(){
                                Image(systemName: "clock").font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                                Text("发布时间").font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                                Text(self.data.date).font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                            }
                        }
                        .offset(x:20,y: 130)
                    }
                }
                
                //测评简介
                VStack(spacing:15){
                    VStack(spacing: 15){
                        Rectangle()
                            .frame(height: 10)
                            .foregroundColor(Color(.sRGB, red: 133/255, green: 175/255, blue: 225/255))
                        VStack(alignment: .leading,spacing: 10){
                            Text("测评简介：")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                            Text(self.data.abstract)
                                .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                            Text("注意事项：")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                            Text("1. 本测试结果不可作为精神疾病诊断的依据。若需要相关诊断，请前往医院心理科或精神科问询。")
                                .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                            Text("2. 为了确保测试的准确性，请诚实回答。")
                                .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                            Text("3. 尽量根据自己的第一直觉做出选择。")
                                .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                        }
                        .padding(.all)
                    }
                    .cornerRadius(20)
                    .background(Rectangle().foregroundColor(Color.white))
                    .cornerRadius(20)
                    .shadow(radius: 3)
                    .padding(.horizontal)
                }
                .padding(.top,100)
            }
            .edgesIgnoringSafeArea(.top)   //忽略上方的安全距离
            
            
            
            Button(action: startTest) {
                Text("开始测评")
            }
            .foregroundColor(Color.white)
            .frame(width: UIScreen.main.bounds.size.width/2, height: 50, alignment: .center)
            .background(Color(.sRGB, red: 133/255, green: 175/255, blue: 235/255))
            .cornerRadius(15)
        }
    }
}

//开始测评
func startTest() {
    
}

//预览界面
//struct TableDetailView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        TableDetailView()
//    }
//}
