//
//  YHSexChangeViewController.m
//  emake
//
//  Created by 谷伟 on 2017/9/4.
//  Copyright © 2017年 emake. All rights reserved.
//

#import "YHSexChangeViewController.h"
#import "YHSexItemTableViewCell.h"
@interface YHSexChangeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *myTableView;
    NSArray *sexArray;
    NSString * selectFlag;
    UIButton *confirmBtn;
}
@end

@implementation YHSexChangeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"修改性别";
    [self addRightNavBtn:@"确定"];
    sexArray = [NSArray arrayWithObjects:@"男",@"女",@"保密", nil];
    selectFlag = self.sex;
    [self configUI];
}
- (void)configUI{
    self.view.backgroundColor = APP_THEME_MAIN_GRAY;
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TOP_BAR_HEIGHT, self.view.frame.size.width, HeightRate(48*3)) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)rightBtnClick:(UIButton *)sender{
    self.block(selectFlag);
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark====UITableViewDelegate & UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHSexItemTableViewCell *cell = nil;
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"YHSexItemTableViewCell" bundle:nil] forCellReuseIdentifier:@"YHSexItemTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"YHSexItemTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.sexItem.text = sexArray[indexPath.row];
        if ([selectFlag integerValue] == indexPath.row) {
            cell.selectImage.hidden = false;
        }
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  HeightRate(48);
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHSexItemTableViewCell *cellOne = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    YHSexItemTableViewCell *cellTwo = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    YHSexItemTableViewCell *cellThree = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (indexPath.row == 0) {
        cellOne.selectImage.hidden = false;
        cellTwo.selectImage.hidden = true;
        cellThree.selectImage.hidden = true;
    }else if (indexPath.row == 1) {
        cellOne.selectImage.hidden = true;
        cellTwo.selectImage.hidden = false;
        cellThree.selectImage.hidden = true;
    }else{
        cellOne.selectImage.hidden = true;
        cellTwo.selectImage.hidden = true;
        cellThree.selectImage.hidden = false;
    }
    selectFlag = [NSString stringWithFormat:@"%ld",indexPath.row];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
