//
//  BookingView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/10.
//

import SwiftUI

struct BookingView: View {
    
    var bookingData:BookingData = BookingData(data: [bookingContent(admin: "admin", abstract: "一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介", phone:"123456", date: "2022.04.26 15:00", room: "咨询室1"),bookingContent(admin: "admin", abstract: "一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介", phone:"123456", date: "2022.04.26 15:00", room: "咨询室2"),bookingContent(admin: "admin", abstract: "一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介", phone:"123456", date: "2022.04.26 15:00", room: "咨询室3")])
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: true){
            VStack(){
                ForEach(self.bookingData.bookingList){item in
                    bookingItem(index: item.id)
                        .environmentObject(self.bookingData)
                        .padding(.vertical, 5.0)
                        .padding(.horizontal)
                }
            }
        }
        //.edgesIgnoringSafeArea(.top)   //忽略上方的安全距离
        
    }
}

struct bookingItem: View {
    
    //表单数据
    @EnvironmentObject var tableData:BookingData
    //下标
    var index:Int
    //是否预约
    @State var isBooking = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15) {
            Circle()
                .frame(width: 15, height: 20, alignment: .leading)
                .padding(.leading,10)
                .padding(.top,6)
                .foregroundColor(Color.white)
            
            HStack() {
                Image(systemName: "person")
                Text("心理老师:")
                Text(self.tableData.bookingList[index].admin)
            }
            .padding(.leading)
            
            HStack(alignment: .top,spacing: 10) {
                Image(systemName: "square.text.square")
                Text("教师简介:")
                Text(self.tableData.bookingList[index].abstract)
            }
            .padding(.horizontal)
            
            HStack() {
                Image(systemName: "phone")
                Text("联系电话:")
                Text(self.tableData.bookingList[index].phone)
            }
            .padding(.leading)
            
            HStack() {
                Image(systemName: "calendar")
                Text("可预约时间:")
                Text(self.tableData.bookingList[index].date)
            }
            .padding(.leading)
            
            HStack() {
                Image(systemName: "house")
                Text("咨询室:")
                Text(self.tableData.bookingList[index].room)
            }
            .padding(.leading)
            
            HStack{
                Spacer()
                Button(action:{
                    self.isBooking = !self.isBooking
                }){
                    Text(self.isBooking ? "已预约" : "预约")
                        .foregroundColor(self.isBooking ? .gray : .blue)
                        .frame(width: 100,height: 35)
                        .background(Rectangle()
                                        .foregroundColor(Color.white))
                        .cornerRadius(10)
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
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
