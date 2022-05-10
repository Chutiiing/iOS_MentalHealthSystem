//
//  PersonMainView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/29.
//

import SwiftUI

struct PersonMainView: View {
    
    @State var showTestHistoryPage = false;       //记录历史收藏记录页面是否打开
    @State var showTipsCollectPage = false;       //记录贴士收藏界面是否打开
    @State var showBookingPage = false;           //记录预约信息界面是否打开
    
    
    var body: some View {
        ZStack{
            Image("北极熊")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)    //忽略上方的安全距离
            
            //个人信息
            VStack() {
                ZStack{
                    Rectangle()
                        .frame(height: 200)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .opacity(0.95)
                    HStack() {
                        Image("photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70)
                        VStack(alignment:.leading,spacing: 15){
                            HStack() {
                                Image(systemName: "person.text.rectangle")
                                    .frame(width: 20)
                                Text("学号:")
                                Text("221801438")
                            }
                            HStack() {
                                Image(systemName: "person")
                                    .frame(width: 20)
                                Text("姓名:")
                                Text("小林")
                            }
                            HStack() {
                                Image(systemName: "book")
                                    .frame(width: 20)
                                Text("学院:")
                                Text("计算机与大数据学院")
                                    .frame(width:150,alignment:.leading)
                            }
                            HStack() {
                                Image(systemName: "graduationcap")
                                    .frame(width: 20)
                                Text("专业:")
                                Text("软件工程")
                                    .frame(width:150,alignment:.leading)
                            }
                        }.foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                            .font(.system(size: 16))
                    }
                }.padding(.horizontal)
                
                //心理状态
                ZStack {
                    Rectangle()
                        .frame(height: 100)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
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
                
                //功能列表
                ZStack{
                    Rectangle()
                        .frame(height: 200)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .opacity(0.95)
                    
                    VStack() {
                        //历史测评记录列表查看
                        Button(action:{
                            self.showTestHistoryPage = true
                        }){
                            ZStack{
                                Rectangle()
                                    .frame(height: 45)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(10)
                                    .opacity(0.95)
                                VStack {
                                    HStack() {
                                        Image(systemName: "newspaper")
                                        Text("我的测评历史")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }.font(.system(size: 18))
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color(.sRGB, red:100/255, green: 100/255, blue: 100/255))
                                        .cornerRadius(10)
                                        .opacity(0.3)
                                }.padding(.horizontal)
                                
                            }
                            .padding(.horizontal)
                        }
                        .sheet(isPresented: self.$showTestHistoryPage,content:{ TestHistoryView()})
                        .accentColor(Color.black)
                        
                        //历史收藏列表
                        Button(action:{
                            self.showTipsCollectPage = true
                        }){
                            ZStack{
                                Rectangle()
                                    .frame(height: 45)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(10)
                                    .opacity(0.95)
                                VStack {
                                    HStack() {
                                        Image(systemName: "star")
                                        Text("我的贴士收藏")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }.font(.system(size: 18))
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color(.sRGB, red:100/255, green: 100/255, blue: 100/255))
                                        .cornerRadius(10)
                                        .opacity(0.3)
                                }.padding(.horizontal)
                                
                            }
                            .padding(.horizontal)
                        }
                        .sheet(isPresented: self.$showTipsCollectPage,content:{ TipsCollectedView()})
                        .accentColor(Color.black)
                        
                        //预约记录按钮
                        Button(action:{
                            self.showBookingPage = true
                        }){
                            ZStack{
                                Rectangle()
                                    .frame(height: 45)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(10)
                                    .opacity(0.95)
                                VStack {
                                    HStack() {
                                        Image(systemName: "text.bubble")
                                        Text("我的预约记录")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }.font(.system(size: 18))
                                    Rectangle()
                                        .frame(height: 1)
                                        .foregroundColor(Color(.sRGB, red:100/255, green: 100/255, blue: 100/255))
                                        .cornerRadius(10)
                                        .opacity(0.3)
                                }.padding(.horizontal)
                                
                            }
                            .padding(.horizontal)
                        }
                        .sheet(isPresented: self.$showBookingPage,content:{ BookingRecordView()})
                        .accentColor(Color.black)
                    }
                }.padding(.horizontal)
                
                Button(action:{
                    
                }){
                    Text("退出登录")
                        .foregroundColor(.black)
                        .background(Rectangle()
                                        .frame(width:UIScreen.main.bounds.size.width/2,height:50)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                        .opacity(0.95))
                }.padding(.top)
            }
        }
        
    }
}

struct PersonMainView_Previews: PreviewProvider {
    static var previews: some View {
        PersonMainView()
    }
}
