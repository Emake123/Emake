//
//  PSVCTBase.m
//  Framework
//
//  Created by chenyi on 2017/7/12.
//  Copyright © 2017年 polarsoft. All rights reserved.
//

#import "PSVCTBase.h"


@interface PSVCTBase () <UITableViewDelegate,UITableViewDataSource,UITableViewDataSourcePrefetching>


@end

@implementation PSVCTBase

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self addSubview:self.table];
    self.table.delegate = self;
    self.table.dataSource = self;
    
    self.cell = [[NSMutableArray alloc] init];
}

-(void) registerIdentifier:(PSTableViewCellBase *) cell
{
    [self.table registerClass:cell  forCellReuseIdentifier: NSStringFromClass([cell class]) ];
    [self.cell addObject:cell];
}


/*
-(id) initWithCell:(NSArray *) cell
{
    if (self = [super init])
    {
        self.cell = cell;
        self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        self.table.delegate = self;
        self.table.dataSource = self;
        
        for (PSTableViewCellBase *sicell in self.cell)
        {
            [self.table registerClass:[sicell class]  forCellReuseIdentifier:sicell.identifier];
        }
    }
    return self;
}
 */


#pragma UITableView Delegate

#pragma UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.data)
    {
        return [self.data count];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.data)
    {
        return [[self.data objectAtIndex:section] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.data)
    {
        PSTableViewCellBase *cell = [self.table dequeueReusableCellWithIdentifier:[self.cell objectAtIndex:indexPath.row] forIndexPath:indexPath];
        
        [cell setData:self.data[indexPath.section][indexPath.row]];
        
        return cell;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView prefetchRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
{
    
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
