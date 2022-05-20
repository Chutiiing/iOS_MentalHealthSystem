//
//  BookingRecordView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct BookingRecordView: View {
    
    @ObservedObject var bookingRecordData:BookingRecordData = BookingRecordData()
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Image("花3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .padding(.top,25)
                    .padding(.leading,20)
                Text("预约记录")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,40)
            }
            ScrollView(.vertical,showsIndicators: true){
                VStack(){
                    ForEach(self.bookingRecordData.bookingRecordList){item in
                        if !item.deleted{
                            bookingRecordItem(index: item.id)
                                .environmentObject(self.bookingRecordData)
                                .padding(.vertical, 5.0)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
}

struct bookingRecordItem:View{
    
    //表单数据
    @EnvironmentObject var tableData:BookingRecordData
    //下标
    var index:Int
    
    //预约没预约
    @State var isBooking = true;
    
    var body: some View{
        VStack(alignment: .leading,spacing: 15) {
            Circle()
                .frame(width: 15, height: 20, alignment: .leading)
                .padding(.leading,10)
                .padding(.top,6)
                .foregroundColor(Color.white)
            
            HStack() {
                Image(systemName: "person")
                Text("心理老师:")
                Text(self.tableData.bookingRecordList[index].admin)
            }
            .padding(.leading)
            
            HStack(alignment: .top,spacing: 10) {
                Image(systemName: "square.text.square")
                Text("教师简介:")
                Text(self.tableData.bookingRecordList[index].abstract)
            }
            .padding(.horizontal)
            
            HStack() {
                Image(systemName: "phone")
                Text("联系电话:")
                Text(self.tableData.bookingRecordList[index].phone)
            }
            .padding(.leading)
            
            HStack() {
                Image(systemName: "calendar")
                Text("可预约时间:")
                Text(self.tableData.bookingRecordList[index].date)
            }
            .padding(.leading)
            
            HStack() {
                Image(systemName: "house")
                Text("咨询室:")
                Text(self.tableData.bookingRecordList[index].room)
            }
            .padding(.leading)
            
            HStack{
                Spacer()
                Button(action:{
                    //合法时间内的可以取消
                    if self.isBooking {
                        AF.request(RequestURL.init().url+"booking/delBooking/"+String(self.tableData.bookingRecordList[index].bookingID),
                                   method: .post,
                                   encoding: URLEncoding.default).responseJSON{ (response) in
                            switch response.result {
                            //成功接收
                            case .success(let data):
                                
                                let res = JSON(data).boolValue
                                //删除后界面刷新,移除数据
                                if res {
                                    self.tableData.del(id: index);
                                }
                                
                                break
                            case .failure(let error):
                                print("错误信息:\(error)")
                                break
                            }
                            
                        }
                    }
                }){
                    Text(self.isBooking ? "取消预约" : "已过期")
                        .foregroundColor(self.isBooking ? .red : .gray)
                        .frame(width: 120,height: 35)
                        .background(Rectangle()
                                        .foregroundColor(Color.white))
                        .cornerRadius(15)
                }
                .padding(.bottom)
                Spacer()
            }
        }
        .font(.system(size: 16))
        .background(Rectangle()
                        .foregroundColor(Color(.sRGB, red: 210/255, green: 228/255, blue: 249/255)))
        .cornerRadius(20)
        .shadow(radius: 5,x:3,y:3)
        .onAppear(){
            // 获取当前系统时间
            let date = NSDate()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let time = timeFormatter.string(from: date as Date) as String
            if time > self.tableData.bookingRecordList[index].date {
                self.isBooking = false;
            }
            
        }
    }
}

struct BookingRecordView_Previews: PreviewProvider {
    static var previews: some View {
        BookingRecordView()
    }
}
