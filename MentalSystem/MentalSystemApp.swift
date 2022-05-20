//
//  MentalSystemApp.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/28.
//

import SwiftUI

@main
struct MentalSystemApp: App {
    
    let isLogin:Int = UserDefaults.standard.integer(forKey: "isSign")
    
    var body: some Scene {
        WindowGroup {
            //判断是否登录过
            if self.isLogin == 1 {
                TabBarView()
            }
            else{
                LoginMainView()
            }
        }
    }
}
