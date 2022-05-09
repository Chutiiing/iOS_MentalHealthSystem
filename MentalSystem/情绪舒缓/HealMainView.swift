//
//  HealMainView.swift
//  MentalSystem
//
//  Created by 林楚婷 on 2022/4/29.
//

import SwiftUI
import AVKit

struct HealMainView: View {
    var body: some View {
        MusicPlayer()
    }
}

struct MusicPlayer:View{
    
    @State var title = ""
    @State var player:AVAudioPlayer!    //音频播放器
    @State var playing = false          //是否正在播放
    @State var width : CGFloat = 0      //进度条宽度
    @State var songs = ["music1","music2","music3"]
    @State var current = 0
    @State var finish = false            //是否结束播放
    @State var del = AVdelegate()
    
    var body: some View{
        VStack(spacing:30) {
            //背景
            Image("森林")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.size.width - 30)
            //歌曲名字
            Text(self.title)
                .font(.title)
            //进度条
            ZStack(alignment:.leading){
                Capsule()
                    .fill(Color.black.opacity(0.08))
                    .frame(height:8)
                Capsule()
                    .fill(Color(.sRGB, red: 133/255, green: 175/255, blue: 225/255))
                    .frame(width:self.width,height:8)
                    //滑动进度条手势
                    .gesture(DragGesture()
                                .onChanged({ (value) in
                        let x = value.location.x
                        self.width = x
                        
                    }).onEnded({ (value) in
                        let x = value.location.x
                        let screen = UIScreen.main.bounds.width - 30
                        let percent = x / screen
                        self.player.currentTime = Double(percent) * self.player.duration
                    }))
            }
            //按钮
            HStack(spacing:UIScreen.main.bounds.width / 5 - 45){
                
                //上一首
                Button(action:{
                    if self.current > 0 {
                        self.current -= 1
                        self.changeSongs()     //换歌曲
                    }
                }){
                    Image(systemName: "backward").font(.title)
                }
                
                //倒退15s
                Button(action:{
                    //-15
                    let decrease = self.player.currentTime - 15
                    
                    if decrease > 0{
                        self.player.currentTime -= 15
                    }
                    
                    self.player.currentTime -= 15
                    
                }){
                    Image(systemName: "gobackward.15").font(.title)
                }
                
                //暂停/播放
                Button(action:{
                    
                    if self.player.isPlaying{       //正在播放
                        self.player.pause()
                        self.playing = false
                    }
                    else{                          //正在暂停
                        if self.finish {
                            self.player.currentTime = 0
                            self.width = 0
                            self.finish = false
                        }
                        self.player.play()
                        self.playing = true
                    }
                    
                }){
                    Image(systemName: self.playing && !self.finish ? "pause" : "play")
                        .frame(width:50,height: 50)
                        .font(.system(size: 45))
                }
                
                //前进15s
                Button(action:{
                    //+15
                    let increase = self.player.currentTime + 15
                    
                    if increase < self.player.duration {
                        self.player.currentTime = increase
                    }
                }){
                    Image(systemName: "goforward.15").font(.title)
                }
                
                //下一首
                Button(action:{
                    if self.songs.count - 1 != self.current{
                        self.current += 1
                        self.changeSongs()    //换歌
                    }
                }){
                    Image(systemName: "forward").font(.title)
                }
            }
            .foregroundColor(.black)
        }
        .padding(.horizontal,15)
        .onAppear{
            //定义路径
            let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")!
            self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
            
            //设置代理
            self.player.delegate = self.del
            
            //准备播放
            self.player.prepareToPlay()
            //获取数据（标题）
            self.getData()
            
            //动态进度条
            //self.player.currentTime：当前时间
            //self.player.duration：总时间
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (_) in
                if self.player.isPlaying{
                    let screen = UIScreen.main.bounds.width - 30
                    let value = self.player.currentTime / self.player.duration
                    self.width = screen * CGFloat(value)
                }
                
            }
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Finish"), object: nil, queue: .main){ (_) in
                
                self.finish = true
                
            }
        }
        
    }
    
    //获取数据
    func getData(){
        
        let asset = AVAsset(url: self.player.url!)
        
        //选取歌曲名字
        for i in asset.commonMetadata {
            if i.commonKey?.rawValue == "title"{
                let title = i.value as! String
                self.title = title
            }
        }
    }
    
    //改变歌曲
    func changeSongs(){
        //定义路径
        let url = Bundle.main.path(forResource: self.songs[self.current], ofType: "mp3")!
        self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
        
        //设置代理
        self.player.delegate = self.del
        
        self.title = ""
        
        //准备播放
        self.player.prepareToPlay()
        //获取数据（标题）
        self.getData()
        
        //正在播放
        self.playing = true
        
        //没结束播放
        self.finish = false
        
        //进度条重置
        self.width = 0
        
        self.player.play()
    }
}

//结束播放代理
class AVdelegate :  NSObject,AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("Finish"), object: nil)
    }
}


struct HealMainView_Previews: PreviewProvider {
    static var previews: some View {
        HealMainView()
    }
}
