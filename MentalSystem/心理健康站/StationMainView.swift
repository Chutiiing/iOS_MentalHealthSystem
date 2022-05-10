//
//  StationMainView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/29.
//

import SwiftUI

struct StationMainView: View {
    var body: some View {
        VStack(spacing:0) {
            //小贴士
            tipsView()
                .padding(.top,30)
            Spacer()
            VStack(spacing:10){
                HStack{
                    Text("美好总会出现在下一个转弯")
                        .foregroundColor(.gray)
                    Spacer()
                }

                //咨询室预约
                NavigationLink(destination:{
                    BookingView()
                })  {
                    bookingButton()
                        .foregroundColor(.black)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct tipsView:View{
    
    @State var isStar = false    //判断是否收藏
    
    var body: some View{
        VStack(spacing:20) {
            Rectangle()
                .frame(height: 10)
                .foregroundColor(Color(.sRGB, red: 133/255, green: 175/255, blue: 225/255))
            HStack{
                Spacer()
                Text("一些小贴士")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            ScrollView(.vertical,showsIndicators: false){
                Text("一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士一些心理健康贴士")
                    .foregroundColor(Color(.sRGB, red:50/255, green: 50/255, blue: 50/255))
            }
            .frame(height: 230)
            .padding(.horizontal)
            //收藏按钮
            Button(action: {
                self.isStar = !self.isStar
            }){
                Image(systemName: self.isStar ? "star.fill" : "star")
                    .font(.title2)
                    .foregroundColor(self.isStar ? .yellow : .black)
            }
            .padding(.bottom)
        }
        .background(Rectangle()
                        .foregroundColor(.white))
        .cornerRadius(10)
        .shadow(radius: 5,x:3,y:3)
    }
}

struct bookingButton:View{
    var body: some View{
        HStack {
            Image("岛")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
                .padding(.leading)
            Text("线下咨询室预约")
                .font(.system(size: 18))
            Spacer()
            Image(systemName: "chevron.right")
                .padding(.trailing)
        }
        .background(Rectangle()
                        .foregroundColor(.white))
        .cornerRadius(10)
        .shadow(radius: 5,x:3,y:3)
    }
}

struct StationMainView_Previews: PreviewProvider {
    static var previews: some View {
        StationMainView()
    }
}
