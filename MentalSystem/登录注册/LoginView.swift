//
//  LoginView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/20.
//

import SwiftUI
import Alamofire
import SwiftyJSON


struct LoginView: View {
    
    //提示信息
    struct AlertData:Identifiable{
        var id = UUID()
        var message:String
    }
    
    @State var sno:String = ""
    @State var password:String = ""
    @State var showAlert = false
    
    //提示信息
    @State var alertData:AlertData?
    
    var body: some View {
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
