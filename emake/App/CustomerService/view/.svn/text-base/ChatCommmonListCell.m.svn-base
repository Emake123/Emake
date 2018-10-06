//
//  ChatCommmonListCell.m
//  emake
//
//  Created by 谷伟 on 2017/8/29.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "ChatCommmonListCell.h"
#import <SVGKit/SVGKit.h>
#import "chatUserModel.h"
#import "YHStoreModel.h"
@implementation ChatCommmonListCell
- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthRate(50), WidthRate(50))];
        [self.contentView addSubview:self.headImage];
        
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(12));
            make.width.mas_equalTo(WidthRate(50));
            make.height.mas_equalTo(WidthRate(50));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        
        _labelName = [[UILabel alloc]initWithFrame:CGRectZero];
        _labelName.text = @"易智造官方客服";
        [self.contentView addSubview:_labelName];
        
        [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(9));
            make.left.mas_equalTo(WidthRate(68));
            make.height.mas_equalTo(HeightRate(32));
            make.width.mas_equalTo(WidthRate(150));
        }];
        
        _labelContent = [[UILabel alloc]initWithFrame:CGRectZero];
        _labelContent.text = @"暂无消息";
        _labelContent.font = [UIFont systemFontOfSize:12];
        _labelContent.textColor = TextColor_A3A3A3;
        [self.contentView addSubview:_labelContent];
        
        [_labelContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(_labelName.mas_bottom).offset(0);
            make.left.mas_equalTo(WidthRate(68));
            make.width.mas_equalTo(WidthRate(269));
            make.height.mas_equalTo(HeightRate(17));
            
        }];
        
        _labelTime = [[UILabel alloc]initWithFrame:CGRectZero];
        _labelTime.font = [UIFont systemFontOfSize:12];
        _labelTime.textColor = TextColor_666666;
        _labelTime.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_labelTime];
        
        [_labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(17));
            make.centerY.mas_equalTo(_labelName.mas_centerY);
        }];
        
        
        _labelMessage = [[UILabel alloc]initWithFrame:CGRectZero];
        _labelMessage.font = [UIFont systemFontOfSize:12];
        _labelMessage.backgroundColor = ColorWithHexString(SymbolTopColor);
        _labelMessage.textColor = ColorWithHexString(@"ffffff");
        _labelMessage.textAlignment = NSTextAlignmentRight;
        _labelMessage.clipsToBounds = YES;
        _labelMessage.layer.cornerRadius = HeightRate(8.5);
        [self.contentView addSubview:_labelMessage];
        _labelMessage.hidden = YES;
        _labelMessage.textAlignment = NSTextAlignmentCenter;
        [_labelMessage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(WidthRate(-10));
            make.height.mas_equalTo(HeightRate(17));
            make.width.mas_equalTo(HeightRate(17));

            make.centerY.mas_equalTo(_labelContent.mas_centerY);
        }];
        
        UILabel *labelLine = [[UILabel alloc]initWithFrame:CGRectZero];
        labelLine.backgroundColor = SepratorLineColor;
        [self.contentView addSubview:labelLine];
        [labelLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
 
    }
    return self;
}
- (void)setData:(SDChatMessage *)msg {
    NSDictionary *dict = [msg.Group mj_JSONObject];
    YHGroupModel *model = [YHGroupModel mj_objectWithKeyValues:dict];
    if ([msg.userId containsString:@"_"]) {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.GroupPhoto] placeholderImage:[SVGKImage imageNamed:@"dianpuicon_yuan"].UIImage];
        self.labelName.text = model.GroupName;
    }else{
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.GroupPhoto] placeholderImage:[UIImage imageNamed:@"guanfangkefu"]];
    }
    
    if ([msg.msgType isEqualToString:@"SEND_TEXT"]) {
        self.labelContent.text = msg.msg;
    }else if ([msg.msgType isEqualToString:@"SEND_IMAGE"]) {
        self.labelContent.text = @"[图片]";
    }else if ([msg.msgType isEqualToString:@"SEND_MutilePart"]) {
        self.labelContent.text = @"[合同]";
    }else if ([msg.msgType isEqualToString:@"SEND_Order"]) {
        self.labelContent.text = @"[订单]";
    }else if ([msg.msgType isEqualToString:@"SEND_Goods"]) {
        self.labelContent.text = @"[商品]";
    }else if ([msg.msgType isEqualToString:@"SEND_Voice"]) {
        self.labelContent.text = @"[语音]";
    }else if ([msg.msgType isEqualToString:@"SEND_File"]) {
        self.labelContent.text = @"[文件]";
    }else if ([msg.msgType isEqualToString:@"SEND_Consult"]) {
        self.labelContent.text = @"[咨询消息]";
    }
    if (msg.messageCount.integerValue>0) {
        self.labelMessage.hidden = false;
        self.labelMessage.text = [NSString stringWithFormat:@"%@",msg.messageCount];
    }else
    {
        self.labelMessage.hidden = YES;
        
    }
    self.labelTime.text = [Tools stringFromTimestamp:msg.sendTime];
}

- (void)setDataAnother:(SDChatMessage *)msg{
    self.imageView.image = [UIImage imageNamed:@"guanfangkefu"];
    if ([msg.msgType isEqualToString:@"SEND_TEXT"]) {
        self.labelContent.text = msg.msg;
    }else if ([msg.msgType isEqualToString:@"SEND_IMAGE"]) {
        self.labelContent.text = @"[图片]";
    }else if ([msg.msgType isEqualToString:@"SEND_MutilePart"]) {
        self.labelContent.text = @"[合同]";
    }else if ([msg.msgType isEqualToString:@"SEND_Order"]) {
        self.labelContent.text = @"[订单]";
    }else if ([msg.msgType isEqualToString:@"SEND_Goods"]) {
        self.labelContent.text = @"[商品]";
    }else if ([msg.msgType isEqualToString:@"SEND_Voice"]) {
        self.labelContent.text = @"[语音]";
    }else if ([msg.msgType isEqualToString:@"SEND_File"]) {
        self.labelContent.text = @"[文件]";
    }else if ([msg.msgType isEqualToString:@"SEND_Consult"]) {
        self.labelContent.text = @"[咨询消息]";
    }
    if (msg.messageCount.integerValue>0) {
        self.labelMessage.hidden = false;
        self.labelMessage.text = [NSString stringWithFormat:@"%@",msg.messageCount];
    }else
    {
        self.labelMessage.hidden = YES;

    }
    if (msg.sendTime != nil) {
        self.labelTime.text = [Tools stringFromTimestamp:msg.sendTime];
    }
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
