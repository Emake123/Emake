//
//  NotificationViewController.m
//  JZNotic_Content
//
//  Created by 谷伟 on 2017/11/20.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>//系统通知UI
#import <AVFoundation/AVFoundation.h>//音频，视频类

@interface NotificationViewController () <UNNotificationContentExtension>

@property (weak, nonatomic) IBOutlet UIView *player_view;
@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation NotificationViewController
{
    AVPlayer *player;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    
    self.label.text = notification.request.content.body;
    UNNotificationContent * content = notification.request.content;
    UNNotificationAttachment * attachment_img = content.attachments[0];
    if (attachment_img.URL.startAccessingSecurityScopedResource) {
        self.imageView.image = [UIImage imageWithContentsOfFile:attachment_img.URL.path];
    }
    // 视频
    UNNotificationAttachment * attachment_mp4 = content.attachments[1];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:attachment_mp4.URL];
    player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = CGRectMake(0, 0, self.player_view.frame.size.width, self.player_view.frame.size.height);
    // 显示播放视频的视图层要添加到self.view的视图层上面
    [self.player_view.layer addSublayer:layer];
    //最后一步开始播放
    [player play];
    
}


@end
