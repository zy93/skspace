//
//  SKCommentViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKCommentViewController.h"
#import "Masonry.h"
#import "SKCommentTableViewCell.h"
#import "WOTHTTPNetwork.h"
#import "WOTUserSingleton.h"
#import "QueryCommentModel.h"
#import "QueryCommentModel_msg.h"
#import "UIImageView+WebCache.h"
#import "SKSingleCirclesViewController.h"
#import "MJRefresh.h"


@interface SKCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *commentTableView;

@property (nonatomic, strong) NSMutableArray <CommentModel *>*commentList;

@property (nonatomic,strong)UIImageView *notInfoImageView;
@property (nonatomic,strong)UILabel *notInfoLabel;

@end

@implementation SKCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.commentList = [[NSMutableArray alloc] init];
    self.commentTableView = [[UITableView alloc] init];
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    //self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.commentTableView.mj_header beginRefreshing];
    self.commentTableView.tableFooterView = [UIView new] ;
    [self.view addSubview:self.commentTableView];
    //[self requestCommentData];
    
    self.notInfoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NotInformation"]];
    self.notInfoImageView.hidden = YES;
    [self.view addSubview:self.notInfoImageView];
    
    self.notInfoLabel = [[UILabel alloc] init];
    self.notInfoLabel.hidden = YES;
    self.notInfoLabel.text = @"亲,暂时没有评论！";
    self.notInfoLabel.textColor = [UIColor colorWithRed:145/255.f green:145/255.f blue:145/255.f alpha:1.f];
    self.notInfoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.notInfoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.notInfoLabel];
}

-(void)viewDidLayoutSubviews
{
    [self.commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-48);
    }];
    [self.notInfoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-50);
        make.height.width.mas_offset(70);
    }];
    
    [self.notInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.notInfoImageView.mas_bottom).with.offset(10);
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"CELL";
    SKCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell= (SKCommentTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"SKCommentTableViewCell" owner:self options:nil]  lastObject];
    }
    NSString *httpService = [NSString stringWithFormat:@"%@/SKwork",HTTPBaseURL];
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpService,self.commentList[indexPath.row].userUrl]] placeholderImage:[UIImage imageNamed:@"defaultHeaderVIew"]];
    cell.commentatorLabel.text = self.commentList[indexPath.row].ReplyRecord.replyName;
    
    NSString *replyStr = [NSString stringWithFormat:@"回复%@: %@",[WOTUserSingleton shareUser].userInfo.userName,self.commentList[indexPath.row].ReplyRecord.replyInfo];
    //cell.commentInfoLabel.text = replyStr;
    [cell.infoTextView setOldString:replyStr andNewString:replyStr];

    //self.commentList[indexPath.row].ReplyRecord.replyInfo;
    cell.timeLabel.text = [self intervalSinceNow:self.commentList[indexPath.row].ReplyRecord.replyTime];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKSingleCirclesViewController *singleVC = [[SKSingleCirclesViewController alloc]init];
    singleVC.hidesBottomBarWhenPushed = YES;
    singleVC.friendId = self.commentList[indexPath.row].ReplyRecord.friendId;
    [self.navigationController pushViewController:singleVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestCommentData];
    
}

-(void)requestCommentData
{
    if ([WOTUserSingleton shareUser].userInfo.userId == nil) {
        [MBProgressHUDUtil showMessage:@"请先登录再查看" toView:self.view];
        return;
    }
    if (self.commentList.count > 0) {
        [self.commentList removeAllObjects];
    }
    [WOTHTTPNetwork queryMyCircleofFriendsCommentWithbyReplyid:[WOTUserSingleton shareUser].userInfo.userId pageNo:@1 pageSize:@1000 response:^(id bean, NSError *error) {
        QueryCommentModel *commentModel = (QueryCommentModel *)bean;
        if ([commentModel.code isEqualToString:@"200"]) {
            self.notInfoImageView.hidden = YES;
            self.notInfoLabel.hidden = YES;
            QueryCommentModel_msg *commentModel_msg = commentModel.msg;
            self.commentList = [[NSMutableArray alloc] initWithArray:commentModel_msg.list];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.commentTableView reloadData];
            });
            if (self.commentList.count == 0) {
                self.notInfoImageView.hidden = NO;
                self.notInfoLabel.hidden = NO;
                [MBProgressHUDUtil showMessage:@"没有评论！" toView:self.view];
                return ;
            }
        }else
        {
            self.notInfoImageView.hidden = NO;
            self.notInfoLabel.hidden = NO;
            [MBProgressHUDUtil showMessage:@"网络错误！" toView:self.view];
            return ;
        }
    }];
}

-(void)loadNewData
{
    [self requestCommentData];
    [self.commentTableView reloadData];
    [self.commentTableView.mj_header endRefreshing];
}

#pragma mark - 计算评论时间与当前时间差
- (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
    theDate=[timeArray objectAtIndex:0];
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分前", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [self cutOutString:theDate];
        
    }
    return timeString;
}

#pragma mark - 截取字符串--保留年、月、日
-(NSString *)cutOutString:(NSString *)timeString
{
    NSString *str = [timeString substringToIndex:11];
    NSLog(@"截取的值为：%@",str);
    return str;
}

@end
