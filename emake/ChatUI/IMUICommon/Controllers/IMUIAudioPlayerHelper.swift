//
//  IMUIAudioPlayerHelper.swift
//  IMUIChat
//
//  Created by oshumini on 2017/3/9.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit
import AVFoundation
//音频播放代理方法（开始，暂停，结束）
public protocol IMUIAudioPlayerDelegate:NSObjectProtocol {
  func didAudioPlayerBeginPlay(_ AudioPlayer:AVAudioPlayer)
  func didAudioPlayerStopPlay(_ AudioPlayer:AVAudioPlayer)
  func didAudioPlayerPausePlay(_ AudioPlayer:AVAudioPlayer)
}

public class IMUIAudioPlayerHelper: NSObject {
  //单例
  public static let sharedInstance = IMUIAudioPlayerHelper()
  
  var player:AVAudioPlayer!
    //代理的属性用weak修饰
  weak var delegate:IMUIAudioPlayerDelegate?

  // play tick callback
    //进度回调
  public typealias ProgressCallback = (_ identify: String, _ currentTime: TimeInterval, _ duration: TimeInterval) -> ()
    //完成回调
  public typealias FinishCallback = (String) -> ()
    //停止回调
  public typealias StopCallback = (String) -> ()
  
  var playProgressCallback: ProgressCallback?
  var playFinishCallback: FinishCallback?
  var playStopCallback: StopCallback?
  
    //视图刷新
  var updater: CADisplayLink! = nil
  var identify = ""
  
  override init() {
    super.init()
    NotificationCenter.default.addObserver(self, selector: #selector(sensorStateChange), name: NSNotification.Name.UIDeviceProximityStateDidChange, object: nil)
  }
  //接触器监听
  func sensorStateChange() {
    do {
      if UIDevice.current.proximityState {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
      } else {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      }
    } catch let error as NSError {
      print("set category fail \(error)")
    }

  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  open func playAudioWithData(_ identify: String,
                              _ voiceData: Data,
                              progressCallback: @escaping ProgressCallback,
                              finishCallBack: @escaping FinishCallback,
                              stopCallBack: @escaping StopCallback) {
    self.stopAudio()
    do {
      self.identify = identify
      self.playProgressCallback = progressCallback
      self.playFinishCallback = finishCallBack
      self.playStopCallback = stopCallBack
      
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      updater = CADisplayLink(target: self, selector: #selector(self.trackAudio))
      updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
      updater.frameInterval = 1
    } catch let error as NSError {
      print("set category fail \(error)")
    }
    
    if self.player != nil {
      self.player.stop()
      self.player = nil
    }
    
    do {
      let voicePlayer:AVAudioPlayer = try AVAudioPlayer(data: voiceData)
      voicePlayer.delegate = self
      voicePlayer.play()
      self.player = voicePlayer
    } catch let error as NSError {
      print("alloc AVAudioPlayer with voice data fail with error \(error)")
    }
    
    UIDevice.current.isProximityMonitoringEnabled = true
  }
  //重置进度
  open func renewProgressCallback(_ identfy: String, progressCallback: @escaping ProgressCallback) {
    if identfy == self.identify {
      self.playProgressCallback = progressCallback
    }
  }
  
  func trackAudio() {
    self.playProgressCallback?(self.identify ,player.currentTime, player.duration)
  }
  //暂停播放
  func pausePlayingAudio() {
    self.player?.pause()
    updater.invalidate()
    
  }
  //开始播放
  func resumePlayingAudio() {
    self.player?.play()
    updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
  }
  //停止播放
  open func stopAudio() {
    self.playProgressCallback = nil
    updater?.invalidate()
    if (self.player != nil) && self.player.isPlaying {
      self.player?.stop()
    }
    
    self.playStopCallback?(self.identify)
  
    UIDevice.current.isProximityMonitoringEnabled = false
    self.delegate?.didAudioPlayerStopPlay(self.player)
  }
}


// MARK: - AVAudioPlayerDelegate
extension IMUIAudioPlayerHelper: AVAudioPlayerDelegate {
  public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    self.stopAudio()
    self.playFinishCallback?(self.identify)
  }
}
