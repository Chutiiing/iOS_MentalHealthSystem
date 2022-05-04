//
//  TabBarView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/29.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        styleTabBar();
    }
    
    func styleTabBar() {
        //UITabBar.appearance().isTranslucent = true;         //背景透明
        UITabBar.appearance().unselectedItemTintColor = UIColor.systemGray;  //未选中的字体颜色
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor;  //去掉边框
        UITabBar.appearance().clipsToBounds = true;
    }
    
    @State private var selectedIndex = 0;
    
    private var navigationTitle:String {
        switch self.selectedIndex {
        case 0:
            return "心理测评"
        case 1:
            return "心理健康站"
        case 2:
            return "情绪舒缓"
        case 3:
            return "个人中心"
        default:
            return ""
        }
    }
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedIndex) {
                TestMainView()
                    .tabItem {
                        Text("心理测评")
                        Image(systemName: "heart.text.square")
                    }
                    .tag(0)
                StationMainView()
                    .tabItem {
                        Text("心理健康站")
                        Image(systemName: "gyroscope")
                    }
                    .tag(1)
                HealMainView()
                    .tabItem {
                        Text("情绪舒缓")
                        Image(systemName: "moon.stars")
                    }
                    .tag(2)
                PersonMainView()
                    .tabItem {
                        Text("个人中心")
                        Image(systemName: "person")
                    }
                    .tag(3)
            }
            .accentColor(Color(.sRGB, red: 119/255, green: 185/255, blue: 230/255))
            .navigationBarTitle(navigationTitle)
        }.accentColor(Color.black)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
