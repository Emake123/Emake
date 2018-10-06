//
//  YHProductParamsView.m
//  emake
//
//  Created by 张士超 on 2017/12/5.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHProductParamsView.h"
@interface YHProductParamsView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation YHProductParamsView

-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.headerReferenceSize = CGSizeZero;
        layout.footerReferenceSize = CGSizeZero;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, ScreenHeight-(TOP_BAR_HEIGHT)) collectionViewLayout:layout];
        [collectionView setBackgroundColor:ColorWithHexString(@"F5F5F5")];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reusableView"];
        [self addSubview:collectionView];
        collectionView.delegate = self;
        collectionView.dataSource = self;
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   NSInteger count = [_delegate YHProductParamMenuView:self];

    return count ;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"" forIndexPath:indexPath];
    
    return cell;
    
}
@end
