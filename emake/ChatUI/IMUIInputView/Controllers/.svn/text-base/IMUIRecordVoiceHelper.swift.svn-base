//
//  IMUIRecordVoiceHelper.swift
//  IMUIChat
//
//  Created by oshumini on 2017/3/9.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit
import AVFoundation


let maxRecordTime = 60.0
typealias CompletionCallBack = () -> Void
typealias TimerTickCallback = (TimeInterval, CGFloat) -> Void //  recordDuration, meter

typealias IMUIFinishRecordVoiceCallBack = () -> Data


class IMUIRecordVoiceHelper: NSObject {
                //开始录入回调
  var startRecordCallBack: CompletionCallBack?
    //时间回调
  var timerTickCallBack: TimerTickCallback?
  //录入类工具·
  var recorder: AVAudioRecorder?
    
  var recordPath: String?

  var timerFireDate: Date?
    //持续时间
  var recordDuration: TimeInterval {
    get {
        print("f1111111")
      if timerFireDate != nil {
        return Date().timeIntervalSince(timerFireDate!)
      } else {
        return 0.0
      }
    }
  }
  
    //绘制工具
  var updater: CADisplayLink! = nil
  
  override init() {
    super.init()
  }
  
  deinit {
    self.stopRecord()
    self.recordPath = nil
  }
    //重置时间
  func resetTimer() {
    self.timerFireDate = nil
    
    updater?.invalidate()
    updater = nil
  }
  //取消录音
  func cancelRecording() {
    if self.recorder == nil { return }
    
    if self.recorder?.isRecording != false {
      self.recorder?.stop()
    }
    
    self.recorder = nil
    self.resetTimer()
  }
  //取消录音
  func stopRecord() {
    self.cancelRecording()
    self.resetTimer()

  }
  //开始录音
  func startRecordingWithPath(_ path:String,
                              startRecordCompleted: @escaping CompletionCallBack,
                              timerTickCallback: @escaping TimerTickCallback) {
    
    print("Action - startRecordingWithPath:")
    self.startRecordCallBack = startRecordCompleted
    self.timerTickCallBack = timerTickCallback

    self.timerFireDate = Date()
    self.recordPath = path
    
    let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
    } catch let error as NSError {
      print("could not set session category")
      print(error.localizedDescription)
    }
    
    do {
      try audioSession.setActive(true)
    } catch let error as NSError {
      print("could not set session active")
      print(error.localizedDescription)
    }
    
//    let recordSettings:[String : AnyObject] = [
//      AVFormatIDKey: NSNumber(value: kAudioFormatAppleIMA4 as UInt32),
//      AVNumberOfChannelsKey: 1 as AnyObject,
//      AVSampleRateKey : 16000.0 as AnyObject
//    ]
    //录制设置
    let recordSettings = [
      AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
      AVSampleRateKey: 16000,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    //开始录制
    do {
      self.recorder = try AVAudioRecorder(url: URL(fileURLWithPath: self.recordPath!), settings: recordSettings)
                self.recorder!.delegate = self
      self.recorder!.isMeteringEnabled = true
        self.recorder?.record(forDuration: (TimeInterval)( maxRecordTime));
      self.recorder!.prepareToRecord()
        
        
    } catch let error as NSError {
      recorder = nil
      print(error.localizedDescription)
    }
    
    if ((self.recorder?.record()) != false) {

        
    } else {
      print("fail record")
    }
        //开始绘制
    self.updater = CADisplayLink(target: self, selector: #selector(self.trackAudio))
    updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    updater.frameInterval = 1
    
    if self.startRecordCallBack != nil {
      DispatchQueue.main.async(execute: self.startRecordCallBack!)
      
    }
  }
  //录制时间回调
  func trackAudio() {
    print("f2222222录制时间回调\(recordDuration)")
//    let isRecordEnd = self.recorder?.record(forDuration: (TimeInterval)( maxRecordTime));
//    if isRecordEnd == true
//    {
//        print("end======= ")
//        print("f33f333录制时间回调\(recordDuration)")
//
//    }else
//    {
//
//        print("f34444录制时间回调\(recordDuration)")
//        print("continue======= ")
//
//    }
    if recordDuration<5.0
    {
        
    }else
    {

        self.recorder?.stop();
    }
    self.timerTickCallBack?(recordDuration, CGFloat(maxRecordTime))
  }
  //完成录制
  open func finishRecordingCompletion() -> (voiceFilePath: String, duration: TimeInterval){

    let duration = recordDuration
    self.stopRecord()
    if let _ = recordPath {
      return (voiceFilePath: recordPath!, duration: duration)
    } else {
      return ("",0)
    }
  }
  //删除录制
  func cancelledDeleteWithCompletion() {
    self.stopRecord()
    if self.recordPath == nil { return }
    //删除文件
    let fileManager:FileManager = FileManager.default
    if fileManager.fileExists(atPath: self.recordPath!) == true {
      do {
        try fileManager.removeItem(atPath: self.recordPath!)
      } catch let error as NSError {
        print("can no to remove the voice file \(error.localizedDescription)")
      }
    } else {

    }
    
    
  }
  //播放音频
  open func playVoice(_ recordPath:String) {
    do {
      print("\(recordPath)")
      let player:AVAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: recordPath))
      player.volume = 1
      player.delegate = self
      player.numberOfLoops = -1
      player.prepareToPlay()
      player.play()
      
    } catch let error as NSError {
      print("get AVAudioPlayer is fail \(error)")
    }
  }
  
}


// MARK: - AVAudioPlayerDelegate
extension IMUIRecordVoiceHelper : AVAudioPlayerDelegate {
    //音频播放结束
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    print("finished playing \(flag)")
    
  }
  //音频解析出现错误
  func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
    if let e = error {
      print("\(e.localizedDescription)")
    }
  }
}

// MARK: - AVAudioRecorderDelegate
extension IMUIRecordVoiceHelper : AVAudioRecorderDelegate {
  
}
