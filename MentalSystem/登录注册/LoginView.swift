//
//  LoginView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/8.
//

import SwiftUI

struct LoginView: View {
    
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
                Login()
            }
            
            //显示注册界面
            if index == 1 {
                SignIn()
            }
        }
    }
}

//登录
struct Login:View{
    
    @State var sno:String = ""
    @State var password:String = ""
    
    var body: some View{
        VStack{
            VStack(alignment: .leading, spacing: 12) {
                Text("学号")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                TextField("学号", text: self.$sno)
                    .padding()
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 3)
                
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("密码")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                TextField("密码", text: self.$password)
                    .padding()
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 3)
            }.padding(.top,10)
            
            Button(action: {}){
                Text("登录")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.size.width-50)
                    .foregroundColor(Color(.sRGB, red: 85/255, green: 158/255, blue: 230/255))
                    .background(
                        //渐变
                        LinearGradient(gradient: .init(colors: [Color(.sRGB, red: 143/255, green: 199/255, blue: 255/255),Color(.sRGB, red: 231/255, green: 240/255, blue: 248/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(8)
            }
            .padding(.horizontal,25)
            .padding(.top,20)
            
        }
        .padding(.horizontal,25)
        .padding(.top,25)
        
    }
}

//注册
struct SignIn:View{
    
    //学号
    @State var sno:String = ""
    //姓名
    @State var name:String = ""
    //密码
    @State var password:String = ""
    //性别
    enum Sex: String, CaseIterable, Identifiable {
        case 女
        case 男
        
        var id: String { self.rawValue }
    }
    @State private var selectedSex = Sex.女
    //学院
    enum Academy: String, CaseIterable, Identifiable {
        case 计算机与大数据学院
        case 物理与信息工程学院
        
        var id: String { self.rawValue }
    }
    @State private var selectedAcademy = Academy.计算机与大数据学院
    
    //专业
    enum Major: String, CaseIterable, Identifiable {
        case 软件工程
        case 自动化
        
        var id: String { self.rawValue }
    }
    @State private var selectedMajor = Major.软件工程

    @State private var grade:String = ""
    
    
    var body: some View{
        VStack{
            
            //填写信息
            ScrollView(.vertical,showsIndicators: false){
                VStack(alignment: .leading, spacing: 12) {
                    Text("学号")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    TextField("请输入学号", text: self.$sno)
                        .padding()
                        .background(.white)
                        .cornerRadius(5)
                        .shadow(radius: 3)
                    
                }
                .padding(.horizontal,25)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("姓名")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    TextField("请输入姓名", text: self.$name)
                        .padding()
                        .background(.white)
                        .cornerRadius(5)
                        .shadow(radius: 3)
                }
                .padding(.top,10)
                .padding(.horizontal,25)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("密码")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    TextField("请输入密码", text: self.$password)
                        .padding()
                        .background(.white)
                        .cornerRadius(5)
                        .shadow(radius: 3)
                }
                .padding(.top,10)
                .padding(.horizontal,25)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("性别")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    HStack(spacing:20) {
                        Text("请选择性别")
                            .opacity(0.5)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Picker("性别", selection: $selectedSex) {
                            ForEach(Sex.allCases, id: \.self) {sex in
                                Text(sex.rawValue)
                                    .tag(sex)
                            }
                        }
                        .padding(.trailing)
                        .accentColor(.black)
                        .frame(height:50)
                    }
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 3)
                }
                .padding(.top,10)
                .padding(.horizontal,25)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("学院")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    HStack(spacing:20) {
                        Text("请选择学院")
                            .opacity(0.5)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Picker("学院", selection: $selectedAcademy) {
                            ForEach(Academy.allCases, id: \.self) {academy in
                                Text(academy.rawValue)
                                    .tag(academy)
                            }
                        }
                        .padding(.trailing)
                        .accentColor(.black)
                        .frame(height:50)
                    }
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 3)
                }
                .padding(.top,10)
                .padding(.horizontal,25)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("专业")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    HStack(spacing:20) {
                        Text("请选择专业")
                            .opacity(0.5)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Picker("专业", selection: $selectedMajor) {
                            ForEach(Major.allCases, id: \.self) {major in
                                Text(major.rawValue)
                                    .tag(major)
                            }
                        }
                        .padding(.trailing)
                        .accentColor(.black)
                        .frame(height:50)
                    }
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 3)
                }
                .padding(.top,10)
                .padding(.horizontal,25)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("年级")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    TextField("请输入年级", text: self.$grade)
                        .padding()
                        .background(.white)
                        .cornerRadius(5)
                        .shadow(radius: 3)
                }
                .padding(.top,10)
                .padding(.horizontal,25)
            }
            
            Button(action: {}){
                Text("注册")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.size.width-50)
                    .foregroundColor(Color(.sRGB, red: 85/255, green: 158/255, blue: 230/255))
                    .background(
                        //渐变
                        LinearGradient(gradient: .init(colors: [Color(.sRGB, red: 143/255, green: 199/255, blue: 255/255),Color(.sRGB, red: 231/255, green: 240/255, blue: 248/255)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(8)
            }
            .padding(.horizontal,25)
            .padding(.top,20)
            
        }
        .padding(.top,25)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
