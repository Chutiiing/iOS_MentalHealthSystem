//
//  PersonMainView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/29.
//

import SwiftUI

struct PersonMainView: View {
    
    @State var showTestHistoryPage = false;
    
    var body: some View {
        ZStack{
            Image("北极熊")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)    //忽略上方的安全距离
            VStack() {
                ZStack{
                    Rectangle()
                        .frame(height: 200)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                        .opacity(0.95)
                    HStack() {
                        Image("photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70)
                        VStack(alignment:.leading,spacing: 15){
                            HStack() {
                                Image(systemName: "person.text.rectangle")
                                Text("学号:")
                                Text("221801438")
                            }
                            HStack() {
                                Image(systemName: "person")
                                Text(" 姓名:")
                                Text("小林")
                            }
                            HStack() {
                                Image(systemName: "book")
                                Text("学院:")
                                Text("计算机与大数据学院")
                                    .frame(width:150,alignment:.leading)
                            }
                            HStack() {
                                Image(systemName: "graduationcap")
                                Text("专业:")
                                Text("软件工程")
                                    .frame(width:150,alignment:.leading)
                            }
                        }.foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                            .font(.system(size: 16))
                    }
                }.padding(.horizontal)
                ZStack {
                    Rectangle()
                        .frame(height: 100)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                        .opacity(0.95)
                    HStack{
                        Text("心理状态：")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Text("良好")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                        Image("钓鱼北极熊")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                    }
                }.padding(.horizontal)
                        
                ZStack{
                    Rectangle()
                        .frame(height: 300)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 20)
                        .opacity(0.95)
                    //历史测评记录列表查看
                    Button(action:{
                        self.showTestHistoryPage = true
                    }){
                        ZStack{
                            Rectangle()
                                .frame(height: 80)
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                                .opacity(0.95)
                            VStack {
                                HStack() {
                                    Image(systemName: "newspaper")
                                    Text("测评历史记录")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }.font(.system(size: 18))
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color(.sRGB, red:100/255, green: 100/255, blue: 100/255))
                                    .cornerRadius(10)
                                    .opacity(0.95)
                            }.padding(.horizontal)
                            
                        }
                        .padding(.horizontal)
                    }
                    .sheet(isPresented: self.$showTestHistoryPage,content:{ Text("历史收藏记录")})
                    .accentColor(Color.black)
                    //历史收藏列表
                    
                    
                }.padding(.horizontal)
                
            }
            
            
            
                
                
        }
        
    }
}

struct PersonMainView_Previews: PreviewProvider {
    static var previews: some View {
        PersonMainView()
    }
}
