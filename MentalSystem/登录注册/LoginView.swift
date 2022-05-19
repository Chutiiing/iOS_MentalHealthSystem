//
//  LoginView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/8.
//

import SwiftUI
import Alamofire
import SwiftyJSON

//提示信息
struct AlertData:Identifiable{
    var id = UUID()
    var message:String
}

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
    @State var showAlert = false
    
    //提示信息
    @State var alertData:AlertData?
    
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
                SecureField("密码", text: self.$password)
                    .padding()
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 3)
            }.padding(.top,10)
            
            Button(action: {
                //填写信息为空
                if self.sno.isEmpty || self.password.isEmpty {
                    self.alertData = AlertData(message: "学号或密码不可为空")
                }
                else if self.sno.lengthOfBytes(using: .ascii) != 9{
                    self.alertData = AlertData(message: "合法学号信息应为9位")
                }
                else if self.password.lengthOfBytes(using: .ascii) < 3 || self.password.lengthOfBytes(using: .ascii) > 18 {
                    self.alertData = AlertData(message: "合法密码长度应在3位到18位之间")
                }
                else{
                    //请求查询学号密码是否正确
                    AF.request(RequestURL.init().url+"students/login",
                               method: .post,
                               parameters: ["sno":self.sno,"password":self.password],
                               encoding: JSONEncoding.default).responseJSON{ (response) in
                        switch response.result {
                        //成功接收
                        case .success(let data):
                            
                            let res = JSON(data).boolValue
                            
                            //账号密码正确
                            if res {
                                let user = UserDefaults.standard
                                //存取用户信息
                                user.set(self.sno, forKey: "sno")
                                //存取为登录过 1表示登录过，0表示未登录
                                user.set(1, forKey: "isSign")
                                //界面跳转
                                if let window = UIApplication.shared.windows.first
                                {
                                    window.rootViewController = UIHostingController(rootView: TabBarView())
                                    window.makeKeyAndVisible()
                                }
                            }
                            //账号密码不正确
                            else{
                                self.alertData = AlertData(message: "学号或密码不正确")
                            }
                            
                            break
                        case .failure(let error):
                            print("错误信息:\(error)")
                            break
                        }
                        
                    }
                }
            }){
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
            .alert(item: $alertData){ alertData in
        
                Alert(title: Text("提示"), message: Text(alertData.message), dismissButton: .default(Text("确认")))
                
            }
            
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
    @State private var selectedSex = "女"
    let sexs = ["女","男"]
    
    //学院
    @State private var selectedAcademy = "计算机与大数据学院"
    let academys = ["计算机与大数据学院","数学与统计学院","物理与信息工程学院","土木工程学院","外国语学院"]
    
    //专业
    @State private var selectedMajor = "软件工程"
    let majors = ["软件工程","计算机类","数学","统计学","自动化", "土木工程" ,"英语","日语"]
    
    //年级
    @State private var selectedGrade = "18"
    let grades = ["18","19", "20", "21"]
    
    
    @State private var showAlert = false
    
    //提示信息
    @State var alertData:AlertData?
    
    
    
    
    var body: some View {
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
                            ForEach(sexs, id: \.self) {
                                Text($0)
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
                            ForEach(academys, id: \.self) {
                                Text($0)
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
                            ForEach(majors, id: \.self) {
                                Text($0)
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
                    
                    HStack(spacing:20) {
                        Text("请选择年级")
                            .opacity(0.5)
                            .foregroundColor(.gray)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Picker("年级", selection: $selectedGrade) {
                            ForEach(grades, id: \.self) {
                                Text($0)
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
                
                //注册按钮
                Button(action: {
                    //填写信息为空
                    if self.sno.isEmpty || self.name.isEmpty || self.password.isEmpty{
                        self.alertData = AlertData(message: "所填信息不能为空")
                    }
                    else if self.sno.lengthOfBytes(using: .ascii) != 9{
                        self.alertData = AlertData(message: "合法学号信息应为9位")
                    }
                    else if self.password.lengthOfBytes(using: .ascii) < 3 || self.password.lengthOfBytes(using: .ascii) > 18 {
                        self.alertData = AlertData(message: "合法密码长度应在3位到18位之间")
                    }
                    //请求插入数据
                    else{
                        AF.request(RequestURL.init().url+"students/insert",
                                   method: .post,
                                   parameters: ["sno":self.sno,"name":self.name,"password":self.password,"sex":self.selectedSex,"academy":self.selectedAcademy,"major":self.selectedMajor,"grade":self.selectedGrade,"state":"良好"],
                                   encoding: JSONEncoding.default).responseJSON{ (response) in
                            switch response.result {
                                //成功接收
                            case .success(let data):
                                let res = JSON(data).intValue
                                print("啥")
                                print(res)
                                if res > 0 {
                                    self.alertData = AlertData(message: "注册成功")
                                }
                                else{
                                    self.alertData = AlertData(message: "已注册过，请进行登录")
                                }
                                break
                            case .failure(let error):
                                print("错误信息:\(error)")
                                break
                            }
                        }
                    }
                }){
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
                .alert(item: $alertData){ alertData in
                    
                    Alert(title: Text("提示"), message: Text(alertData.message), dismissButton: .default(Text("确认")))
                    
                }
                
            }
            .padding(.top,25)
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
