//
//  WOTReservationsMeetingVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTReservationsMeetingVC.h"
#import "WOTReservationsMeetingCell.h"
#import "WOTOrderVC.h"
#import "WOTSelectWorkspaceListVC.h"//1
#import "WOTDatePickerView.h"
#import "WOTMeetingListModel.h"
#import "WOTMeetingReservationsModel.h"
#import "MBProgressHUD+Extension.h"
#import "JudgmentTime.h"



@interface WOTReservationsMeetingVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableList;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIImageView *notInformationImageView;
@property (weak, nonatomic) IBOutlet UILabel *notInformationLabel;
@property (nonatomic, assign) BOOL isValidTime;
@property (nonatomic, strong) WOTSpaceModel *spaceModel;
@property (nonatomic, strong) NSNumber *meetingHours;

@end

@implementation WOTReservationsMeetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.table registerNib:[UINib nibWithNibName:@"WOTReservationsMeetingCell" bundle:nil] forCellReuseIdentifier:@"WOTReservationsMeetingCell"];
    
    self.spaceId = [WOTSingtleton shared].nearbySpace.spaceId ;
   // _spaceSite = [WOTSingtleton shared].nearbySpace.spaceSite;
    [self creatSpace];
//    WOTLocationModel *model = [WOTSingtleton shared].nearbySpace;
//    NSLog(@"最近空间%@",model.spaceName);
    self.spaceName = @"全部";
//    if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
//        self.spaceName = @"全部";
//    }else
//    {
//        if (model.spaceName) {
//
//            self.spaceName = model.spaceName;
//        }
//        else
//        {
//            self.spaceName = @"未定位";
//        }
//    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self createRequest];
    [self configNavi];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.translucent = YES;
}

-(void)configNavi
{
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
        self.navigationItem.title = @"预定会议室";
    }
    else {
        self.navigationItem.title = @"预定场地";
    }
    
    ///需要更改的地方
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(selectSpace:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:self.spaceName forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImage *imageForButton = [UIImage imageNamed:@"Triangular"];
    
    [button setImage:imageForButton forState:UIControlStateNormal];
    CGSize buttonTitleLabelSize = [self.spaceName sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}]; //文本尺寸
    CGSize buttonImageSize = imageForButton.size;   //图片尺寸
    button.frame = CGRectMake(0,0,
                              buttonImageSize.width + buttonTitleLabelSize.width,
                              buttonImageSize.height);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width - button.frame.size.width + button.titleLabel.intrinsicContentSize.width, 0, 0);
    
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -button.titleLabel.frame.size.width - button.frame.size.width + button.imageView.frame.size.width);
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    
    
    self.navigationController.navigationBar.translucent = NO; //有个万恶的黑色
}


#pragma mark - update view
-(void)reloadView
{
    [self createRequest];
}

#pragma mark - 通过spaceID请求space
-(void)creatSpace
{
    [WOTHTTPNetwork getSpaceFromSpaceID:self.spaceId bolock:^(id bean, NSError *error) {
        if (bean) {
            WOTSpaceModel *model = (WOTSpaceModel *)bean;
            self.spaceModel = model;
        }
    }];
}

#pragma mark - request
-(void)createRequest
{
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
        if ([self.spaceName isEqualToString:@"全部"]) {
            self.spaceId = nil;
        }
        [WOTHTTPNetwork getMeetingRoomListWithSpaceId:self.spaceId type:@(0) response:^(id bean, NSError *error) {
            if (error) {
                NSLog(@"error:%@",error);
                 self.notInformationLabel.text = @"亲，暂时没有会议室哦！";
                return ;
            }
            WOTMeetingListModel_msg *model = bean;
            tableList = model.msg.list;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (tableList.count) {
                    self.notInformationImageView.hidden = YES;
                    self.notInformationLabel.hidden = YES;
                    [self.table reloadData];
                } else {
                    self.notInformationImageView.hidden = NO;
                    self.notInformationLabel.hidden = NO;
                    self.notInformationLabel.text = @"亲，暂时没有会议室哦！";
                }
                [self.table reloadData];
            });
        }];
    }
    else {
        if ([self.spaceName isEqualToString:@"全部"]) {
            self.spaceId = nil;
        }
        [WOTHTTPNetwork getMeetingRoomListWithSpaceId:self.spaceId type:@(1) response:^(id bean, NSError *error) {
            if (error) {
                NSLog(@"error:%@",error);
                self.notInformationLabel.text = @"亲，暂时没有场地哦！";
                return ;
            }
            WOTMeetingListModel_msg *model = bean;
            tableList = model.msg.list;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (tableList.count) {
                    self.notInformationImageView.hidden = YES;
                    self.notInformationLabel.hidden = YES;
                   [self.table reloadData];
                } else {
                    self.notInformationImageView.hidden = NO;
                    self.notInformationLabel.hidden = NO;
                    self.notInformationLabel.text = @"亲，暂时没有场地哦！";
                }
                [self.table reloadData];
            });
        }];
    }
}


#pragma mark - action
-(void)selectSpace:(UIButton *)sender
{
    WOTSelectWorkspaceListVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSelectWorkspaceListVC"];//1
    __weak typeof(self) weakSelf = self;
    vc.selectSpaceBlock = ^(WOTSpaceModel *model){
        self.spaceModel = model;
        weakSelf.spaceId = model.spaceId;
        weakSelf.spaceName = model.spaceName;
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - table delegate  & dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTReservationsMeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTReservationsMeetingCell" forIndexPath:indexPath];
    if (cell==nil) {
        cell = [[WOTReservationsMeetingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTReservationsMeetingCell"];
    }
    id model = tableList[indexPath.row];
    if ([WOTSingtleton shared].orderType == ORDER_TYPE_MEETING) {
        cell.meetingPriceLab.hidden = YES;
    }
    
    [cell setMeetingModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    WOTReservationsMeetingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self requestSpaceName:cell.meetingModel];
}

#pragma mark - 通过空间id请求空间
-(void)requestSpaceName:(WOTMeetingListModel *)meetingModel
{
    [WOTHTTPNetwork getSpaceFromSpaceID:meetingModel.spaceId bolock:^(id bean, NSError *error) {
         WOTSpaceModel *model = (WOTSpaceModel *)bean;
        if (model.spaceId) {
            dispatch_async(dispatch_get_main_queue(), ^{
                WOTOrderVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTOrderVC"];
                vc.spaceModel = model;
                vc.meetingModel = meetingModel;
                vc.spaceSourceType = SPACE_SOURCE_TYPE_OTHER;
                [self.navigationController pushViewController:vc animated:YES];
            });
        }
    }];
}



@end
