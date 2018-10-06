//
//  YHMessageClassifyCollectionViewCell.m
//  emake
//
//  Created by 谷伟 on 2018/6/4.
//  Copyright © 2018年 emake. All rights reserved.
//

#import "YHMessageClassifyCollectionViewCell.h"
#import "YHCustomQuestionModel.h"
@interface YHMessageClassifyCollectionViewCell()<UITableViewDelegate,UITableViewDataSource >
@property (nonatomic,strong)UIView * backView;
@property (nonatomic,strong)UITableView * questionTabel;
@property (nonatomic,strong)NSMutableArray *largeArray;
@property (nonatomic,assign)NSInteger selectSection;
@property (nonatomic,assign)NSInteger selectRow;
@end

@implementation YHMessageClassifyCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backView = [[UIView alloc]init];
        self.backView.backgroundColor = [UIColor whiteColor];
        self.backView.layer.borderWidth = WidthRate(2);
        self.backView.layer.borderColor = SepratorLineColor.CGColor;
        self.backView.layer.cornerRadius = WidthRate(5);
    
        [self.contentView addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.top.mas_equalTo(HeightRate(30));
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(WidthRate(336));
        }];
        
        UILabel *lableTop = [[UILabel alloc] init];
        lableTop.text = @"亲，为了更好的为您服务，您可以选择下方的“快捷问题”，如不包含，请直接在下方输入您想要咨询的问题，小易竭诚为您服务！";
        lableTop.numberOfLines = 0;
        lableTop.font = SYSTEM_FONT(AdaptFont(13));
        [self.backView addSubview:lableTop];
        
        [lableTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(21));
            make.right.mas_equalTo(WidthRate(-13));
            make.top.mas_equalTo(HeightRate(13));
            make.height.mas_equalTo(HeightRate(54));
        }];
        
        self.questionTabel = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.questionTabel.delegate = self;
        self.questionTabel.dataSource = self;
        self.questionTabel.separatorColor = [UIColor clearColor];
        [self.backView addSubview:self.questionTabel];
        
        [self.questionTabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WidthRate(21));
            make.right.mas_equalTo(WidthRate(-13));
            make.top.mas_equalTo(lableTop.mas_bottom).offset(HeightRate(10));
            make.bottom.mas_equalTo(0);
        }];
        
    }
    return self;
}
- (void)setData:(NSString *)jsonStr{

    NSArray *array = [YHCustomQuestionModel mj_objectArrayWithKeyValuesArray:jsonStr];
    self.largeArray = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableArray *claasifyArray = [NSMutableArray arrayWithCapacity:0];
    for (YHCustomQuestionModel *model in array) {
        if (![claasifyArray containsObject:model.AdviceName]) {
            [claasifyArray addObject:model.AdviceName];
        }
    }
    for (NSString *classify in claasifyArray) {
        NSMutableArray *smallArray = [NSMutableArray arrayWithCapacity:0];
        for (YHCustomQuestionModel *model in array) {
            if ([classify isEqualToString:model.AdviceName]) {
                [smallArray addObject:model];
            }
        }
        [self.largeArray addObject:smallArray];
    }
    [self.questionTabel reloadData];
}
- (void)didTap:(UITapGestureRecognizer *)gesture{
    NSInteger section = gesture.view.tag / 10000;
    NSInteger row = gesture.view.tag - section * 10000;
    NSArray *array = self.largeArray[section];
    YHCustomQuestionModel *model = array[row];
    if ([self.delegate respondsToSelector:@selector(didTapMessageTableWith:)]) {
        [self.delegate didTapMessageTableWith:model];
    }
}
#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.largeArray[section];
    return arr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.largeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    NSArray *arr = self.largeArray[indexPath.section];
    YHCustomQuestionModel *model = arr[indexPath.row];
    cell.textLabel.text = model.QuestionTitle;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = SYSTEM_FONT(AdaptFont(13));
    cell.textLabel.textColor = RGBColor(110, 150, 240);
    cell.contentView.tag = indexPath.section * 10000 + indexPath.row;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
    [cell.contentView addGestureRecognizer:tap];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRate(30);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeightRate(30);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    UILabel *label = [[UILabel alloc]init];
    NSArray *arr = self.largeArray[section];
    YHCustomQuestionModel *model = arr[0];
    label.text = model.AdviceName;
    label.font = SYSTEM_FONT(AdaptFont(13));
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    return view;
}
@end
