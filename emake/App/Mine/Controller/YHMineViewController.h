//
//  Mine.h
//  emake
//
//  Created by chenyi on 2017/7/13.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "PSVCBase.h"

@interface YHMineViewController : PSVCBase
@property (nonatomic,retain)UILabel *messageCount;
@property (nonatomic,strong)UITableView *myTableView;
-(void)refreshMesssageCount;
@end
