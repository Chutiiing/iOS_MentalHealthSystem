//
//  TableDetailView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/29.
//

import SwiftUI

struct TableDetailView: View {
    var body: some View {
        VStack{
            ScrollView(.vertical,showsIndicators: false){
                ZStack{
                    Image("testbg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    ZStack(alignment:.leading){
                        Rectangle()
                            .frame(width: 400, height: 110)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 20)
                            .offset(x: -100,y: 130)
                        VStack(alignment:.leading,spacing: 5){
                            Text("心理测评量表")
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .frame(width: 270,alignment: .leading)
                                .padding(.top,14)
                            HStack() {
                                Image(systemName: "person").font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                                Text("发布人")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                                Text("admin")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                            }.padding(.top,6)
                            HStack(){
                                Image(systemName: "clock").font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                                Text("发布时间").font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                                Text("2022.04.26").font(.system(size: 15))
                                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                            }
                        }
                        .offset(x:20,y: 120)
                    }
                }
                
                VStack(spacing:15){
                    
                    VStack(spacing: 15){
                        
                        Rectangle()
                            .frame(height: 10)
                            .foregroundColor(Color(.sRGB, red: 97/255, green: 175/255, blue: 225/255))
                            
                        VStack(alignment: .leading,spacing: 10){
                            Text("测评简介：")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                            Text("心理健康量表简介心理健康量表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简心理健康量表简介心理健康量表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简心理健康量表简介心理健康量表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简心理健康量表简介心理健康量表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简心理健康量表简介心理健康量表简介心理")
                                .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                        }
                        .padding(.all)
                        
                    }
                    .cornerRadius(20)
                    .background(Rectangle()
                                    .foregroundColor(Color.white)
                                    )
                    .cornerRadius(20)
                    .shadow(radius: 5,x:5,y:5)
                    .padding(.horizontal)
                }.padding(.top,85)
            }
            Button(action: startTest) {
                Text("开始测评")
            }
            .foregroundColor(Color.white)
            .frame(width: UIScreen.main.bounds.size.width/2, height: 50, alignment: .center)
            .background(Color(.sRGB, red: 97/255, green: 175/255, blue: 225/255))
            .cornerRadius(15)
        }
        
        
        
    }
}

//开始测评
func startTest() {
    
}

struct TableDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TableDetailView()
.previewInterfaceOrientation(.portrait)
    }
}
