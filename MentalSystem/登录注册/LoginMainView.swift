//
//  LoginView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/8.
//

import SwiftUI

struct LoginMainView: View {
    
    @State var index = 0     //区分是登录还是注册
    @Namespace var name
    
    var body: some View {
        VStack{
            //头像
            Image("photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .padding(.top,20)
            
            //页面切换
            HStack(spacing:0){
                Button(action: {
                    withAnimation(.spring()) {
                        index = 0
                    }
                }) {
                    VStack{
                        Text("登录")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 0 ? .black : .gray)
                        //滑动动画
                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame(height: 4)
                            if index == 0 {
                                Capsule()
                                    .fill(Color(.sRGB, red: 133/255, green: 175/255, blue: 225/255))
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
                
                Button(action: {
                    withAnimation(.spring()) {
                        index = 1
                    }
                }) {
                    VStack{
                        Text("注册")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(index == 1 ? .black : .gray)
                        //滑动动画
                        ZStack{
                            Capsule()
                                .fill(Color.black.opacity(0.04))
                                .frame(height: 4)
                            if index == 1 {
                                Capsule()
                                    .fill(Color(.sRGB, red: 133/255, green: 175/255, blue: 225/255))
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
            .padding(.top,10)
            

            //显示登录界面（根据index进行切换）
            if index == 0 {
                LoginView()
            }
            
            //显示注册界面
            if index == 1 {
                SignInView()
            }
        }
    }
}

struct LoginMainView_Previews: PreviewProvider {
    static var previews: some View {
        LoginMainView()
    }
}
