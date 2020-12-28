//
//  SecondViewController.swift
//  tableview
//
//  Created by Mounika Reddy on 12/11/20.
//  Copyright © 2020 Mounika Reddy. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class SecondViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var artistsLabel: UILabel!
    @IBOutlet weak var trailerView: UIView!
    @IBOutlet weak var storyLabel: UILabel!
    
        
     var songsView:UIView!
     var AVPVC:AVPlayerViewController!
     var songsData:[String] = []
     var songUrl:String!
     var audioSong = AVPlayerViewController()
     var songName:UILabel!
     var btnSong:UIButton!
     var data:MovieDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieTitleLabel.text = data.title!
        
        directorNameLabel.text = data.director!
        
        let cast = data.actors!
        artistsLabel.text = " "
        for i in 0..<cast.count{
            
            artistsLabel.text! += "\(cast[i]) \n"
            
        }
        
        
        if(data.story == nil){
            self.storyLabel.text = "Story Under Process"
        }else{
            storyLabel.text = data.story!
        }
        
        
        let trailer1 = data.trailers!
        let correctURL = "https://services.brninfotech.com/tws/"+trailer1[0].replacingOccurrences(of: " ", with: "%20")
        
        AVPVC=AVPlayerViewController()
        AVPVC.player = AVPlayer(url: URL(string: correctURL)!)
        AVPVC.view.frame = CGRect(x: 0, y: 0, width: trailerView.frame.width, height:trailerView.frame.height)
        trailerView.addSubview(AVPVC.view)
        AVPVC.player?.pause()
        
        songsView = UIView(frame: CGRect(x: 0, y: 800, width: 420, height: 600))
        scrollView.addSubview(songsView)

        
        let songsTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 420, height: 50))
             songsTitleLabel.text = "SONGS"
             songsTitleLabel.textAlignment = .left
             songsTitleLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
             songsTitleLabel.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
             
             songsView.addSubview(songsTitleLabel)
             songsData = data.songs!
             print(songsData)
             
             print(data.songs!.count,"songcount")
        
             for song in 0..<songsData.count{
                 
                 
                songName = UILabel(frame: CGRect(x: 0, y: (song*50)+60, width: 300, height: 50))
                 
                 songName.text = URL(fileURLWithPath: songsData[song]).lastPathComponent
                 
                 btnSong = UIButton(frame: CGRect(x: 325, y: (song*50)+60, width: 75, height: 40))
               
                 btnSong.setTitle("Play", for: UIControl.State.normal)
                 
                 btnSong.tag=song
                 btnSong.addTarget(self, action: #selector(songsFunc(sender:)), for: UIControl.Event.touchUpInside)
                 
                  songsView.addSubview(songName)
                  songsView.addSubview(btnSong)
                 
             }
             
         }
         
         
        @objc func songsFunc(sender:UIButton){

                     AVPVC.player!.pause()
                      songUrl = "https://services.brninfotech.com/tws/" + songsData[sender.tag].replacingOccurrences(of: " ", with: "%20")
                      audioSong.player = AVPlayer(url: URL(string: songUrl)!)
                      audioSong.view.frame = CGRect(x: 175, y: (sender.tag*50)+40, width: 250, height: 50)
                      songsView.addSubview(audioSong.view)
                      audioSong.player?.play()
                      print("songs",audioSong)
              
                                            
              }
         

        
        
    }
    
    
    
    

