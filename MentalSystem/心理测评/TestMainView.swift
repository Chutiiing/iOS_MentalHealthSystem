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
    @ObservedObject var tableData:TestData = TestData(data: [testContent(title: "心理健康量表1", abstract: "心理健康量表简介心理健康量表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简", admin: "admin", date: "2022.4.26 15:00"),testContent(title: "心理健康量表2", abstract: "心理健康量表简介心理健康量表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简", admin: "admin", date: "2022.4.26 15:00"),testContent(title: "心理健康量表3", abstract: "心理健康量表简介心理健康量表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简表简介心理健康量表简", admin: "admin", date: "2022.4.26 15:00")])
    
    var body: some View {
        
        ScrollView(.vertical,showsIndicators: true){
            VStack(){
                ForEach(self.tableData.testContentList){item in
                    testItem(index: item.id)
                        .environmentObject(self.tableData)
                        .padding(.vertical, 5.0)
                        .padding(.horizontal)
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
            Text(self.tableData.testContentList[index].title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding(.leading)
            VStack(alignment: .leading,spacing: 5){
                Text("简介：")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                Text(self.tableData.testContentList[index].abstract)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .font(.system(size: 16))
                    .lineLimit(3)
            }
            HStack() {
                Image(systemName: "person").font(.system(size: 15))
                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                Text("发布人")
                    .font(.system(size: 15))
                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                Text(self.tableData.testContentList[index].admin)
                    .font(.system(size: 15))
                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
            }
            .padding(.leading)
            HStack(){
                Image(systemName: "clock").font(.system(size: 15))
                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                Text("发布时间").font(.system(size: 15))
                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
                Text(self.tableData.testContentList[index].date).font(.system(size: 15))
                    .foregroundColor(Color(.sRGB, red:90/255, green: 90/255, blue: 90/255))
            }
            .padding([.leading, .bottom])
        }
        .cornerRadius(20)
        .background(Rectangle()
                        .foregroundColor(Color(.sRGB, red: 210/255, green: 228/255, blue: 249/255)))
                        .cornerRadius(20)
                        .shadow(radius: 5,y:5)
                        
    }
        
    
}

struct TestMainView_Previews: PreviewProvider {
    static var previews: some View {
        TestMainView()
    }
}
