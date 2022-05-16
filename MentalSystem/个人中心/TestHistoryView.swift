//
//  TestHistoryView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/5/4.
//

import SwiftUI

struct TestHistoryView: View {
    
    @ObservedObject var testHistoryData:TestHistoryData = TestHistoryData(data: [testHistoryContent(title: "心理压力测评表", result: "良好", date: "2022.05.03"),testHistoryContent(title: "焦虑自评量表 (SAS)", result: "良好", date: "2022.05.01"),testHistoryContent(title: "心理压力测评表", result: "良好", date: "2022.05.01")])
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Image("花2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .padding(.top,25)
                    .padding(.leading,20)
                Text("测评历史")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top,40)
            }
            ScrollView(.vertical,showsIndicators: true){
                VStack(){
                    ForEach(self.testHistoryData.testHistoryContentList){item in
                        testHistoryItem(index: item.id)
                            .environmentObject(self.testHistoryData)
                            .padding(.vertical, 5.0)
                            .padding(.horizontal)
                    }
                }
            }
        }
        
    }
}

//删除记录
func delTestHistory(){
    
}

struct testHistoryItem:View {
    
    //表单数据
    @EnvironmentObject var tableData:TestHistoryData
    //下标
    var index:Int
    
    var body: some View{
        VStack(alignment: .leading,spacing: 10) {
            Circle()
                .frame(width: 15, height: 20, alignment: .leading)
                .padding(.leading,10)
                .padding(.top,6)
                .foregroundColor(Color.white)
            Text(self.tableData.testHistoryContentList[index].title)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.leading)
                .foregroundColor(Color.black)
            HStack() {
                Text("测试结果:")
                Text(self.tableData.testHistoryContentList[index].result)
                Spacer()
                Button(action: delTestHistory) {
                    Text("删除")
                        .foregroundColor(.red)
                        .frame(width: 60,height: 25)
                        .background(Rectangle()
                                        .foregroundColor(Color.white))
                        .cornerRadius(15)
                }
                .padding(.trailing)
            }
            .font(.system(size: 17))
            .padding(.leading)
            HStack(){
                Image(systemName: "clock")
                Text(self.tableData.testHistoryContentList[index].date)
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


struct TestHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TestHistoryView()
    }
}
