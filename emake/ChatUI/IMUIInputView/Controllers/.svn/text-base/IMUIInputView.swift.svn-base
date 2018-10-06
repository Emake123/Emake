//
//  IMUIInputView.swift
//  IMUIChat
//
//  Created by oshumini on 2017/2/28.
//  Copyright © 2017年 HXHG. All rights reserved.
//

import UIKit
import Photos
//输入状态（文字，语音，图片,视频，表情，不输入）
enum IMUIInputStatus {
  case text
  case microphone
  case photo
  case camera
  case emoji
  case none
}
//三个尺寸？？？
fileprivate var IMUIFeatureViewHeight:CGFloat = 215
fileprivate var IMUIFeatureSelectorHeight:CGFloat = 46
fileprivate var IMUIShowFeatureViewAnimationDuration = 0.25

open class IMUIInputView: UIView {
  
  var inputViewStatus: IMUIInputStatus = .none
  open weak var inputViewDelegate: IMUIInputViewDelegate? {
    didSet {
      self.featureView.inputViewDelegate = self.inputViewDelegate
    }
  }
  @IBOutlet var view: UIView!
  
  @IBOutlet weak var moreViewHeight: NSLayoutConstraint!
  
  @IBOutlet weak var inputTextViewHeight: NSLayoutConstraint!
  
  @IBOutlet weak var featureSelectorView: IMUIFeatureListView!
  @IBOutlet open weak var featureView: IMUIFeatureView!
  @IBOutlet weak var inputTextView: UITextView!
  @IBOutlet weak var micBtn: UIButton!
  @IBOutlet weak var photoBtn: UIButton!
  @IBOutlet weak var cameraBtn: UIButton!
  @IBOutlet weak var sendBtn: UIButton!
  @IBOutlet weak var sendNumberLabel: UILabel!
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    let bundle = Bundle.imuiInputViewBundle()
    view = bundle.loadNibNamed("IMUIInputView", owner: self, options: nil)?.first as! UIView
    
    self.addSubview(view)
    view.frame = self.bounds
    
    inputTextView.textContainer.lineBreakMode = .byWordWrapping
    inputTextView.delegate = self
    inputTextView.returnKeyType = .done
    self.featureView.delegate = self
  }
  
  open override func awakeFromNib() {
    super.awakeFromNib()
    //监听键盘
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(self.keyboardFrameChanged(_:)),
                                           name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                           object: nil)
    //发送个数属性设置
    self.sendNumberLabel.isHidden = true
    self.sendNumberLabel.layer.masksToBounds = true
    self.sendNumberLabel.layer.cornerRadius = self.sendNumberLabel.imui_width/2
    self.sendNumberLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
    self.sendNumberLabel.layer.shadowRadius = 5
    self.sendNumberLabel.layer.shadowOpacity = 0.5
  }
  //initWithCoder  -> awakeFromNib
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    let bundle = Bundle.imuiInputViewBundle()
    view = bundle.loadNibNamed("IMUIInputView", owner: self, options: nil)?.first as! UIView
    
    self.addSubview(view)
    view.frame = self.bounds
    
    inputTextView.textContainer.lineBreakMode = .byWordWrapping
    inputTextView.delegate = self
    self.featureView.delegate = self
    self.featureSelectorView.delegate = self
  }
  //取消发送图片模式
  func leaveGalleryMode() {
    //清除选择的图片
    featureView.clearAllSelectedGallery()
    //更新发送状态
    self.updateSendBtnToPhotoSendStatus()
  }
  
  func keyboardFrameChanged(_ notification: Notification) {
    //获取键盘信息
    let dic = NSDictionary(dictionary: (notification as NSNotification).userInfo!)
    let keyboardValue = dic.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
    let bottomDistance = UIScreen.main.bounds.size.height - keyboardValue.cgRectValue.origin.y
    let duration = Double(dic.object(forKey: UIKeyboardAnimationDurationUserInfoKey) as! NSNumber)
    //动画
    UIView.animate(withDuration: duration) {
    if bottomDistance > 10.0 {
      IMUIFeatureViewHeight = bottomDistance
        //响应代理方法
      self.inputViewDelegate?.keyBoardWillShow?(height: keyboardValue.cgRectValue.size.height, durationTime: duration)
      self.moreViewHeight.constant = IMUIFeatureViewHeight
    }
        //对layout属性进行调整，调用刷新界面
      self.superview?.layoutIfNeeded()
    }
  }
  //文字自适应的TextView
  func fitTextViewSize(_ textView: UITextView) {
    //计算文字适应高度
      let textViewFitSize = textView.sizeThatFits(CGSize(width: self.view.imui_width, height: CGFloat(MAXFLOAT)))
        //设置高度
      self.inputTextViewHeight.constant = textViewFitSize.height
    }
    //展示FeatureView
  open func showFeatureView() {
    UIView.animate(withDuration: IMUIShowFeatureViewAnimationDuration) {
      self.moreViewHeight.constant = 253
      self.superview?.layoutIfNeeded()
    }
  }
  //隐藏FeatureView
  open func hideFeatureView() {
    UIView.animate(withDuration: IMUIShowFeatureViewAnimationDuration) { 
      self.moreViewHeight.constant = 0
      self.inputTextView.resignFirstResponder()
      self.superview?.layoutIfNeeded()
    }
  }
  //释放资源
  deinit {
    self.featureView.clearAllSelectedGallery()
    NotificationCenter.default.removeObserver(self)
  }
}

// MARK: - UITextViewDelegate
extension IMUIInputView: UITextViewDelegate {
  public func textViewDidChange(_ textView: UITextView) {
    //输入计算文字高度
    self.fitTextViewSize(textView)
    //更新
    self.updateSendBtnToPhotoSendStatus()
  }
  //开始编辑文字
  public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    inputViewStatus = .text
    return true
  }
}
//选择相应功能回调
extension IMUIInputView: IMUIFeatureListDelegate {
  public func onSelectedFeature(with cell: IMUIFeatureListIconCell) {
    switch cell.featureData!.featureType {
    case .voice:
      self.clickMicBtn(cell: cell)
      break
    case .gallery:
      self.clickPhotoBtn(cell: cell)
      break
    case .camera:
      self.clickCameraBtn(cell: cell)
      break
    case .emoji:
      self.clickEmojiBtn(cell: cell)
      break
    default:
      break
    }
  }
  //点击发送
  public func onClickSend(with cell: IMUIFeatureListIconCell) {
    self.clickSendBtn(cell: cell)
  }
  
//点击麦克风
  func clickMicBtn(cell: IMUIFeatureListIconCell) {
    //离开发送图片模式
    self.leaveGalleryMode()
    //设置发送模式为麦克风
    inputViewStatus = .microphone
    //移除键盘
    self.inputTextView.resignFirstResponder()
    //切换到语音调用代理
    self.inputViewDelegate?.switchToMicrophoneMode?(recordVoiceBtn: cell.featureIconBtn)
    //创建“inputview”串行队列
    let serialQueue = DispatchQueue(label: "inputview")
    serialQueue.async {
        //休眠10000s
      usleep(10000)
        
      DispatchQueue.main.async {
        //展示语音界面
        self.featureView.layoutFeature(with: .voice)
        self.showFeatureView()
      }
    }
  }
  
  func clickPhotoBtn(cell: IMUIFeatureListIconCell) {
    self.leaveGalleryMode()
    inputViewStatus = .photo
    
    inputTextView.resignFirstResponder()
    inputViewDelegate?.switchToGalleryMode?(photoBtn: cell.featureIconBtn)
    DispatchQueue.main.async {
      self.featureView.layoutFeature(with: .gallery)
    }
    self.showFeatureView()
  }
  
  func clickCameraBtn(cell: IMUIFeatureListIconCell) {
    self.leaveGalleryMode()
    inputViewStatus = .camera
    
    inputTextView.resignFirstResponder()
    inputViewDelegate?.switchToCameraMode?(cameraBtn: cell.featureIconBtn)
    DispatchQueue.main.async {
      self.featureView.layoutFeature(with: .camera)
    }
    self.showFeatureView()
  }
  //点击表情
  func clickEmojiBtn(cell: IMUIFeatureListIconCell) {
    self.leaveGalleryMode()
    inputViewStatus = .emoji
    
    inputTextView.resignFirstResponder()
    inputViewDelegate?.switchToEmojiMode?(cameraBtn: cell.featureIconBtn)
    
    DispatchQueue.main.async {
      self.featureView.layoutFeature(with: .emoji)
    }
    self.showFeatureView()
  }
  //点击发送
  func clickSendBtn(cell: IMUIFeatureListIconCell) {
    //发送图片
    if IMUIGalleryDataManager.selectedAssets.count > 0 {
      self.inputViewDelegate?.didSeletedGallery?(AssetArr: IMUIGalleryDataManager.selectedAssets)
      self.featureView.clearAllSelectedGallery()
      self.updateSendBtnToPhotoSendStatus()
      return
    }
    //发送文字
    if inputTextView.text != "" {
      inputViewDelegate?.sendTextMessage?(self.inputTextView.text)
      inputTextView.text = ""
    inputTextView.returnKeyType = UIReturnKeyType.done
      fitTextViewSize(inputTextView)
    }
    self.updateSendBtnToPhotoSendStatus()
  }
}

extension IMUIInputView: IMUIFeatureViewDelegate {
    
  public func didChangeSelectedGallery(with gallerys: [PHAsset]) {
      self.updateSendBtnToPhotoSendStatus()
  }
  
  public func updateSendBtnToPhotoSendStatus() {
    var isAllowToSend = false
    let seletedPhotoCount = IMUIGalleryDataManager.selectedAssets.count
    if seletedPhotoCount > 0 {
      isAllowToSend = true
    }
    
    if inputTextView.text != "" {
      isAllowToSend = true
    }
    //更新发送图片个数
    self.featureSelectorView.updateSendButton(with: seletedPhotoCount, isAllowToSend: isAllowToSend)
  }
  //选择图片
  public func didSelectPhoto(with images: [UIImage]) {
    //更新
    self.updateSendBtnToPhotoSendStatus()
  }
  //选择表情包
  public func didSeletedEmoji(with emoji: IMUIEmojiModel) {
    switch emoji.emojiType {
    case .emoji:
      self.inputTextView.text.append(emoji.emoji!)
      self.fitTextViewSize(self.inputTextView)
      self.updateSendBtnToPhotoSendStatus()
    default:
      return
    }
  }
    
    //录音开始
    public func startRecordVoice() {
        self.inputViewDelegate?.startRecordVoice!()
    }
    //录音结束
  public func didRecordVoice(with voicePath: String, durationTime: Double) {
    self.inputViewDelegate?.finishRecordVoice?(voicePath, durationTime: durationTime)
  }
  //图片拍摄结束
  public func didShotPicture(with image: Data) {
    self.inputViewDelegate?.didShootPicture?(picture: image)
  }
  //视频录制结束
  public func didRecordVideo(with videoPath: String, durationTime: Double) {
    self.inputViewDelegate?.finishRecordVideo?(videoPath: videoPath, durationTime: durationTime)
  }
}
