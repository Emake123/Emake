//
//  YHShoppingCartNewViewController.m
//  emake
//
//  Created by 谷伟 on 2017/9/20.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHShoppingCartNewViewController.h"
#import "ShoppingCartNewCell.h"
#import "ShoppingCartHeaderCell.h"
#import "MJRefresh.h"
#import "YHShoppingCartConfirmViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "YHProductDetailsViewController.h"
#import "YHStoreDetailViewController.h"
static CGFloat const BottomViewHeight = 49.0f;

static CGFloat const BottomViewItemLabelHeight = 14.0f;

static CGFloat const SelectButtonLeftMargin = 12.0f;
static CGFloat const SelectButtonWidth = 22.0f;
static CGFloat const SelectButtonHeight = 22.0f;

static CGFloat const SelectAllLabelLeftMargin = 5.0f;

static CGFloat const LineViewHeight = 1.0f;
@interface YHShoppingCartNewViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,YHTitleViewViewDelegete>{
    
    TPKeyboardAvoidingTableView * myTableView;
    UIView *bottomView;
    UIView *headView;
    UIView *emptyView;
    NSString *recordTotalPrice;
    BOOL isEmpty;
    BOOL isEmpty1;

    UIButton *sureBtn;
    UILabel *allPrice;

}
@property (nonatomic,retain)NSMutableArray *allCartArray;
@property (nonatomic,retain)NSMutableArray *LargeCartArray;
@property (nonatomic,retain)NSMutableArray *smallCartArray;
@property (nonatomic,retain)NSMutableArray *selectRowFlag;
@property (nonatomic,retain)NSMutableArray *selectSectionFlag;
@property (nonatomic,strong)UIButton *selectButton;
@property (nonatomic,strong)UILabel *allPriceLabel;
@property (nonatomic,assign)BOOL isSelectAll;
@property (nonatomic,assign)BOOL isEditAll;
@property (nonatomic,assign)BOOL isEdited;

@property (nonatomic,assign)int recordShoppingNumber;



@property (nonatomic,assign)BOOL isInvoice;
@property (nonatomic,strong)YHTitleView * TopTitleView;
@property (nonatomic,strong)NSArray * TopTitleArray;

@property (nonatomic,assign) NSInteger recordTopBtnSelet;
@property (nonatomic,assign) BOOL isRefreshData;

@end

@implementation YHShoppingCartNewViewController
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.navigationController setNavigationBarHidden:false animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TextColor_F5F5F5;
    NSString *isStoreString = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ISSTORE];

    self.navigationItem.title = [NSString stringWithFormat: @"购物车(%ld)",(long)self.number];
    [self addRightNavBtn:@"编辑"];

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isShowLeftButton == NO) {
        self.navigationItem.leftBarButtonItem = nil;
    }
  
    self.isInvoice = 1;
    self.recordTopBtnSelet = 0;
    [MobClick event:@"ShoppingCart_B" label:@"购物车-休闲食品"];
    
    [self getShoppingCartData];

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:NO];
//    [self getTotalPrice];
}
//空购物车图
-(void)getEmptyShoppingCart
{
    if (emptyView==nil) {
        emptyView = [[UIView alloc]init];
        emptyView.bounds =CGRectMake(WidthRate(0), HeightRate(0), WidthRate(200), HeightRate(120));
        emptyView.center = self.view.center;
        [self.view addSubview:emptyView];
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"gouwuche_kongde"]];
        imageview.frame = CGRectMake(WidthRate(55), HeightRate(0), WidthRate(70), HeightRate(70));
        [emptyView addSubview:imageview];
        UILabel  *lable  = [[UILabel alloc] init];
        lable.bounds = CGRectMake(WidthRate(0), HeightRate(0), WidthRate(240), HeightRate(20));
        lable.center = CGPointMake(imageview.centerX, imageview.centerY+imageview.height/1.5 );
        lable.textAlignment = NSTextAlignmentCenter;;
        lable .textColor = ColorWithHexString(@"909090");
        lable.font = SYSTEM_FONT(13);
        [emptyView addSubview:lable];
        lable.text = @"购物车空空如也";
    }
    emptyView.hidden = false;
    
}
- (void)getShoppingCartData{
    
    _recordShoppingNumber = 0;
    [[YHJsonRequest shared] userUserShoppingFindSucceededBlock:^(NSArray *shoppingCartArray) {
        self.allCartArray  = [NSMutableArray arrayWithArray:shoppingCartArray];
        
            NSInteger IncludeInvoiceNumber = 0;
            NSInteger NotIncloudInvoiceNumber = 0;
            
            NSMutableArray  *resultArr =[NSMutableArray arrayWithCapacity:0];
            for (YHShoppingCartModel *model in shoppingCartArray) {
                if (model.IsInvoice.integerValue == self.isInvoice ) {
                    IncludeInvoiceNumber +=  model.GoodsNumber.integerValue;
                    [resultArr addObject:model];
                }else
                {
                    NotIncloudInvoiceNumber +=  model.GoodsNumber.integerValue;
                    
                }
                if (resultArr.count == 0) {
                    [self getEmptyShoppingCart];
                    self.selectButton.selected = false;
                    emptyView.hidden =false;
                    myTableView.hidden =YES;
                }else
                {
                    
                    emptyView.hidden =YES;
                    myTableView.hidden =false;
                    
                }
            }
          
            [self classifyAllCartArray :resultArr];
            NSString *isInvoiceStr ;//= self.isInvoice==YES?@"含税商品":@"不含税商品";
            NSString *isNotInvoiceStr ;//= self.isInvoice==false?@"不含税商品":@"含税商品";
            
            if(self.isInvoice ==YES)
            {
                isInvoiceStr = @"含税商品";
                isNotInvoiceStr = @"不含税商品";
                
                
            }else
            {
                
                isInvoiceStr = @"不含税商品";
                isNotInvoiceStr = @"含税商品";
            }
            self.TopTitleArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@(%d)",isInvoiceStr,IncludeInvoiceNumber],[NSString stringWithFormat:@"%@(%d)",isNotInvoiceStr,NotIncloudInvoiceNumber],nil];
            
        if (self.isRefreshData==false) {
            [self configUI];
            [self bottomview];
        }else
        {
            self.isRefreshData = false;
        }
      
        [myTableView.mj_header endRefreshing];
        isEmpty = YES;
        [self getTotalPrice];
        
        [self addRightNavBtn:@"编辑"];
        self.allPriceLabel.hidden = false;
        allPrice.hidden = NO;
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        
    } failedBlock:^(NSString *errorMessage) {
        
        [self.view makeToast:errorMessage duration:1.0 position:CSToastPositionCenter];
        
    }];
}


- (void)classifyAllCartArray:(NSArray *)array{
    
    self.LargeCartArray = [NSMutableArray arrayWithCapacity:0];
    self.smallCartArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *recordArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < array.count; i ++) {
        YHShoppingCartModel *shoppingmodel = array[i];
        _recordShoppingNumber  += shoppingmodel.GoodsNumber.intValue;
        NSString  *contidtion =  shoppingmodel.StoreId;
        if (![recordArray containsObject:contidtion]) {
            [recordArray addObject:contidtion];
        }
    }
    for (int i =0; i<recordArray.count; i++) {
        [self.smallCartArray removeAllObjects];
        for (int j=0; j<array.count; j++) {
            YHShoppingCartModel *shoppingmodel1 = array[j];
            NSString  *contidtion = shoppingmodel1.StoreId;

            if ([contidtion isEqualToString:recordArray[i]]) {
                [self.smallCartArray addObject:shoppingmodel1];
            }
        }
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:self.smallCartArray];
        [self.LargeCartArray addObject:array];
    }
    [self SelectAllOrNot];
    self.isEditAll = false;
    [myTableView reloadData];
   
}
- (void)configUI{
    
    CGFloat TopViewHeight =0;
    BOOL isIndustry = [[NSUserDefaults standardUserDefaults] boolForKey:IsIndustryCatagory];

//    if (isIndustry ==false) {
        TopViewHeight = 50;
        self.TopTitleView.hidden = YES;

        self.TopTitleView = [[YHTitleView alloc]initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, ScreenWidth, HeightRate(TopViewHeight)) titleFont:16 delegate:self andTitleArray:self.TopTitleArray];
        self.TopTitleView.backgroundColor = ColorWithHexString(StatusAndTopBarBackgroundColor);
        [self.view addSubview:self.TopTitleView] ;
//    }else
//    {
//        self.TopTitleView.hidden = YES;
//    }
    
    CGFloat height = 0;
    if (self.isBottomViewLow) {
        height = self.view.frame.size.height-(TOP_BAR_HEIGHT)-HeightRate(49)+HeightRate(10)-TopViewHeight;
    }else{
        height = self.view.frame.size.height-(TOP_BAR_HEIGHT)-HeightRate(49)+HeightRate(10)-(TAB_BAR_HEIGHT)-TopViewHeight;
    }
    if (myTableView==nil) {
       
        myTableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectMake(0, (TOP_BAR_HEIGHT)+TopViewHeight, self.view.frame.size.width, height) style:UITableViewStyleGrouped];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.showsVerticalScrollIndicator = NO;
        myTableView.showsVerticalScrollIndicator = NO;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTableView.estimatedRowHeight = 100;
        myTableView.estimatedSectionHeaderHeight =0;
        myTableView.estimatedSectionFooterHeight = 0;
        [self.view addSubview:myTableView];
  }else
  {
      myTableView.frame =CGRectMake(0, (TOP_BAR_HEIGHT)+TopViewHeight, self.view.frame.size.width, height);
  }
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    myTableView.mj_header = header;

}
- (void)loadNewData {
    self.isRefreshData = YES;
    [self getShoppingCartData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    for (int i =0; i<self.LargeCartArray.count; i++) {
        NSArray *arry = [self.LargeCartArray objectAtIndex:i];
        if (arry.count > 0) {
            count ++;
        }
    }
    return count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =[self.LargeCartArray objectAtIndex:section];

    if (self.LargeCartArray.count ==0) {
        return 0;
    }
   
    return arry.count +1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *smallArray = self.LargeCartArray[indexPath.section];
    if (indexPath.row == 0 ) {
        ShoppingCartHeaderCell *cell = nil;
        if (!cell) {
            cell = [[ShoppingCartHeaderCell alloc]init];
            cell.selectSectionBtn.tag = 100+ indexPath.section;
            [cell.selectSectionBtn addTarget:self action:@selector(selectSection:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (smallArray.count!=0) {
                YHShoppingCartModel *shoppingmodel =smallArray[0];
                cell.seriesLabel.text =[NSString stringWithFormat:@"%@",shoppingmodel.StoreName] ;
                [cell.storeImageView sd_setImageWithURL:[NSURL URLWithString:shoppingmodel.StorePhoto]];
                cell.selectSectionBtn.selected = shoppingmodel.isSectionSelect;
            }
        }
        
        return cell;
    }else{
        ShoppingCartNewCell *cell = nil;
        if (!cell) {
            cell = [[ShoppingCartNewCell alloc]initCell];
            cell.selectItemBtn.tag = 20000+ indexPath.row + 1000*indexPath.section;
            cell.addItemBtn.tag = 30000+ indexPath.row + 1000*indexPath.section;
            cell.decreseItemBtn.tag = 40000+ indexPath.row + 1000*indexPath.section;
            cell.Number.inputAccessoryView = [self addToolbar];
            [cell.selectItemBtn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            [cell.addItemBtn addTarget:self action:@selector(addNumber:) forControlEvents:UIControlEventTouchUpInside];
            [cell.decreseItemBtn addTarget:self action:@selector(decreaseNumber:) forControlEvents:UIControlEventTouchUpInside];
            cell.Number.delegate = self;
            cell.Number.tag = 60000+ indexPath.row + 1000*indexPath.section;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSInteger indexRow =indexPath.row-1;
        [cell setData:smallArray[indexRow]];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     if (indexPath.row == 0 ) {
         
         return HeightRate(32);
         
     }else{

         return UITableViewAutomaticDimension;
     }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
  
    return HeightRate(10);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return  TableViewHeaderNone;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        if (indexPath.row == 0) {
            return false;
        }else{
            return true;
        }
    
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSInteger indexRow =indexPath.row-1;

            NSMutableArray *arr = (NSMutableArray *)[_LargeCartArray objectAtIndex:indexPath.section];
            YHShoppingCartModel *model = arr[indexRow];
            
            [[YHJsonRequest shared] shoppingCartDeleteOderNumber:@[model.OrderNo] Sucess:^(NSString *successMessage) {
                
                [arr removeObjectAtIndex:indexRow];
                [_LargeCartArray removeObject:model];
                [self.allCartArray removeObject:model];
                [self.view makeToast:successMessage duration:2 position:CSToastPositionCenter];
                _recordShoppingNumber -= model.GoodsNumber.intValue;
                self.navigationItem.title =  @"购物车";
                BOOL isSelectSection = model.isSectionSelect;

                if (arr.count ==0) {
                    
                    [self.LargeCartArray removeObjectAtIndex:indexPath.section];
                    [myTableView reloadData];
                    
                }else
                {
                    if (indexPath.row == 1) {
                        
                        YHShoppingCartModel *modelAnother = arr[indexPath.row-1];
                        
                        [arr removeObject:modelAnother];
                        
                        modelAnother.isSectionSelect = isSelectSection;
                        
                        [arr insertObject:modelAnother atIndex:indexPath.row-1];
                    }
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    
                }
                [self SelectAllOrNot];
                //如果删除的时候数据紊乱,可延迟0.5s刷新一下
                [self performSelector:@selector(reloadTable) withObject:nil afterDelay:2];
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificatonRefreshCartData object:nil];
           
            

            } fialureBlock:^(NSString *errorMessages) {
                [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter];

            }];
          
            
           }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
    deleteAction.backgroundColor = ColorWithHexString(@"FAAF1E");
    return @[deleteAction];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == 0) {
        editingStyle  = UITableViewCellEditingStyleNone;
    }else{
        editingStyle = UITableViewCellEditingStyleDelete;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [MobClick event:@"GoodsDetail" label:@"商品详情页面"];
    NSInteger indexRow =indexPath.row-1;


    if (indexPath.row != 0) {

        NSArray *smallArray = self.LargeCartArray[indexPath.section];
        YHShoppingCartModel *shoppingmodel =smallArray[indexRow];
        YHProductDetailsViewController *vc = [[YHProductDetailsViewController alloc] init];
        vc.GoodsSeriesCode = shoppingmodel.GoodsSeriesCode;
        vc.hidesBottomBarWhenPushed = YES;
//        vc.GoodsSeriesCode = shoppingmodel.GoodsSeriesCode;
        vc.StoreID = shoppingmodel.StoreId;
        vc.storeAvata = shoppingmodel.StorePhoto;
        vc.storePhoneNumber = @"";
        vc.StoreName    = shoppingmodel.StoreName;
//vc
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark--- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField.text integerValue] >=100000) {
        textField.text = @"99999";
    }
    if ([textField.text integerValue] <=0) {
        textField.text = @"1";
    }
    NSInteger section = (textField.tag - 60000)/1000;
    NSInteger row = (textField.tag - 1000*section - 60000 );
    NSInteger indexRow =row-1;

    NSArray *array = [self.LargeCartArray objectAtIndex:section];
    for (int i= 0; i <array.count; i++) {
        YHShoppingCartModel *shoppingmodel =array[i];
        if (i == indexRow) {
            shoppingmodel.GoodsNumber = textField.text;
            shoppingmodel.isEditNumber = YES;

        }
    }
    [self.LargeCartArray removeObjectAtIndex:section];
    [self.LargeCartArray insertObject:array atIndex:section];
    [UIView performWithoutAnimation:^{
        [myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }];
    [self changeNumber];
    [self SelectAllOrNot];
    [self getTotalPrice];
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}
#pragma mark  === method
-(void)reloadTable
{

    if(_recordShoppingNumber ==0)
    {
     [self getShoppingCartData];
    }
    [self getTotalPrice];

}
- (void)changeNumber{
    NSDictionary   *dict;
    for (int i =0; i<self.LargeCartArray.count; i++) {
        NSArray  *smallArray = self.LargeCartArray[i];
        for (int j =0; j<smallArray.count; j++) {
            YHShoppingCartModel *shoppingmodel =smallArray[j];
            if (shoppingmodel.isEditNumber == YES) {
                dict = @{@"OrderNo":shoppingmodel.OrderNo,@"GoodsNumber":shoppingmodel.GoodsNumber};

            }
        }
    }
   
    //通知主线程刷新
    [[YHJsonRequest shared] shoppingCartChangeOderNumber:dict Sucess:^(NSString *successMessage) {
            
    } fialureBlock:^(NSString *errorMessages) {
        
        [self.view makeToast:errorMessages duration:1.0 position:CSToastPositionCenter];
        
    }];
    
}
- (void)discussContractButtonClicked:(UIButton *)button {
    NSMutableArray *deleteArr = [NSMutableArray array];
    NSMutableArray *deleteItemArr = [NSMutableArray array];

    NSInteger recordNum = 0 ;
    NSInteger countNum = 0;
    NSMutableArray *addArr = [NSMutableArray array];
    for (NSArray *class in self.LargeCartArray) {
        NSMutableArray *addSmallArr = [NSMutableArray array];
        for (YHShoppingCartModel *item in class) {
            if (item.isSelect == YES) {
                [addSmallArr addObject:item];
//                [deleteArr addObject:@{@"OrderNo":item.OrderNo}];
                [deleteArr addObject:item.OrderNo];

                [deleteItemArr addObject:item];
                recordNum += item.GoodsNumber.integerValue;
                countNum ++;
                
            }
        }
        [addArr addObject:addSmallArr];
    }
    if (countNum <= 0) {
        
        [self.view makeToast:@"你还没有选择产品，请选择" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    NSMutableArray *selectArray = [NSMutableArray arrayWithCapacity:0];
    for (NSArray *array in addArr) {
        if (array.count >0) {
            [selectArray addObject:array];
        }
    }
   
    if ([button.currentTitle isEqualToString:@"删除"]) {
        [MobClick event:@"DeleteGoods" label:@"删除商品"];

        [[YHJsonRequest shared] shoppingCartDeleteOderNumber:deleteArr Sucess:^(NSString *successMessage) {
            
            [self.view makeToast:successMessage duration:2 position:CSToastPositionCenter];
            _recordShoppingNumber -= recordNum;
            self.navigationItem.title =  [NSString stringWithFormat:@"购物车(%d)",_recordShoppingNumber];
        
            [self loadNewData];


        } fialureBlock:^(NSString *errorMessages) {
            [self.view makeToast:errorMessages duration:1 position:CSToastPositionCenter];
            
        }];
    }else
    {
    YHShoppingCartConfirmViewController *confirm = [[YHShoppingCartConfirmViewController alloc] init];
    confirm.selectArray = selectArray;
    confirm.totalPrice = recordTotalPrice;
        confirm.insurancePrice =recordTotalPrice;
    confirm.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:confirm animated:YES];
    }
}
- (void)rightBtnClick:(UIButton *)sender{
    
    for (int i =0; i< self.LargeCartArray.count; i++) {
        NSArray *array = [self.LargeCartArray objectAtIndex:i];
        for (int j =0; j< array.count; j++) {
            YHShoppingCartModel *shoppingmodel =array[j];
            if (self.isEditAll == false) {
                shoppingmodel.isEdit = YES;
               
            }else{
                shoppingmodel.isEdit = false;
            }
            
        }
        [self.LargeCartArray removeObjectAtIndex:i];
        [self.LargeCartArray insertObject:array atIndex:i];
    }
     isEmpty1 = YES;
    if (sender.selected == YES) {
        [self setRightBtnTitle:@"编辑"];
        self.allPriceLabel.hidden = false;
        allPrice.hidden = NO;
       
        [self getTotalPrice];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sender.selected = false;
    }else{
        [self setRightBtnTitle:@"完成"];
        self.allPriceLabel.hidden = YES;
    allPrice.hidden = YES;
        [sureBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self getTotalPrice];
        sender.selected = YES;

  
    }
    self.isEditAll = !self.isEditAll;
    
    [myTableView reloadData];
    
}
- (void)selectAllButtonClicked:(UIButton *)button {
    
    if (self.LargeCartArray.count == 0) {
        [self.view makeToast:@"购物车暂无商品，请先去添加" duration:2 position:CSToastPositionCenter];
        return;
    }
    button.selected = !button.selected;

    for (int i =0; i< self.LargeCartArray.count; i++) {
        NSArray *array = [self.LargeCartArray objectAtIndex:i];
        for (int j =0; j< array.count; j++) {
            YHShoppingCartModel *shoppingmodel =array[j];
            if (self.isSelectAll == true) {
                shoppingmodel.isSelect = button.selected;
                if (j==0) {
                    
                    shoppingmodel.isSectionSelect = button.selected;
                    
                }
            }else{
                shoppingmodel.isSelect = button.selected;
                if (j==0) {
                    
                    shoppingmodel.isSectionSelect = button.selected;
                }
            }
            
        }
        [self.LargeCartArray removeObjectAtIndex:i];
        [self.LargeCartArray insertObject:array atIndex:i];
    }
    self.isSelectAll = !self.isSelectAll;
    [myTableView reloadData];
    [self getTotalPrice];
}
- (void)selectSection:(UIButton *)sender{
    
    NSInteger section = sender.tag - 100;
    NSArray *array = [self.LargeCartArray objectAtIndex:section];
    YHShoppingCartModel *shoppingmodel0 =array[0];
    if (shoppingmodel0.isSectionSelect == true) {
        
        for (int i =0; i< array.count; i++) {
            YHShoppingCartModel *shoppingmodel =array[i];
            shoppingmodel.isSelect = false;
            if (i==0) {
                shoppingmodel.isSectionSelect = false;
            }
        }
    }else{
        for (int i =0; i< array.count; i++) {
            
            YHShoppingCartModel *shoppingmodel =array[i];
            shoppingmodel.isSelect = true;
            if (i==0) {
                shoppingmodel.isSectionSelect = true;
            }
        }
    }
    [self.LargeCartArray removeObjectAtIndex:section];
    [self.LargeCartArray insertObject:array atIndex:section];
    [myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    [self SelectAllOrNot];
    [self getTotalPrice];
}
- (void)selectItem:(UIButton *)sender{
   
    NSInteger section = (sender.tag - 20000)/1000;
    NSInteger row = (sender.tag - 1000*section - 20000 );
    NSInteger indexRow =row-1;

    NSArray *array = [self.LargeCartArray objectAtIndex:section];
    for (int i= 0; i <array.count; i++) {
        YHShoppingCartModel *shoppingmodel =array[i];
        if (i == indexRow) {
            shoppingmodel.isSelect = !shoppingmodel.isSelect;
        }
    }
    YHShoppingCartModel *shoppingmodel0 =array[0];
    BOOL flag = shoppingmodel0.isSelect;
    for (int i= 0; i <array.count; i++) {
        YHShoppingCartModel *shoppingmodel =array[i];
        if (shoppingmodel.isSelect != flag) {
            shoppingmodel0.isSectionSelect = false;
            break;
        }else{
            shoppingmodel0.isSectionSelect = shoppingmodel.isSelect;
        }
    }
    [self.LargeCartArray removeObjectAtIndex:section];
    [self.LargeCartArray insertObject:array atIndex:section];
    [UIView performWithoutAnimation:^{
        [myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }];

    [self SelectAllOrNot];
    [self getTotalPrice];
}

- (void)addNumber:(UIButton *)sender{
    
    NSInteger section = (sender.tag - 30000)/1000;
    NSInteger row = (sender.tag - 1000*section - 30000 );
    NSArray *array = [self.LargeCartArray objectAtIndex:section];
    NSInteger indexRow =row-1;

    for (int i= 0; i <array.count; i++) {
        YHShoppingCartModel *shoppingmodel =array[i];
        if (i == indexRow) {
            if ([shoppingmodel.GoodsNumber integerValue] >=99999) {
                [self.view makeToast:@"改商品最多可加9999件" duration:1.0 position:CSToastPositionCenter];
                return;
            }
            shoppingmodel.GoodsNumber = [NSString stringWithFormat:@"%d",([shoppingmodel.GoodsNumber intValue] + 1)];
            shoppingmodel.isEditNumber = YES;
        }
    }
    [self.LargeCartArray removeObjectAtIndex:section];
    [self.LargeCartArray insertObject:array atIndex:section];
    [UIView performWithoutAnimation:^{
        [myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }];
    [self changeNumber];
    [self SelectAllOrNot];
    [self getTotalPrice];
}

- (void)decreaseNumber:(UIButton *)sender{
    
    NSInteger section = (sender.tag - 40000)/1000;
    NSInteger row =  (sender.tag - 1000*section - 40000 );
    NSInteger indexRow =row-1;

    NSArray *array = [self.LargeCartArray objectAtIndex:section];
    YHShoppingCartModel *selectShoppingmodel =array[indexRow];
    if ([selectShoppingmodel.GoodsNumber intValue]<=1) {
        [self.view makeToast:@"该商品已减至1件" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    for (int i= 0; i <array.count; i++) {
        YHShoppingCartModel *shoppingmodel =array[i];
        if (i == indexRow) {
            
            shoppingmodel.GoodsNumber = [NSString stringWithFormat:@"%d",([shoppingmodel.GoodsNumber intValue] - 1)];
            shoppingmodel.isEditNumber = YES;

        }
    }
    [self.LargeCartArray removeObjectAtIndex:section];
    [self.LargeCartArray insertObject:array atIndex:section];
    [UIView performWithoutAnimation:^{
        [myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }];
    [self changeNumber];
    [self SelectAllOrNot];
    [self getTotalPrice];
}
- (void)getTotalPrice{
    
    double totalPrice = 0;
    int num = 0;
    for (int i =0; i<self.LargeCartArray.count; i++) {
        NSArray  *smallArray = self.LargeCartArray[i];
        for (int j =0; j<smallArray.count; j++) {
            YHShoppingCartModel *shoppingmodel =smallArray[j];
            num += shoppingmodel.GoodsNumber.floatValue;
            if (shoppingmodel.isSelect == true) {
                totalPrice = totalPrice +round([shoppingmodel.ProductGroupPrice doubleValue]*100)/100*[shoppingmodel.GoodsNumber intValue];
            }
        }
    }
        UIButton *button = self.TopTitleView.titleButtonArray[self.recordTopBtnSelet];
        NSString *isInvoiceStr = self.isInvoice==YES?@"含税商品":@"不含税商品";
        NSString *btnTopTitle = [NSString stringWithFormat:@"%@(%d)",isInvoiceStr,num];
        [button setTitle:btnTopTitle forState:UIControlStateNormal];
 
    
    
    if (self.LargeCartArray.count ==0) {

        myTableView.hidden = YES;
        bottomView.hidden = YES;

        [self getEmptyShoppingCart];

    }else{
        myTableView.hidden = false;
        bottomView.hidden = false;
        emptyView.hidden = YES;
        _allPriceLabel.text = [NSString stringWithFormat:@"¥ %@",[Tools getHaveNum:totalPrice]];
        recordTotalPrice = [NSString stringWithFormat:@"%@",[Tools getHaveNum:totalPrice]];

    }
}

- (void)SelectAllOrNot{
    
    if (self.LargeCartArray.count >0) {
        NSArray  *smallArray0 = self.LargeCartArray[0];
        YHShoppingCartModel *shoppingmodel0 =smallArray0[0];
        BOOL flag = shoppingmodel0.isSectionSelect;
        for (int i =0; i<self.LargeCartArray.count; i++) {
            NSArray  *smallArray = self.LargeCartArray[i];
            YHShoppingCartModel *shoppingmodel =smallArray[0];
            if (shoppingmodel.isSectionSelect != flag) {
                
                self.selectButton.selected = false;
                break;
            }else{
                 self.selectButton.selected = flag;
            }
        }
    }else{
        
    }
}
-(void)bottomview{
    
    if (bottomView == nil) {
    
        bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = ColorWithHexString(@"ffffff");
        [self.view addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            if (self.isBottomViewLow) {
                make.bottom.mas_equalTo(0);
            }else{
                
                make.bottom.mas_equalTo(-(TAB_BAR_HEIGHT));
            }
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(HeightRate(49));
        }];

        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectButton setImage:[UIImage imageNamed:@"shopping_cart_select_no"] forState:UIControlStateNormal];
        [selectButton setImage:[UIImage imageNamed:@"shopping_cart_select_yes"] forState:UIControlStateSelected];
        [selectButton addTarget:self action:@selector(selectAllButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:selectButton];
        [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bottomView);
            make.left.mas_equalTo(bottomView).offset(SelectButtonLeftMargin);
            make.width.mas_equalTo(SelectButtonWidth);
            make.height.mas_equalTo(SelectButtonHeight);
        }];
        _selectButton = selectButton;

        // /* todo
        UILabel *selectAllLabel = [[UILabel alloc] init];
        selectAllLabel.text =@"全选";


        [bottomView addSubview:selectAllLabel];
        [selectAllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bottomView);
            make.left.mas_equalTo(selectButton.mas_right).offset(SelectAllLabelLeftMargin);
        }];



        UIButton *discussContractButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [bottomView addSubview:discussContractButton];
        discussContractButton.backgroundColor = [UIColor colorWithHexString:APP_THEME_MAIN_COLOR];
        discussContractButton.titleLabel.font = SYSTEM_FONT(AdaptFont(BASE_FONT_SIZE));
        [discussContractButton setTitle:@"确定" forState:UIControlStateNormal];
        [discussContractButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [discussContractButton addTarget:self action:@selector(discussContractButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [discussContractButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView);
            make.right.mas_equalTo(bottomView);
            make.width.mas_equalTo(WidthRate(117));
            make.height.mas_equalTo(HeightRate(BottomViewHeight));
        }];
        sureBtn = discussContractButton;
    
        _allPriceLabel = [[UILabel alloc] init];
        _allPriceLabel.textColor =ColorWithHexString(StandardBlueColor);
        _allPriceLabel.font = [UIFont systemFontOfSize:AdaptFont(16)];
        _allPriceLabel.text = @"￥0";
        [bottomView addSubview:_allPriceLabel];
        [_allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(discussContractButton.mas_left).offset(WidthRate(-10));
            make.centerY.mas_equalTo(bottomView.mas_centerY);
            make.height.mas_equalTo(BottomViewItemLabelHeight);
        }];
        
        UILabel *allPriceItemLabel = [[UILabel alloc] init];
        allPriceItemLabel.text =@"合计：";
        allPriceItemLabel.font = [UIFont systemFontOfSize:AdaptFont(12)];
        allPriceItemLabel.textColor = ColorWithHexString(@"676767");
        
        allPriceItemLabel.textAlignment = NSTextAlignmentRight;
        [bottomView addSubview:allPriceItemLabel];
        [allPriceItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.allPriceLabel.mas_left).offset(WidthRate(0));
            make.centerY.mas_equalTo(bottomView.mas_centerY);
            make.height.mas_equalTo(BottomViewItemLabelHeight);
        }];
        allPrice = allPriceItemLabel;
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:BASE_LINE_COLOR];
        [bottomView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bottomView);
            make.left.mas_equalTo(bottomView);
            make.right.mas_equalTo(discussContractButton);
            make.height.mas_equalTo(LineViewHeight);
        }];
    }
}

#pragma mark---YHTitleView
- (void)titleView:(id)titleView selectItemWithIndex:(NSInteger)index{
    NSLog(@"indek====%ld",(long)index);
    self.recordTopBtnSelet = index;
    self.isInvoice = index==1?NO:YES;

    NSMutableArray  *resultArr =[NSMutableArray arrayWithCapacity:0];
    for (YHShoppingCartModel *model in self.allCartArray) {
        if ([model.IsInvoice isEqualToString:[NSString stringWithFormat:@"%ld",self.isInvoice]]) {
            [resultArr addObject:model];
        }
    }

    [self classifyAllCartArray:resultArr];
    [self getTotalPrice];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
