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
#import "JXPopoverView.h"

@interface SKGiftBagViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *giftBagTableView;
@property (nonatomic,copy)NSArray *giftBagListArray;
@property (nonatomic,strong)NSMutableArray *giftList;
@property (nonatomic,copy)NSString *giftType;
@property (nonatomic,strong)UIButton *giftButton;
@property (nonatomic,strong)UIBarButtonItem *barButton;
@property (nonatomic,strong)UIImageView *notInfoImageView;
@property (nonatomic,strong)UILabel *notInfoLabel;
@end

@implementation SKGiftBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(giftNotificationAction:) name:@"GiftNotification" object:nil];
    self.giftList = [[NSMutableArray alloc] init];
    [self requestQueryGiftBag];
    self.giftBagTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.giftBagTableView.delegate = self;
    self.giftBagTableView.dataSource = self;
    self.giftBagTableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:self.giftBagTableView];
    
    self.notInfoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NotInformation"]];
    self.notInfoImageView.hidden = YES;
    [self.view addSubview:self.notInfoImageView];
    
    self.notInfoLabel = [[UILabel alloc] init];
    self.notInfoLabel.hidden = YES;
    self.notInfoLabel.text = @"亲,暂时没有礼包";
    self.notInfoLabel.textColor = [UIColor colorWithRed:145/255.f green:145/255.f blue:145/255.f alpha:1.f];
    self.notInfoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.notInfoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.notInfoLabel];
    [self configNavi];
}

-(void)configNavi{
    self.navigationItem.title = @"礼包";
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem.customView.hidden=YES;
    
    self.giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.giftButton addTarget:self action:@selector(selectSpace:) forControlEvents:UIControlEventTouchDown];
    [self.giftButton setTitle:self.giftType forState:UIControlStateNormal];
    self.giftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.giftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *imageForButton = [UIImage imageNamed:@"Triangular"];
    [self.giftButton setImage:imageForButton forState:UIControlStateNormal];
    CGSize buttonTitleLabelSize = [self.giftType sizeWithAttributes:@{NSFontAttributeName:self.giftButton.titleLabel.font}]; //文本尺寸
    CGSize buttonImageSize = imageForButton.size;   //图片尺寸
    self.giftButton.frame = CGRectMake(0,0,
                                       buttonImageSize.width + buttonTitleLabelSize.width,
                                       buttonImageSize.height);
    self.giftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -self.giftButton.imageView.frame.size.width - self.giftButton.frame.size.width + self.giftButton.titleLabel.intrinsicContentSize.width, 0, 0);
    
    self.giftButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.giftButton.titleLabel.frame.size.width - self.giftButton.frame.size.width + self.giftButton.imageView.frame.size.width);
    
    self.barButton = [[UIBarButtonItem alloc]initWithCustomView:self.giftButton];
    self.navigationItem.rightBarButtonItem = self.barButton;
    //[self configNaviRightItemWithImage:[UIImage imageNamed:@"publishSocial"]];
}


-(void)viewDidLayoutSubviews
{
    [self.giftBagTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.notInfoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.width.mas_offset(70);
    }];
    
    [self.notInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.notInfoImageView.mas_bottom).with.offset(10);
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.giftBagListArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SKGiftBagModel_list *model = self.giftBagListArray[section];
    return  model.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SKGiftBagTableViewCell";
    SKGiftBagTableViewCell *cell = (SKGiftBagTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SKGiftBagTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    SKGiftBagModel_list *model_list = self.giftBagListArray[indexPath.section];
    SKGiftBagModel *model = model_list.list[indexPath.row];
    [cell.giftBagImageView sd_setImageWithURL:[model.picture ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_space"]];
    cell.giftNameLabel.text = model.giftName;
    cell.giftPriceLabel.text = [NSString stringWithFormat:@"¥%@.00",model.price];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKGiftBagInfoViewController *giftBagInfoVC = [[SKGiftBagInfoViewController alloc] init];
    SKGiftBagModel_list *model_list = self.giftBagListArray[indexPath.section];
    giftBagInfoVC.giftBagModel  = model_list.list[indexPath.row];
    [self.navigationController pushViewController:giftBagInfoVC animated:YES];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SKGiftBagModel_list *model = self.giftBagListArray[section];

    return model.type;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 260;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }else
    {
        return 10;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else
    {
        return 10;
    }
}


#pragma mark - 查询礼包列表
-(void)requestQueryGiftBag
{
    [WOTHTTPNetwork queryGiftBagListWithType:nil response:^(id bean, NSError *error) {
        SKGiftBagModel_msg *model_msg = (SKGiftBagModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.notInfoImageView.hidden = YES;
                self.notInfoLabel.hidden = YES;
                self.giftBagListArray = model_msg.msg;
                [self queryGiftList:self.giftBagListArray];
                [self.giftBagTableView reloadData];
            });
            
        }else
        {
            self.notInfoImageView.hidden = NO;
            self.notInfoLabel.hidden = NO;
            [MBProgressHUDUtil showMessage:@"未查询到礼包" toView:self.view];
            return ;
        }
    }];
}

#pragma mark - 查询礼包
-(void)queryGiftList:(NSArray *)array
{
    for (SKGiftBagModel *model in array) {
        //
        BOOL isHaveCity = NO;
        for (NSString *type in self.giftList) {
            if ([model.type isEqualToString:type]) {
                isHaveCity = YES;
                break;
            }
        }
        if (!isHaveCity) {
            [self.giftList addObject:model.type];
        }
    }
    [self.giftList insertObject:@"全部礼包" atIndex:0];
    if (self.giftList.count > 0) {
        self.giftType = [self.giftList firstObject];
        [self configNavi];
        //[self queryGigtBagWithType:self.giftType];
    }
}

#pragma mark - 选择礼包类型
-(void)selectSpace:(UIButton *)sender
{
    
    if (self.giftList.count) {
        JXPopoverView *popoverView = [JXPopoverView popoverView];
        NSMutableArray *JXPopoverActionArray = [[NSMutableArray alloc] init];
        for (NSString *name in self.giftList) {
            JXPopoverAction *action1 = [JXPopoverAction actionWithTitle:name handler:^(JXPopoverAction *action) {
                self.giftType = name;
                [self configNavi];
                //[self.cityButton setTitle:cityName forState:UIControlStateNormal];
                NSLog(@"测试：%@",name);
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:name,@"type", nil];
                NSNotification *notification =[NSNotification notificationWithName:@"GiftNotification" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }];
            [JXPopoverActionArray addObject:action1];
        }
        [popoverView showToView:sender withActions:JXPopoverActionArray];
    }
}

- (void)giftNotificationAction:(NSNotification *)notification{
    self.giftType = [notification.userInfo objectForKey:@"type"];
    [self queryGigtBagWithType:self.giftType];
}

#pragma mark - 通过类型查看礼包列表
-(void)queryGigtBagWithType:(NSString *)type
{
    NSString *typeStr;
    if ([type isEqualToString:@"全部礼包"]) {
        typeStr = nil;
    }else
    {
        typeStr = type;
    }
    [WOTHTTPNetwork queryGiftBagListWithType:typeStr response:^(id bean, NSError *error) {
        SKGiftBagModel_msg *model_msg = (SKGiftBagModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            self.notInfoImageView.hidden = YES;
            self.notInfoLabel.hidden = YES;
            self.giftBagListArray = model_msg.msg;
            [self configNavi];
            [self.giftBagTableView reloadData];
        }else
        {
            self.notInfoImageView.hidden = NO;
            self.notInfoLabel.hidden = NO;
            [MBProgressHUDUtil showMessage:@"未查询到礼包" toView:self.view];
            return ;
        }
    }];
//    [WOTHTTPNetwork queryGiftBagWithType:type response:^(id bean, NSError *error) {
//        SKGiftBagModel_msg *model_msg = (SKGiftBagModel_msg *)bean;
//        if ([model_msg.code isEqualToString:@"200"]) {
//            self.giftBagListArray = model_msg.msg;
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self configNavi];
//                [self.giftBagTableView reloadData];
//            });
//        }
//        else
//        {
//            [MBProgressHUDUtil showMessage:@"未查询到礼包" toView:self.view];
//            return ;
//        }
//    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"GiftNotification"];
}

-(NSArray <SKGiftBagModel *>*)giftBagListArray
{
    if (_giftBagListArray == nil) {
        _giftBagListArray = [[NSArray alloc] init];
    }
    return _giftBagListArray;
}

@end
