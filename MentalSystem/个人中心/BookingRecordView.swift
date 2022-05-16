//
//  BookingRecordView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import SwiftUI

struct BookingRecordView: View {
    
    var bookingRecordData:BookingRecordData = BookingRecordData(data: [bookingRecordContent(admin: "admin", abstract: "一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介一些教师的简介", phone:"123456", date: "2022.04.26 15:00", room: "咨询室1")])
    
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

func delBooking(){
    
}

struct bookingRecordItem:View{
    
    //表单数据
    @EnvironmentObject var tableData:BookingRecordData
    //下标
    var index:Int
    
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
                Button(action:delBooking){
                    Text("取消预约")
                        .foregroundColor(.red)
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
    }
}

struct BookingRecordView_Previews: PreviewProvider {
    static var previews: some View {
        BookingRecordView()
    }
}
