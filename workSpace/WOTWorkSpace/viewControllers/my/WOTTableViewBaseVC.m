//
//  WOTTableViewBaseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTTableViewBaseVC.h"

@interface WOTTableViewBaseVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WOTTableViewBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    
    self.view.backgroundColor = MainColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadSubViews{
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = CLEARCOLOR;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView.backgroundColor = CLEARCOLOR;
    
    [self.view addSubview:_tableView];
}


-(void)viewWillAppear:(BOOL)animated{
    [self configNaviBackItem];
    [self.navigationController.navigationBar setHidden:NO];
}


-(void)viewWillLayoutSubviews{
    [self.tableView layoutConstraintsToView:self.view];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return  70;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    return cell;
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
