//
//  TestMainView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/28.
//

//心理测评主界面

import SwiftUI
import Alamofire
import SwiftyJSON

struct TestMainView: View {
    
    //量表数据
    @ObservedObject var tableData:TestData = TestData()
    
    
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
                Text(self.tableData.testContentList[index].introduction)
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
                Text(self.tableData.testContentList[index].time)
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
