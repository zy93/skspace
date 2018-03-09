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
#import "WOTHTTPNetwork.h"
#import "SKGiftBagModel.h"
#import "NSString+Category.h"

@interface SKGiftBagViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *giftBagTableView;
@property (nonatomic,copy)NSArray <SKGiftBagModel *>*giftBagListArray;

@end

@implementation SKGiftBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.title = @"礼包";
    [self requestQueryGiftBag];
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
    return  self.giftBagListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKGiftBagTableViewCell";
    SKGiftBagTableViewCell *cell = (SKGiftBagTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SKGiftBagTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.giftBagImageView sd_setImageWithURL:[self.giftBagListArray[indexPath.row].picture ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_space"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKGiftBagInfoViewController *giftBagInfoVC = [[SKGiftBagInfoViewController alloc] init];
    giftBagInfoVC.giftBagModel = self.giftBagListArray[indexPath.row];
    [self.navigationController pushViewController:giftBagInfoVC animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


#pragma mark - 查询礼包列表
-(void)requestQueryGiftBag
{
    [WOTHTTPNetwork queryGiftBagListresponse:^(id bean, NSError *error) {
        SKGiftBagModel_msg *model_msg = (SKGiftBagModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            self.giftBagListArray = model_msg.msg;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.giftBagTableView reloadData];
            });
        }
        else
        {
            [MBProgressHUDUtil showMessage:@"未查询到礼包" toView:self.view];
            return ;
        }
    }];
}

-(NSArray <SKGiftBagModel *>*)giftBagListArray
{
    if (_giftBagListArray == nil) {
        _giftBagListArray = [[NSArray alloc] init];
//        _giftBagImageArray = @[@"GiftBag1",@"GiftBag2",@"GiftBag3"];
    }
    return _giftBagListArray;
}



@end
