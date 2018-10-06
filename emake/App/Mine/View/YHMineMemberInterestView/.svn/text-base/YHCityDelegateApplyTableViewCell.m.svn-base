//
//  YHCityDelegateApplyTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/12.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHCityDelegateApplyTableViewCell.h"

@implementation YHCityDelegateApplyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
        
        UILabel *catagoryLable = [[UILabel alloc] init];
        catagoryLable.backgroundColor = ColorWithHexString(@"ffffff");
        catagoryLable.text = @"真实姓名";
        
        [self addSubview:catagoryLable];
        catagoryLable.translatesAutoresizingMaskIntoConstraints = false;
        [catagoryLable PSSetLeft:WidthRate(18)];
        [catagoryLable PSSetCenterHorizontalAtItem:self];
        [catagoryLable PSSetHeight:HeightRate(50)];
        self.nameLable = catagoryLable;
        
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @"请输入真实姓名";
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.font = [UIFont systemFontOfSize:AdaptFont(14)];
        [self addSubview:textField];
        [textField PSSetRightAtItem:catagoryLable Length:WidthRate(10)];
        [textField PSSetSize:WidthRate(130) Height:HeightRate(30)];
        self.nameTextField = textField;
        
    

        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"输配电" forState:UIControlStateNormal];
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 6;
        button.clipsToBounds = YES;
        button.layer.borderColor = ColorWithHexString(@"E4E4E4").CGColor ;
        [button setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];
        [self addSubview:button];
        [button PSSetLeft:WidthRate(18)];
        [button PSSetCenterHorizontalAtItem:self];
        [button PSSetSize:WidthRate(100) Height:HeightRate(30)];
        self.leftButton = button;
        
        
      
        
        UIButton *button1 = [[UIButton alloc] init];
        [button1 setTitle:@"休闲食品" forState:UIControlStateNormal];
//        [button1 setTitleColor:ColorWithHexString(@"E4E4E4") forState:UIControlStateNormal];
        button1.translatesAutoresizingMaskIntoConstraints = false;
        button1.layer.borderColor = ColorWithHexString(@"E4E4E4").CGColor ;
        [button1 setTitleColor:ColorWithHexString(@"333333") forState:UIControlStateNormal];        button1.layer.borderWidth = 1;
        button1.layer.cornerRadius = 6;
        button1.clipsToBounds = YES;
        [self addSubview:button1];
        [button1 PSSetRightAtItem:button Length:WidthRate(10)];
        [button1 PSSetSize:WidthRate(100) Height:HeightRate(30)];
        self.rightButton = button1;
        
        
        UIImageView *imagedown = [[UIImageView alloc] init];
                imagedown.image = [UIImage imageNamed:@"direction_down"];
//        imagedown.image = [UIImage imageNamed:@"placehold"];
        imagedown.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:imagedown];
        [imagedown PSSetCenterHorizontalAtItem:self];
        [imagedown PSSetRight:WidthRate(17)];
        [imagedown PSSetSize:WidthRate(14) Height:HeightRate(14)];
        self.DownImageView = imagedown;
        
        
        UIButton* getCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [getCodeBtn setTitleColor:ColorWithHexString(StandardBlueColor) forState:UIControlStateNormal];
        getCodeBtn.translatesAutoresizingMaskIntoConstraints = false;
        getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self addSubview:getCodeBtn];
        [getCodeBtn PSSetCenterHorizontalAtItem:self];
        [getCodeBtn PSSetRight:WidthRate(17)];
        [getCodeBtn PSSetSize:WidthRate(103) Height:HeightRate(60)];
        self.getCodeButton = getCodeBtn;
        
        UILabel *lable2  = [[UILabel alloc] init];
        lable2.backgroundColor = ColorWithHexString(StandardBlueColor);
        lable2.translatesAutoresizingMaskIntoConstraints = false;
        [getCodeBtn addSubview:lable2];
        [lable2 PSSetBottom:0];
        [lable2 PSSetCenterX];
        [lable2 PSSetSize:WidthRate(110) Height:HeightRate(1)];
        self.lineLable = lable2;
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = SepratorLineColor;
        [self addSubview:line];
        line.translatesAutoresizingMaskIntoConstraints = false;
        [line PSSetLeft:WidthRate(16)];
        [line PSSetRight:WidthRate(16)];
        [line PSSetHeight:HeightRate(1)];
        [line PSSetBottom:0];
        
      
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
