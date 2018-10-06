//
//  IMUICameraView.swift
//  sample
//
//  Created by oshumini on 2017/9/15.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit
import Photos
import AVFoundation
//权限
private enum SessionSetupResult {
		case success
		case notAuthorized
		case configurationFailed
}

private enum LivePhotoMode {
		case on
		case off
}

@available(iOS 8.0, *)
class IMUICameraView: UIView {
  
  public typealias PathCallback = (String, Double) -> ()
  public typealias DataCallback = (Data) -> ()
  public typealias ButtonOnClickCallback = (UIButton) -> ()
  
    //录制视频回调
  public var recordVideoCallback: PathCallback?
    //拍图片回调
  public var shootPictureCallback: DataCallback?
    //全屏回调
  public var onClickFullSizeCallback: ButtonOnClickCallback?
  
  @IBOutlet var view: UIView!
  
  var isFullScreenMode = false
  
  @IBOutlet weak var switchCameraModeBtn: UIButton!
  @IBOutlet weak var cameraShotBtn: UIButton!
  @IBOutlet weak var videoRecordBtn: UIButton!
  
  @IBOutlet weak var switchCameraDeviceBtn: UIButton!
  @IBOutlet weak var resizeCameraPreviewBtn: UIButton!
  @IBOutlet weak var cameraPreviewView: IMUICameraPreviewView!
  
  var inConfiging: Bool = false
    //摄像头位置
  var currentCameraDeviceType: AVCaptureDevicePosition = .back
  
  var currentCameraDevice: AVCaptureDeviceInput?
  
  var isActivity = true


  
  open override func awakeFromNib() {
    super.awakeFromNib()
  
    self.videoRecordBtn.isHidden = true
    self.layer.masksToBounds = true
    //设置session
    cameraPreviewView.session = session
    //获取权限
    switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
    case .authorized:
      // The user has previously granted access to the camera.
      break
      
    case .notDetermined:
        //线程挂起
      sessionQueue.suspend()
      //请求权限
      AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { [unowned self] granted in
        if !granted {
          self.setupResult = .notAuthorized
        }
        //线程激活
        self.sessionQueue.resume()
      })
      
    default:
      // The user has previously denied access.
      setupResult = .notAuthorized
    }
    
    sessionQueue.async { [unowned self] in
      self.configureSession()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let bundle = Bundle.imuiInputViewBundle()
    view = bundle.loadNibNamed("IMUICameraView", owner: self, options: nil)?.first as! UIView
    self.addSubview(view)
    view.frame = self.bounds
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    let bundle = Bundle.imuiInputViewBundle()
    view = bundle.loadNibNamed("IMUICameraView", owner: self, options: nil)?.first as! UIView
    self.addSubview(view)
    view.frame = self.bounds
  }
  //配置session
  private func configureSession() {
    //权限不允许
    if setupResult != .success {
      return
    }
    //类似动画开始动画
    session.beginConfiguration()
    self.inConfiging = true
    session.sessionPreset = AVCaptureSessionPresetPhoto
    //获取设备
    do {
      var defaultVideoDevice: AVCaptureDevice?
      
      if #available(iOS 10.0, *) {
        if let dualCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInDuoCamera, mediaType: AVMediaTypeVideo, position: .back) {
          defaultVideoDevice = dualCameraDevice
          currentCameraDeviceType = .back
        }
        else if let backCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back) {
          defaultVideoDevice = backCameraDevice
          currentCameraDeviceType = .back
        }
        else if let frontCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front) {
          
          defaultVideoDevice = frontCameraDevice
          currentCameraDeviceType = .front
        }
      } else {
        
        defaultVideoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        currentCameraDeviceType = .back
      }
      //获取输入流
      let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice)
      currentCameraDevice = videoDeviceInput
        //session添加视频输入流
      if session.canAddInput(videoDeviceInput) {
        session.addInput(videoDeviceInput)
        self.videoDeviceInput = videoDeviceInput
        
        DispatchQueue.main.async {
          
          let statusBarOrientation = UIApplication.shared.statusBarOrientation
          var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
          if statusBarOrientation != .unknown {
            if let videoOrientation = statusBarOrientation.videoOrientation {
              initialVideoOrientation = videoOrientation
            }
          }
          
          self.cameraPreviewView.videoPreviewLayer.connection.videoOrientation = initialVideoOrientation
        }
      } else {
        print("Could not add video device input to the session")
        setupResult = .configurationFailed
        session.commitConfiguration()
        self.inConfiging = false
        return
      }
    } catch {
      print("Could not create video device input: \(error)")
      setupResult = .configurationFailed
      session.commitConfiguration()
      self.inConfiging = false
      return
    }
    //session添加音频输入流
    do {
      let audioDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
      let audioDeviceInput = try AVCaptureDeviceInput(device: audioDevice)
      
      if session.canAddInput(audioDeviceInput) {
        session.addInput(audioDeviceInput)
      } else {
        print("Could not add audio device input to the session")
      }
    } catch {
      print("Could not create audio device input: \(error)")
    }
    
    // configure output
    
    if #available(iOS 10.0, *) {
        //照片输出流
      self.photoOutput = AVCapturePhotoOutput()
      //session添加照片输出流
      if session.canAddOutput(self.photoOutput!) {
        session.addOutput(self.photoOutput)
        self.photoOutput?.isHighResolutionCaptureEnabled = true
        self.photoOutput?.isLivePhotoCaptureEnabled = (self.photoOutput?.isLivePhotoCaptureSupported)!
        livePhotoMode = (photoOutput?.isLivePhotoCaptureSupported)! ? .on : .off
      } else {
        print("Could not add photo output to the session")
        setupResult = .configurationFailed
        session.commitConfiguration()
        self.inConfiging = false
        return
      }
    } else {
      if session.canAddOutput(stillImageOutput) {
        session.addOutput(stillImageOutput)
      }
    }
    //session添加视频输出流
    videoFileOutput = AVCaptureMovieFileOutput()
    if session.canAddOutput(videoFileOutput) {
      session.addOutput(videoFileOutput)
      let maxDuration = CMTime(seconds: 20, preferredTimescale: 1)
      videoFileOutput?.maxRecordedDuration = maxDuration
      videoFileOutput?.minFreeDiskSpaceLimit = 1000
    }
    
    session.commitConfiguration()
    self.inConfiging = false
  }
  //激活视频
  func activateMedia() {
    isActivity = true
    sessionQueue.async {
      switch self.setupResult {
      case .success:
        //展示
        self.session.startRunning()
        self.isSessionRunning = self.session.isRunning
        
      case .notAuthorized:
        print("AVCam doesn't have permission to use the camera, please change privacy settings")
        
      case .configurationFailed:
        print("Unable to capture media")
      }
    }
    
    self.videoRecordBtn.isHidden = true
    self.videoRecordBtn.isSelected = false
    self.cameraShotBtn.isHidden = false
    self.cameraShotBtn.isSelected = false
    self.switchCameraModeBtn.isSelected = false
    isPhotoMode = true
    //    self.chooseCamera(with: .back)
  }
  //视频失活
  func inactivateMedia() {
    isActivity = false
    //停止录制
    if let videofile = videoFileOutput {
      if videofile.isRecording {
        videoFileOutput?.stopRecording()
      }
    }
    //session停止
    if !self.inConfiging {
      self.session.stopRunning()
    }
  }
  //选择照相机
  func chooseCamera(with cameraDevicePosition: AVCaptureDevicePosition) {
    // remove current camera device
    session.beginConfiguration()
    self.inConfiging = true
    session.removeInput(currentCameraDevice)
    
    // add new camera device
    
    var defaultVideoDevice: AVCaptureDevice?
    //设置摄像头位置
    if #available(iOS 10.0, *) {
      if cameraDevicePosition == .front {
        if let frontCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front) {
          defaultVideoDevice = frontCameraDevice
          currentCameraDeviceType = .front
        }
      }
      
      if cameraDevicePosition == .back {
        
        if let dualCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInDuoCamera, mediaType: AVMediaTypeVideo, position: .back) {
          if defaultVideoDevice == nil {
            defaultVideoDevice = dualCameraDevice
            currentCameraDeviceType = .back
          }
          
        } else if let backCameraDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back) {
          if defaultVideoDevice == nil {
            defaultVideoDevice = backCameraDevice
            currentCameraDeviceType = .back
          }
        }
      }
      
    } else {
      
      for device in AVCaptureDevice.devices() {
        if (device as AnyObject).hasMediaType( AVMediaTypeVideo ) {
          if (device as AnyObject).position == cameraDevicePosition {
            defaultVideoDevice = device as? AVCaptureDevice
            currentCameraDeviceType = cameraDevicePosition
          }
        }
      }
      
      if defaultVideoDevice == nil {
        defaultVideoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        currentCameraDeviceType = .back
      }
    }
    //生成视频流
    do {
      let videoDeviceInput = try AVCaptureDeviceInput(device: defaultVideoDevice)
      
      currentCameraDevice = videoDeviceInput
      //添加视频流
      if session.canAddInput(videoDeviceInput) {
        session.addInput(videoDeviceInput)
        session.commitConfiguration()
        self.inConfiging = false
        self.videoDeviceInput = videoDeviceInput
        
        DispatchQueue.main.async {
          
          let statusBarOrientation = UIApplication.shared.statusBarOrientation
          var initialVideoOrientation: AVCaptureVideoOrientation = .portrait
          if statusBarOrientation != .unknown {
            if let videoOrientation = statusBarOrientation.videoOrientation {
              initialVideoOrientation = videoOrientation
            }
          }
          
          self.cameraPreviewView.videoPreviewLayer.connection.videoOrientation = initialVideoOrientation
          
        }
      } else {
        print("Could not add video device input to the session")
        setupResult = .configurationFailed
        session.commitConfiguration()
        self.inConfiging = false
        return
      }
    } catch {
      print("add camera device fail")
      setupResult = .configurationFailed
      session.commitConfiguration()
      self.inConfiging = false
    }
  }
  //代理？
  private var _inProgressPhotoCaptureDelegates: Any?
  @available(iOS 10.0, *)
  var inProgressPhotoCaptureDelegates: [Int64 : IMUIPhotoCaptureDelegate] {
    get {
      if _inProgressPhotoCaptureDelegates == nil {
        _inProgressPhotoCaptureDelegates = [Int64 : IMUIPhotoCaptureDelegate]()
      }
      return _inProgressPhotoCaptureDelegates as! [Int64 : IMUIPhotoCaptureDelegate]
    }
    set {
      _inProgressPhotoCaptureDelegates = newValue
    }
  }
  
  private var inProgressLivePhotoCapturesCount = 0
  
  private var isPhotoMode: Bool = true {
    didSet {
      self.switchCameraModeBtn.isSelected = !isPhotoMode
      self.cameraShotBtn.isSelected = !isPhotoMode
    }
  }
  //图片输出
  private let stillImageOutput = AVCaptureStillImageOutput()
  private let session = AVCaptureSession()
  private var setupResult: SessionSetupResult = .success
  //视频文件输出
  var videoFileOutput: AVCaptureMovieFileOutput?
  
  // OutPut
  private var _photoOutput: Any?
  @available(iOS 10.0, *)
  var photoOutput: AVCapturePhotoOutput? {
    get {
      return _photoOutput as? AVCapturePhotoOutput
    }
    set {
      _photoOutput = newValue
    }
  }
  //视频输入
  var videoDeviceInput: AVCaptureDeviceInput!
  private var livePhotoMode: LivePhotoMode = .off
  var backgroundRecordingID: UIBackgroundTaskIdentifier? = nil
  
  private var isSessionRunning = false
  private var sessionRunningObserveContext = 0
    //线程
  private let sessionQueue = DispatchQueue(label: "session queue", attributes: [], target: nil) // Communicate with the session and other session objects on this
  
  
  // -MARK: Click Event
  @IBAction func clickCameraSwitch(_ sender: Any) {
    //拍照
    if isPhotoMode {
        
       if #available(iOS 10.0, *) {
        self.capturePhotoAfter_iOS10()
        } else {
         self.capturePhotoBefore_iOS8()
        }
        
    } else {//录像
      
      if !(videoFileOutput!.isRecording) {
        
        let outputPath = self.getPath()
        let fileManager = FileManager()
        if fileManager.fileExists(atPath: outputPath) {
          do {
            try fileManager.removeItem(at: URL(fileURLWithPath: outputPath))
          } catch {
            print("removefile fail")
          }
          
        }
        session.beginConfiguration()
        self.inConfiging = true
        session.sessionPreset = AVCaptureSessionPreset352x288
        session.commitConfiguration()
        self.inConfiging = false
        videoFileOutput?.startRecording(toOutputFileURL: URL(fileURLWithPath: outputPath), recordingDelegate: self)
      } else {
        videoFileOutput?.stopRecording()
      }
    }
    
  }
  //开始或停止录制
  @IBAction func clickVideoRecordSwitch(_ sender: Any) {
    videoRecordBtn.isSelected = !videoRecordBtn.isSelected
    
    if !(videoFileOutput!.isRecording) {
      
      let outputPath = self.getPath()
      let fileManager = FileManager()
      if fileManager.fileExists(atPath: outputPath) {
        do {
          try fileManager.removeItem(at: URL(fileURLWithPath: outputPath))
        } catch {
          print("removefile fail")
        }
        
      }
      session.beginConfiguration()
      self.inConfiging = true
      session.sessionPreset = AVCaptureSessionPreset352x288
      session.commitConfiguration()
      self.inConfiging = false
      videoFileOutput?.startRecording(toOutputFileURL: URL(fileURLWithPath: outputPath), recordingDelegate: self)
    } else {
      videoFileOutput?.stopRecording()
    }
    
  }
  //切换摄像头
  @IBAction func clickToSwitchCamera(_ sender: Any) {
    switch currentCameraDeviceType {
    case .back:
      self.chooseCamera(with: .front)
      break
    default:
      self.chooseCamera(with: .back)
      break
    }
    
  }
  //拍照 or 录像
  @IBAction func clickToChangeCameraMode(_ sender: Any) {
    
    isPhotoMode = !isPhotoMode
    if isPhotoMode {
      session.sessionPreset = AVCaptureSessionPresetPhoto
      videoRecordBtn.isHidden = true
      cameraShotBtn.isHidden = false
    } else {
      session.sessionPreset = AVCaptureSessionPreset352x288
      videoRecordBtn.isHidden = false
      cameraShotBtn.isHidden = true
    }
  }
  //全屏模式
  @IBAction func clickToAdjustCameraViewSize(_ sender: UIButton) {
    self.onClickFullSizeCallback?(sender)
    sender.isSelected = !sender.isSelected
  }
  //晦涩难懂
  @available(iOS 10.0, *)
  func capturePhotoAfter_iOS10() {
    let videoPreviewLayerOrientation = cameraPreviewView.videoPreviewLayer.connection.videoOrientation
    
    sessionQueue.async {
      if let photoOutputConnection = self.photoOutput?.connection(withMediaType: AVMediaTypeVideo) {
        photoOutputConnection.videoOrientation = videoPreviewLayerOrientation
      }
      
      let photoSettings = AVCapturePhotoSettings()
      photoSettings.flashMode = .off
      
      photoSettings.isHighResolutionPhotoEnabled = false
      
      if photoSettings.availablePreviewPhotoPixelFormatTypes.count > 0 {
        photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String : photoSettings.availablePreviewPhotoPixelFormatTypes.first!]
      }
        
      if self.livePhotoMode == .on && (self.photoOutput?.isLivePhotoCaptureSupported)! { // Live Photo capture is not supported in movie mode.
        let livePhotoMovieFileName = NSUUID().uuidString
        let livePhotoMovieFilePath = (NSTemporaryDirectory() as NSString).appendingPathComponent((livePhotoMovieFileName as NSString).appendingPathExtension("mov")!)
        photoSettings.livePhotoMovieFileURL = URL(fileURLWithPath: livePhotoMovieFilePath)
      }
      
      let photoCaptureDelegate = IMUIPhotoCaptureDelegate(with: photoSettings, willCapturePhotoAnimation: {
        DispatchQueue.main.async { [unowned self] in
          self.cameraPreviewView.videoPreviewLayer.opacity = 0
          UIView.animate(withDuration: 0.25) { [unowned self] in
            self.cameraPreviewView.videoPreviewLayer.opacity = 1
          }
        }
      }, capturingLivePhoto: { capturing in
        self.sessionQueue.async { [unowned self] in
          if capturing {
            self.inProgressLivePhotoCapturesCount += 1
          }
          else {
            self.inProgressLivePhotoCapturesCount -= 1
          }
          
          let inProgressLivePhotoCapturesCount = self.inProgressLivePhotoCapturesCount
          DispatchQueue.main.async {
            if inProgressLivePhotoCapturesCount > 0 {
              
            }
            else if inProgressLivePhotoCapturesCount == 0 {
              
            }
              
            else {
              print("Error: In progress live photo capture count is less than 0");
            }
          }
        }
      }, completed: { [unowned self] photoCaptureDelegate in
        self.shootPictureCallback?(photoCaptureDelegate.photoData!)
        self.sessionQueue.async { [unowned self] in
          self.inProgressPhotoCaptureDelegates[photoCaptureDelegate.requestedPhotoSettings.uniqueID] = nil
        }
        }
      )
      
    self.inProgressPhotoCaptureDelegates[photoCaptureDelegate.requestedPhotoSettings.uniqueID] = photoCaptureDelegate
        if (self.photoOutput == nil)
        {
            self.photoOutput = AVCapturePhotoOutput.init()
            self.session.addOutput(self.photoOutput)

        }
      self.photoOutput?.capturePhoto(with: photoSettings, delegate: photoCaptureDelegate)
    }
  }
  
  private func capturePhotoBefore_iOS8() {
    
    stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
    var videoConnection: AVCaptureConnection? = nil
    for connection in stillImageOutput.connections as! [AVCaptureConnection] {
      for port in connection.inputPorts as! [AVCaptureInputPort]{
        if port.mediaType == AVMediaTypeVideo {
          videoConnection = connection
          break
        }
      }
      if videoConnection != nil { break }
    }
    
    print("about to request a capture from: \(stillImageOutput)")
    
    stillImageOutput.captureStillImageAsynchronously(from: videoConnection) { (imageSampleBuffer, error) in
      if imageSampleBuffer == nil {
        return
      }
      let exifAttachments = CMGetAttachment(imageSampleBuffer!, kCGImagePropertyExifDictionary, nil)
      
      if (exifAttachments != nil) {
        print("exifAttachments exit")
      } else {
        print("exifAttachments not exit")
      }
      
      let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
        //图片回调
      self.shootPictureCallback?(imageData!)
    }
  }
  //视频路径
  func getPath() -> String {
    var recorderPath:String? = nil
    let now:Date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yy-MMMM-dd"
    recorderPath = NSTemporaryDirectory()
    dateFormatter.dateFormat = "yyyy-MM-dd-hh-mm-ss"
    recorderPath?.append("\(dateFormatter.string(from: now))-video.mp4")
    return recorderPath!
  }
}
//手机录制方向
extension UIInterfaceOrientation {
  var videoOrientation: AVCaptureVideoOrientation? {
    switch self {
    case .portrait: return .portrait
    case .portraitUpsideDown: return .portraitUpsideDown
    case .landscapeLeft: return .landscapeLeft
    case .landscapeRight: return .landscapeRight
    default: return nil
    }
  }
}

//视频录制完成
extension IMUICameraView: AVCaptureFileOutputRecordingDelegate {
  func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
    if error == nil {
      if isActivity {
        //完成回调
        self.recordVideoCallback?(outputFileURL.path, captureOutput.recordedDuration.seconds)
      } else {
        let fileManager = FileManager()
        if fileManager.fileExists(atPath: outputFileURL.path) {
          do {
            try fileManager.removeItem(at: URL(fileURLWithPath: outputFileURL.path))
          } catch {
            print("removefile fail")
          }
        }
      }
    } else {
      print("record video fail")
    }
    
  }
  //开始录制视频
  func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
    
  }


}
