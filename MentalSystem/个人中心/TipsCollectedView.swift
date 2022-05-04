//
//  TipsCollectedView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import SwiftUI

struct TipsCollectedView: View {
    
    @ObservedObject var tipsCollectedData:TipsCollectedData = TipsCollectedData(data: [tipsCollectedContent(tipsContent: "1一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士", date: "2022.05.01"),tipsCollectedContent(tipsContent: "2一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士", date: "2022.05.01"),tipsCollectedContent(tipsContent: "3一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士一些不重要的贴士", date: "2022.05.01")])
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("贴士收藏")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top,40)
                .padding(.leading,30)
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
        VStack(alignment: .leading,spacing: 10) {
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
            }
            .font(.system(size: 14))
            .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
            .padding([.leading, .bottom])
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
