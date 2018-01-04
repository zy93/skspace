//
//  SKGiftBagViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/26.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKGiftBagViewController.h"
#import "Masonry.h"
#import "SKGiftBagTableViewCell.h"
#import "SKGiftBagInfoViewController.h"

@interface SKGiftBagViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *giftBagTableView;
@property (nonatomic,strong)NSArray *giftBagImageArray;

@end

@implementation SKGiftBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.hidesBottomBarWhenPushed = YES;
    self.giftBagTableView = [[UITableView alloc] init];
    self.giftBagTableView.delegate = self;
    self.giftBagTableView.dataSource = self;
    self.giftBagTableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.giftBagTableView];
}


-(void)viewDidLayoutSubviews
{
    [self.giftBagTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.giftBagImageArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKGiftBagTableViewCell";
    SKGiftBagTableViewCell *cell = (SKGiftBagTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SKGiftBagTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.giftBagImageView setImage:[UIImage imageNamed:self.giftBagImageArray[indexPath.row]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKGiftBagInfoViewController *giftBagInfoVC = [[SKGiftBagInfoViewController alloc] init];
    giftBagInfoVC.giftBagNameStr = self.giftBagImageArray[indexPath.row];
    [self.navigationController pushViewController:giftBagInfoVC animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(NSArray *)giftBagImageArray
{
    if (_giftBagImageArray == nil) {
        _giftBagImageArray = [[NSArray alloc] init];
        _giftBagImageArray = @[@"GiftBag1",@"GiftBag2",@"GiftBag3"];
    }
    return _giftBagImageArray;
}



@end
