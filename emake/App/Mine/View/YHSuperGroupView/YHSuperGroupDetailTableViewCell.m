//
//  YHSuperGroupDetailTableViewCell.m
//  emake
//
//  Created by zhangshichao on 2018/9/14.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHSuperGroupDetailTableViewCell.h"
@interface YHSuperGroupDetailTableViewCell()
@property(nonatomic,strong)UILabel *peopleGroupNumberLable;
@property(nonatomic,strong)UILabel *freightPrice;
@property(nonatomic,strong)UILabel *lable;
@property(nonatomic,strong)UILabel *dateComit;
@property(nonatomic,strong)UILabel *peoplpeMissNumberLable;
@property(nonatomic,strong)UILabel *orderLimited;
@property(nonatomic,strong)UILabel *joinState;
@property(nonatomic,assign)NSInteger totalSeconds;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation YHSuperGroupDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UIView *bgview = [[UIView alloc] init];
        bgview.backgroundColor = ColorWithHexString(@"F2F2F2");
        bgview.layer.cornerRadius = HeightRate(24);
        bgview.layer.borderColor = ColorWithHexString(@"F8695D").CGColor;
        bgview.layer.borderWidth= 1;
        bgview.clipsToBounds= YES;
        [self addSubview:bgview];
        bgview.tag=500;
        [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(WidthRate(353));
            make.top.mas_equalTo(WidthRate(10));
            make.height.mas_equalTo(HeightRate(48));
//            make.bottom.mas_equalTo(WidthRate(10));
            make.centerY.mas_equalTo(self.mas_centerY).offset(HeightRate(0));
            make.centerX.mas_equalTo(self.mas_centerX).offset(HeightRate(0));
        }];
        
        UILabel *prouctExplainLine = [[UILabel alloc] init];
        prouctExplainLine.backgroundColor = ColorWithHexString(@"F8695D");
        prouctExplainLine.layer.cornerRadius = HeightRate(22);
        prouctExplainLine.text = @"5人团";
        prouctExplainLine.textAlignment = NSTextAlignmentCenter;
        prouctExplainLine.textColor = ColorWithHexString(@"ffffff");
        prouctExplainLine.font = [UIFont systemFontOfSize:AdaptFont(12)];
        prouctExplainLine.clipsToBounds = YES;
        [bgview addSubview:prouctExplainLine];
        [prouctExplainLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(HeightRate(44));
            make.left.mas_equalTo(WidthRate(2));
            make.centerY.mas_equalTo(bgview.mas_centerY).offset(HeightRate(0));
            make.height.mas_equalTo(HeightRate(44));
        }];
        self.peopleGroupNumberLable = prouctExplainLine;
        
        
       
        
        
        
        UILabel *freightPrice = [[UILabel alloc]init];
        freightPrice.text =@"¥30000 ";
        freightPrice.textColor = ColorWithHexString(@"333333");
        freightPrice.font = [UIFont systemFontOfSize:AdaptFont(18)];
        [bgview addSubview:freightPrice];
        [freightPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(prouctExplainLine.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(HeightRate(0));
            make.height.mas_equalTo(HeightRate(27));

        }];
        self.freightPrice = freightPrice ;
        
        UILabel *dateComit = [[UILabel alloc]init];
        dateComit.text =@"交期：2018-09-21";
        dateComit.textColor = ColorWithHexString(@"333333");
        dateComit.font = [UIFont systemFontOfSize:AdaptFont(10)];
        [bgview addSubview:dateComit];
        [dateComit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(freightPrice.mas_right).offset(WidthRate(5));
            make.centerY.mas_equalTo(freightPrice.mas_centerY).offset(HeightRate(0));
        }];
        self.dateComit = dateComit;

        UILabel *productCap = [[UILabel alloc]init];
        productCap.text =@"还差2人拼成";
        productCap.textColor = ColorWithHexString(@"F8695D");
        productCap.font = [UIFont systemFontOfSize:AdaptFont(10)];
        [bgview addSubview:productCap];
        [productCap mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(prouctExplainLine.mas_right).offset(WidthRate(10));
            make.top.mas_equalTo(freightPrice.mas_bottom).offset(0);
            make.height.mas_equalTo(HeightRate(21));

        }];
        self.peoplpeMissNumberLable = productCap;
        
        UILabel *dateEnd = [[UILabel alloc]init];
        dateEnd.text =@"还剩12:12:45";
        dateEnd.textColor = ColorWithHexString(@"999999");
        dateEnd.font = [UIFont systemFontOfSize:AdaptFont(10)];
        [bgview addSubview:dateEnd];
        [dateEnd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(productCap.mas_right).offset(WidthRate(5));
            make.centerY.mas_equalTo(productCap.mas_centerY).offset(HeightRate(0));
        }];
        self.dateEnd = dateEnd;
       
        UIView *joinView = [[UIView alloc] init];
        joinView.backgroundColor  = ColorWithHexString(@"F8695D");
        [bgview addSubview:joinView];
        [joinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bgview.mas_centerY).offset(WidthRate(0));
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(WidthRate(94));
            make.height.mas_equalTo(HeightRate(48));
            
        }];
        self.joinview = joinView;
        
        UILabel *joinState = [[UILabel alloc]init];
        joinState.text =@"";
        joinState.textColor = ColorWithHexString(@"ffffff");
        joinState.font = [UIFont systemFontOfSize:AdaptFont(15)];
        [joinView addSubview:joinState];
        [joinState mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HeightRate(5));
            make.centerX.mas_equalTo(joinView.mas_centerX).offset(WidthRate(0));
        }];
        self.joinState = joinState;
        
        UILabel *orderLimit = [[UILabel alloc]init];
        orderLimit.text =@"每人订购：1200件";
        orderLimit.textColor = ColorWithHexString(@"FFCC66");
        orderLimit.font = [UIFont systemFontOfSize:AdaptFont(9)];
        [joinView addSubview:orderLimit];
        [orderLimit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(joinState.mas_bottom).offset(HeightRate(3));
            make.centerX.mas_equalTo(joinView.mas_centerX).offset(WidthRate(0));
        }];
        self.orderLimited = orderLimit;
        
        
        
    }
    return self;
}

-(void)setRequestData:(YHSuperGroupInfoModel *)model isShowDate:(BOOL)isShowDate
{
    if (isShowDate ==false) {
        self.peopleGroupNumberLable.text = [NSString stringWithFormat:@"%@人团",model.PeopleNumber];
        self.peoplpeMissNumberLable.text = [NSString stringWithFormat:@"还差%ld人拼成",(model.PeopleNumber.integerValue-model.PeopleReadyNumber.integerValue)];
        self.freightPrice.text = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:model.GroupPrice.doubleValue]];
        self.orderLimited.text =[NSString stringWithFormat:@"每人订购：%@件",model.SetNum];
        self.joinState.text = @"立即拼团";
        self.dateEnd.hidden = YES;
        self.dateComit.hidden = YES;
    }else
    {
        self.dateEnd.hidden = false;
        self.dateComit.hidden = false;
        
        self.peopleGroupNumberLable.text = [NSString stringWithFormat:@"%@人团",model.PeopleNumber];
        self.peoplpeMissNumberLable.text = [NSString stringWithFormat:@"还差%ld人拼成",(model.PeopleNumber.integerValue-model.PeopleReadyNumber.integerValue)];
        self.freightPrice.text = [NSString stringWithFormat:@"¥%@",[Tools getHaveNum:model.GroupPrice.doubleValue]];
        self.orderLimited.text =[NSString stringWithFormat:@"每人订购：%@件",model.SetNum];
        self.dateComit.text = [NSString stringWithFormat:@"交货期：%@",model.DeliveryDate];
//        self.dateEnd.text = [NSString stringWithFormat:@"还剩%@天 %@",model.Day,model.Hour];
//        NSArray *hourStrArr = [model.Hour componentsSeparatedByString:@":"];
//        NSString *hourStr =[hourStrArr co];
        NSString *hourStr = [model.Hour stringByReplacingOccurrencesOfString:@":" withString:@""];
        self.joinState.text = model.IsSuccess.integerValue==1?@"拼团成功":((model.Day.integerValue==0&&hourStr.integerValue==0)?@"拼团结束":@"立即拼团");
        if ([self.joinState.text isEqualToString:@"拼团结束"]) {
            self.joinview.backgroundColor = ColorWithHexString(@"CCCCCC");
            self.orderLimited.textColor = ColorWithHexString(@"ffffff");
            self.joinview.userInteractionEnabled = false;
        }else{
            self.joinview.userInteractionEnabled = !model.IsSuccess.boolValue;

            self.joinview.backgroundColor  = ColorWithHexString(@"F8695D");
            self.orderLimited.textColor = ColorWithHexString(@"FFCC66");

        }
//        NSString * totalTime= @"11";
//        self.totalSeconds = totalTime.integerValue;
//        self.dateEnd.text = [self timeChangeWithSeconds:self.totalSeconds];
//        if (!_timer) {
//            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
//            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
//        }
    }
 
}

- (void)timeChange {
    self.totalSeconds --;
    if (self.totalSeconds < 0) {
        self.dateEnd.text = @"倒计时结束";
        return;
    }
    self.dateEnd.text = [self timeChangeWithSeconds:self.totalSeconds];
}

- (NSString*)timeChangeWithSeconds:(NSInteger)seconds {
    NSInteger temp1 = seconds/60;
    NSInteger temp2 = temp1/ 60;
    NSInteger d = temp2 / 24;
    NSInteger h = temp2 % 24;
    NSInteger m = temp1 % 60;
    NSInteger s = seconds %60;
    NSString * hour = h< 9 ? [NSString stringWithFormat:@"0%ld",(long)h] :[NSString stringWithFormat:@"%ld",(long)h];
    NSString *day = d < 9 ? [NSString stringWithFormat:@"0%ld",(long)d] : [NSString stringWithFormat:@"%ld",(long)d];
    NSString *minite = m < 9 ? [NSString stringWithFormat:@"0%ld",(long)m] : [NSString stringWithFormat:@"%ld",(long)m];
    NSString *second = s < 9 ? [NSString stringWithFormat:@"0%ld",(long)s] : [NSString stringWithFormat:@"%ld",(long)s];
    return [NSString stringWithFormat:@"%@天:%@时:%@分:%@秒",day,hour,minite,second];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
