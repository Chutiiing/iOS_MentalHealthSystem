//
//  TestMainView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/28.
//

//心理测评主界面

import SwiftUI

struct TestMainView: View {
    
    //量表数据
    @ObservedObject var tableData:TestData = TestData(data: [testContent(title: "心理压力测评表", abstract: "在现代社会中，由于竞争日趋激烈，生活节奏加快，各种应急事件增多，人们的心理压力不断加大，容易产生各种负性情绪，成为影响人们生活质量的重要因素。那么，我们能否自我测试所受的心理压力，预防和减轻身心损害呢？", admin: "admin", date: "2022-04-26 17:00:00"),testContent(title: "Sarason考试焦虑量表(TAS)", abstract: "此量表用于测定初中以上学生在考试期间的焦虑水平。下列37个句子是描述人们对参加考试的感受。", admin: "admin", date: "2022-04-26 17:00:00"),testContent(title: "焦虑自评量表 (SAS)", abstract: "焦虑自评量表(Self-Rating Anxiety Scale SAS)由华裔教授Zung编制（1971）。从量表构造的形式到具体评定的方法，都与抑郁自评量表(SDS)十分相似，是一种分析病人主观症状的相当简便的临床工具。由于焦虑是心理咨询门诊中较常见的一种情绪障碍，所以近年来SAS是咨询门诊中了解焦虑症状的常用量表。", admin: "admin", date: "2022-04-26 17:00:00"),testContent(title: "人际信任量表", abstract: "本量表用于测试受试者对他人行为、承诺或陈述之可靠性的估计。共25个项目，其内容涉及各种处境下的人际信任，涉及不同社会角色。多数项目于社会角色的可信赖信有关，但有些项目与对未来的社会的乐观程度有关。", admin: "admin", date: "2022-04-26 17:00:00")])
    
    
    var body: some View {
        
        ScrollView(.vertical,showsIndicators: true){
            VStack(){
                ForEach(self.tableData.testContentList){item in
                    //实现详情页界面跳转
                    NavigationLink(destination: TableDetailView(data:self.tableData.testContentList[item.id])){
                        testItem(index: item.id)
                            .environmentObject(self.tableData)
                            .padding(.vertical, 5.0)
                            .padding(.horizontal)
                    }
                    
                }
            }
        }
    
    }
}

//List的元素视图
struct testItem: View {
    
    //子视图使用了副视图的类
    //@EnvironmentObject保证刷新
    @EnvironmentObject var tableData:TestData
    //下标
    var index:Int
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 15) {
            Circle()
                .frame(width: 15, height: 20, alignment: .leading)
                .padding(.leading,10)
                .padding(.top,6)
                .foregroundColor(Color.white)
            HStack {
                Image("花花")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                Text(self.tableData.testContentList[index].title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .font(.title3)
                .foregroundColor(Color.black)
            }
            .padding(.leading)
            VStack(alignment: .leading,spacing: 5){
                Text("简介：")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .foregroundColor(Color.black)
                Text(self.tableData.testContentList[index].abstract)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .font(.system(size: 16))
                    .lineLimit(3)
                    .foregroundColor(Color.black)
            }
            HStack() {
                Image(systemName: "person")
                Text("发布人")
                Text(self.tableData.testContentList[index].admin)
            }
            .font(.system(size: 15))
            .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
            .padding(.leading)
            HStack(){
                Image(systemName: "clock")
                Text("发布时间")
                Text(self.tableData.testContentList[index].date)
            }
            .font(.system(size: 15))
            .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
            .padding([.leading, .bottom])
        }
        .background(Rectangle()
                        .foregroundColor(Color(.sRGB, red: 210/255, green: 228/255, blue: 249/255)))
        .cornerRadius(20)
        .shadow(radius: 5,x:3,y:3)
                        
    }
}

struct TestMainView_Previews: PreviewProvider {
    static var previews: some View {
        TestMainView()
    }
}
