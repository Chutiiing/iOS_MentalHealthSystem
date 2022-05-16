//
//  StationMainView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/29.
//

import SwiftUI

struct StationMainView: View {
    
    @State var isPushed = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack(spacing:0) {
                    //小贴士
                    tipsView()
                        .padding(.top,30)
                    
                    //线下咨询室按钮
                    VStack(spacing:10){
                        HStack{
                            Text("美好总会出现在下一个转弯")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        //咨询室预约
                        NavigationLink(destination:
                                        BookingView(isPushed: self.$isPushed),
                                       isActive: self.$isPushed)  {
                            bookingButton()
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.top,30)
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Spacer()
                        Image("花1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                    }
                    Spacer()
                }
            }
            Image("组合花")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.size.width)
        }
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
                Text("Tips")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            ScrollView(.vertical,showsIndicators: false){
                Text("有时候我们活的很累，并非生活过于刻薄，而是我们太容易被外界的氛围所感染，被他人的情绪所左右。行走在人群中，我们总是感觉有无数穿心夺肺的目光，有很多飞短流长的冷言，最终乱了心神，渐渐被缚于被自己编织的乱麻中。")
                    .foregroundColor(Color(.sRGB, red:50/255, green: 50/255, blue: 50/255))
            }
            .frame(height: 135)
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
