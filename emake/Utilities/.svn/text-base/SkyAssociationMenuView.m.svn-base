//
//  SkyAssociationMenuView.m
//
//  Created by skytoup on 14-10-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "SkyAssociationMenuView.h"
//#import "Config.h"
NSString *const IDENTIFIER = @"CELL";

@interface SkyAssociationMenuView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    NSArray *tables;
    UIView *bgView;
    UIView *bottomView;

    NSInteger recordRowCount;
    NSIndexPath *recordIndexPath0;
    NSIndexPath *recordIndexPath1;
    NSIndexPath *recordIndexPath2;

}
@end

@implementation SkyAssociationMenuView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(false, @"cann't not use - initWithCoder:, please user - init");
    return nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化选择项
        self.sels = [[NSMutableArray alloc] initWithCapacity:3];
        self.sels[0] = @-1;
        self.sels[1] = @-1;
        self.sels[2] = @-1;
//        recordIndexPathArr = [NSMutableArray arrayWithCapacity:3];
//        NSIndexPath *indexpath;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.userInteractionEnabled = YES;
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = self.frame;
        [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        // 初始化菜单
        tables = @[[[UITableView alloc] init], [[UITableView alloc] init], [[UITableView alloc] init] ];
        [tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger idx, BOOL *stop) {
            [table registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER ];
            table.dataSource = self;
            table.delegate = self;
            table.frame = CGRectMake(0, 0, 0, 0);
            table.backgroundColor = [UIColor whiteColor];
            table.tableFooterView = [UIView new];
        }];
        bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor colorWithRed:.0f green:.0f blue:.0f alpha:.3f];
        bgView.userInteractionEnabled = YES;
        [bgView addSubview:[tables objectAtIndex:0] ];
        
    }
    return self;
}

#pragma mark private
/**
 *  调整表视图的位置、大小
 */
- (void)adjustTableViews{
    int w = ScreenWidth;
    int __block showTableCount = 0;
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        CGRect rect = t.frame;
        if (idx==0) {
            CGFloat tHight = 44*recordRowCount;
            if (tHight>ScreenHeight - bgView.frame.origin.y-45) {
                tHight = ScreenHeight - bgView.frame.origin.y-45;
            }
        }
        rect.size.height =44*recordRowCount;

        
        t.frame = rect;
        if(t.superview)
            ++showTableCount;
        if (idx==0) {
        for (int i= 0; i<2; i++) {
            
            CGFloat buttonX=ScreenWidth*i/2.0;
            CGFloat buttonY =                                                                                            44*recordRowCount;
            if (buttonY>(ScreenHeight-bgView.frame.origin.y-45)) {
                buttonY = ScreenHeight - bgView.frame.origin.y-45;
            }
            CGFloat buttonw =ScreenWidth/2.0;
            CGFloat buttonH = 45;
            UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(buttonX, buttonY, buttonw, buttonH);
            NSString *str = i?@"确认":@"重置";
            [button setTitle:str forState:UIControlStateNormal];
            button.tag=20+i;
            [button addTarget:self action:@selector(resetOrSureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            NSString *colourTitle = i?@"ffffff":@"000000";

            [button setTitleColor:ColorWithHexString(colourTitle) forState:UIControlStateNormal];
            NSString *colour = i?@"4DBECD":@"ffffff";

            button.backgroundColor = ColorWithHexString(colour);
            [bgView addSubview:button];
            UILabel *line = [[UILabel alloc] init];
            line.backgroundColor =SepratorLineColor;
            line.frame =CGRectMake(0, 0, ScreenWidth/2.0, 1);

            [button addSubview:line];
//            [bgView bringSubviewToFront:button];
        }
        }
    }];
    
    for(int i=0; i!=showTableCount; ++i){
        UITableView *t = [tables objectAtIndex:i];
        CGRect f = t.frame;
        f.size.width = w / showTableCount;
        f.origin.x = f.size.width * i;
        t.frame = f;
    }
    
}
/**
 *  重置--确认
 */
- (void)resetOrSureButtonClick:(UIButton *)button{
    if(button.tag == 20){

        if([self.delegate respondsToSelector:@selector(assciationMenuView:saveSelectedClass:class2:class3:)]) {
            [self.delegate assciationMenuView:self resetSelectedClass:[self.sels[0] integerValue] class2:[self.sels[1] integerValue] class3:[self.sels[2] integerValue]];
            
        }
        [self adjustTableViews];
            for (UITableView *table in tables) {
                [table reloadData];
            }
    }else
    {
        
        [self saveSels];
        if([self.delegate respondsToSelector:@selector(assciationMenuView:saveSelectedClass:class2:class3:)]) {
          BOOL isSave =  [self.delegate assciationMenuView:self saveSelectedClass:[self.sels[0] integerValue] class2:[self.sels[1] integerValue] class3:[self.sels[2] integerValue]];
            if (isSave ==YES) {
                [self dismiss];

            }
        }
    
    }
}
/**
 *  取消选择
 */
- (void)cancel{
    [self dismiss];
    if([self.delegate respondsToSelector:@selector(assciationMenuViewCancel)]) {
        [self.delegate assciationMenuViewCancel];
    }
}

/**
 *  保存table选中项
 */
- (void)saveSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        self.sels[idx] = t.superview ? [NSNumber numberWithLong:t.indexPathForSelectedRow.row] : @-1;
    }];
}

/**
 *  加载保存的选中项
 */
- (void)loadSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger i, BOOL *stop) {
        [t selectRowAtIndexPath:[NSIndexPath indexPathForRow:[self.sels[i] integerValue] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        if(([self.sels[i] intValue] != -1 && !t.superview) || !i) {
            [bgView addSubview:t];
        }
    }];
}

#pragma mark public
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3 {
    self.sels[0] = [NSNumber numberWithLong:idx_1];
    self.sels[1] = [NSNumber numberWithLong:idx_2];
    self.sels[2] = [NSNumber numberWithLong:idx_3];
}

- (void)showAsDrawDownView:(UIView *)view {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    CGRect showFrame = view.frame;
    showFrame = [view.superview convertRect:showFrame toView:window];
    CGFloat x = 0.f;
    CGFloat y = showFrame.origin.y+showFrame.size.height+20;
    CGFloat w = ScreenWidth;
    CGFloat h = ScreenHeight-y;
    bgView.frame = CGRectMake(x, y, w, h);
    if(!bgView.superview) {
        [self addSubview:bgView];
    }
    [self loadSels];
    [self adjustTableViews];
    if(!self.superview) {
        [window addSubview:self];
        self.alpha = .0f;
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = 1.0f;
        }];
    }
    [window bringSubviewToFront:self];
}

- (void)dismiss{
    if(self.superview) {
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = .0f;
        } completion:^(BOOL finished) {
            if([self.delegate respondsToSelector:@selector(assciationDismissMenuView:)]) {
                [self.delegate assciationDismissMenuView:self];
            }
            [bgView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            [self removeFromSuperview];
        }];
    }
}

#pragma mark UITableViewDateSourceDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    cell.textLabel.textColor = ColorWithHexString(@"000000");
    cell.textLabel.font = [UIFont systemFontOfSize:AdaptFont(12)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if(tableView == [tables objectAtIndex:0]){
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:indexPath.row];
    }else if(tableView == [tables objectAtIndex:1]){
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:indexPath.row];
    }else if(tableView == [tables objectAtIndex:2]){
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:((UITableView*)tables[1]).indexPathForSelectedRow.row class_3:indexPath.row];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger __block count;
    [tables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(obj == tableView) {
            if (idx==0) {
                count = [_delegate assciationMenuView:self countForClass:idx];
                recordRowCount  = count;
            }else{
            count = [_delegate assciationMenuView:self countForClass:idx];
            }
            *stop = YES;
        }
    }];
    return count;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITableView *t0 = [tables objectAtIndex:0];
    UITableView *t1 = [tables objectAtIndex:1];
    UITableView *t2 = [tables objectAtIndex:2];

    cell.textLabel.textColor = ColorWithHexString(@"4DBECD");

    BOOL isNexClass = true;
    if(tableView == t0){
        
         cell = [t0 cellForRowAtIndexPath:recordIndexPath0];
        cell.textLabel.textColor = ColorWithHexString(@"000000");
        recordIndexPath0 = indexPath;
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:indexPath.row];

        }
        if(isNexClass) {
            [t1 reloadData];
            if(!t1.superview) {
                [bgView addSubview:t1];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self adjustTableViews];
        }else{
            if(t1.superview) {
                [t1 removeFromSuperview];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
        }
    }else if(tableView == t1) {
         cell = [t1 cellForRowAtIndexPath:recordIndexPath1];
        cell.textLabel.textColor = ColorWithHexString(@"000000");
        recordIndexPath1 = indexPath;
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:indexPath.row];
        }
        if(isNexClass){
            [t2 reloadData];
            if(!t2.superview) {
                [bgView addSubview:t2];
            }
            [self adjustTableViews];
        }else{
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
        }
    }else if(tableView == t2) {
        cell = [t2 cellForRowAtIndexPath:recordIndexPath2];
        cell.textLabel.textColor = ColorWithHexString(@"000000");
        recordIndexPath2 = indexPath;
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:class3:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:t1.indexPathForSelectedRow.row class3:indexPath.row];
        }
        if(isNexClass) {

        }
    }
}

@end
