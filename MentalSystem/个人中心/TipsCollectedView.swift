//
//  TipsCollectedView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import SwiftUI

struct TipsCollectedView: View {
    
    @ObservedObject var tipsCollectedData:TipsCollectedData = TipsCollectedData(data: [tipsCollectedContent(tipsContent: "有时候我们活的很累，并非生活过于刻薄，而是我们太容易被外界的氛围所感染，被他人的情绪所左右。行走在人群中，我们总是感觉有无数穿心夺肺的目光，有很多飞短流长的冷言，最终乱了心神，渐渐被缚于被自己编织的乱麻中。", date: "2022.04.26"),tipsCollectedContent(tipsContent: "无人问津也好，技不如人也罢。你都要试着安静下来，去做你该做的事。而不是让内心烦躁焦虑，毁掉你本就不多的热情定力。", date: "2022.05.01"),tipsCollectedContent(tipsContent: "人生这条路很长，未来如星辰大海般璀璨，不必踌躇与过去的半亩方塘。那些所谓的遗憾 可能是一种成长，那些曾经受过的伤 终会化作照亮前路的光。", date: "2022.05.01")])
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Text("贴士收藏")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,40)
                    .padding(.leading,30)
                Spacer()
                Image("花1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .padding(.leading,20)
            }
            ScrollView(.vertical,showsIndicators: true){
                VStack(){
                    ForEach(self.tipsCollectedData.tipsCollectedList){item in
                        tipsCollectedItem(index: item.id)
                            .environmentObject(self.tipsCollectedData)
                            .padding(.vertical, 5.0)
                            .padding(.horizontal)
                    }
                }
            }
        }
        
    }
}

func delTips(){
    
}

struct tipsCollectedItem:View {
    
    //表单数据
    @EnvironmentObject var tableData:TipsCollectedData
    //下标
    var index:Int
    
    var body: some View{
        VStack(spacing: 10) {
            HStack{
                Circle()
                    .frame(width: 15, height: 20, alignment: .leading)
                    .padding(.leading,10)
                    .foregroundColor(Color.white)
                Spacer()
                Button(action: delTips) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.red)
                }
                .padding(.trailing,12)
            }
            .padding(.top,6)
            
            Text(self.tableData.tipsCollectedList[index].tipsContent)
                .padding(.horizontal)
            
            HStack(){
                Image(systemName: "clock")
                Text(self.tableData.tipsCollectedList[index].date)
                Spacer()
            }
            .padding(.horizontal)
            .font(.system(size: 14))
            .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
            .padding(.bottom)
        }
        .background(Rectangle()
                        .foregroundColor(Color(.sRGB, red: 210/255, green: 228/255, blue: 249/255)))
        .cornerRadius(20)
        .shadow(radius: 5,x:3,y:3)

    }
}

struct TipsCollectedView_Previews: PreviewProvider {
    static var previews: some View {
        TipsCollectedView()
    }
}
