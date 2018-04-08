//
//  WOTNearCirclesVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/21.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTNearCirclesVC.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "WOTSocialContactCell.h"
#import "MJRefresh.h"
#import "WOTFriendsMessageListModel.h"
#import "YMTableViewCell.h"
#import "ContantHead.h"
#import "YMShowImageView.h"
#import "YMTextData.h"
#import "YMReplyInputView.h"
#import "WFReplyBody.h"
#import "WFMessageBody.h"
#import "WFPopView.h"
#import "WFActionSheet.h"
#import "QueryCircleofFriendsModel.h"
#import "WOTUserSingleton.h"
#import "IQKeyboardManager.h"
#import "SKAddReply.h"
#import "SKSingleCirclesViewController.h"
#import "QuerySingleCircleofFriendModel.h"
//#import "CircleofFriendsInfoModel.h"
//#import "ReplyModel.h"

#define dataCount 10
#define kLocationToBottom 20
#define kAdmin @"小虎-tiger"
static const CGFloat MJDuration = 2.0;

typedef NS_ENUM(NSInteger, FDSimulatedCacheMode) {
    FDSimulatedCacheModeNone = 0,
    FDSimulatedCacheModeCacheByIndexPath,
    FDSimulatedCacheModeCacheByKey
};

@interface WOTNearCirclesVC ()<UITableViewDelegate,UITableViewDataSource,cellDelegate,InputDelegate,UIActionSheetDelegate,YMShowImageViewDelegate>{
    NSMutableArray *_imageDataSource;
    
    NSMutableArray *_contentDataSource;//模拟接口给的数据
    
    NSMutableArray *_tableDataSource;//tableview数据源
    
    NSMutableArray *_shuoshuoDatasSource;//说说数据源
    
    UITableView *mainTable;
    
    UIView *popView;
    
    YMReplyInputView *replyView ;
    
    NSInteger _replyIndex;
    
    BOOL _wasKeyboardManagerEnabled;
    
}

@property (nonatomic,strong) WFPopView *operationView;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;
@property (nonatomic,strong) NSMutableArray<CircleofFriendsInfoModel *> *circleofFriendsList;
@property (nonatomic,strong) NSString *replyState;
@property (nonatomic,assign) int pageNum;
@property (nonatomic,assign) BOOL isAttention;
@property (nonatomic,strong) NSMutableArray *arrDLed;
@end

@implementation WOTNearCirclesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNum = 1;
    UIScrollView *scView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = scView;
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableview];
    self.circleofFriendsList = [[NSMutableArray alloc] init];

    //[self configData];
}

#pragma mark -加载数据
- (void)loadTextData{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray * ymDataArray =[[NSMutableArray alloc]init];
        
        for (int i = 0 ; i < _contentDataSource.count; i ++) {
            WFMessageBody *messBody = [_contentDataSource objectAtIndex:i];
            YMTextData *ymData = [[YMTextData alloc] init ];
            ymData.messageBody = messBody;
            [ymDataArray addObject:ymData];
        }
        [self calculateHeight:ymDataArray];
    });
}

#pragma mark - 计算高度
- (void)calculateHeight:(NSMutableArray *)dataArray{
    
    
    NSDate* tmpStartData = [NSDate date];
    
    for (YMTextData *ymData in dataArray) {
        
        ymData.shuoshuoHeight = [ymData calculateShuoshuoHeightWithWidth:self.view.frame.size.width withUnFoldState:NO];//折叠
        
        ymData.unFoldShuoHeight = [ymData calculateShuoshuoHeightWithWidth:self.view.frame.size.width withUnFoldState:YES];//展开
        
        ymData.replyHeight = [ymData calculateReplyHeightWithWidth:self.view.frame.size.width];
        
        ymData.favourHeight = [ymData calculateFavourHeightWithWidth:self.view.frame.size.width];
        
        [_tableDataSource addObject:ymData];
        
    }
    
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@"cost time = %f", deltaTime);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [mainTable reloadData];
    });
}

- (void)backToPre{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void) initTableview{
    
    mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64-48-40)];
    mainTable.backgroundColor = [UIColor clearColor];
    [mainTable registerClass:[YMTableViewCell class] forCellReuseIdentifier:@"ILTableViewCell"];
    mainTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    mainTable.mj_header.automaticallyChangeAlpha = YES;
    [mainTable.mj_header beginRefreshing];
    mainTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    [mainTable setTableFooterView:[UIView new]];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    mainTable.estimatedRowHeight = 0;
    [self.view addSubview:mainTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[SDImageCache sharedImageCache] clearMemory];
//    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
//        
//    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    //[[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}


#pragma mark - 数据源
- (void)configData{
    _tableDataSource = [[NSMutableArray alloc] init];
    _contentDataSource = [[NSMutableArray alloc] init];
    _replyIndex = -1;//代表是直接评论
    for (CircleofFriendsInfoModel *infoModel in self.circleofFriendsList) {
        WFMessageBody *messBody = [[WFMessageBody alloc] init];
        if ([infoModel.circleMessage isKindOfClass:[NSString class]]) {
            NSLog(@"sdfsdsfsf");
        }

        NSLog(@"ok:%@",infoModel.circleMessage);
        messBody.posterContent = infoModel.circleMessage;
        //NSString *httpService = @"http://219.143.170.98:10011/SKwork";
        NSString *httpService = [NSString stringWithFormat:@"%@/SKwork",HTTPBaseURL];
        NSMutableArray *pictureRULArray = [NSMutableArray new];
        NSArray *pictureStrArray = [infoModel.imageMessage componentsSeparatedByString:@","];
        for (NSString *pictureURL in pictureStrArray) {
            if (![pictureURL isEqualToString:@""]) {
                NSString *fullPictureUrl = [httpService stringByAppendingString:pictureURL];
                [pictureRULArray addObject:fullPictureUrl];
            }
        }
        messBody.posterPostImage = pictureRULArray;
        NSMutableArray *replyModelList = [[NSMutableArray alloc] init];
        for (ReplyModel *replyModel in infoModel.ReplyRecord) {
            WFReplyBody *body = [[WFReplyBody alloc] init];
            body.replyUser = replyModel.replyName;
            body.repliedUser = replyModel.byReplyname;
            body.replyInfo = replyModel.replyInfo;
            body.replyUserId = replyModel.replyId;
            body.recordId = replyModel.recordId;
            [replyModelList addObject:body];
        }
        messBody.posterReplies = replyModelList;
        messBody.posterImgstr = infoModel.userUrl;
        messBody.posterName = infoModel.userName;
        messBody.posterIntro = @"";
        messBody.posterFavour = [NSMutableArray new];
        messBody.focusId = infoModel.focusId;
        messBody.isUnfold = NO;
        if ([infoModel.focus isEqualToNumber:@0]) {
            messBody.isFavour = NO;
        }else
        {
            messBody.isFavour = YES;
        }
        
        messBody.friendTime = infoModel.friendTime;
        messBody.issueId = infoModel.userId;
        messBody.friendId = infoModel.friendId;
        [_contentDataSource addObject:messBody];
    }
    
}

#pragma mark - 请求数据
-(void)createRequest
{
    __weak typeof(self) weakSelf = self;
    //先判断是否已经登录
    if ([WOTUserSingleton shareUser].userInfo.spaceId) {
        [WOTHTTPNetwork queryAllCircleofFriendsWithFocusPeopleid:[WOTUserSingleton shareUser].userInfo.userId pageNo:@1 pageSize:@10 response:^(id bean, NSError *error) {
            [weakSelf StopRefresh];
            QueryCircleofFriendsModel *model = (QueryCircleofFriendsModel*)bean;
            [self.circleofFriendsList removeAllObjects];
            [self.circleofFriendsList addObjectsFromArray:model.msg.list];
            if ([model.code isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf configData];
                    [weakSelf loadTextData];
                });
            }
            else
            {
                if ([model.code isEqualToString:@"202"]) {
                    [MBProgressHUDUtil showMessage:@"没有数据！" toView:self.view];
                    return ;
                }else
                {
                    [MBProgressHUDUtil showMessage:@"网络错误！" toView:self.view];
                    return ;
                }
            }
        }];
    } else {
        [MBProgressHUDUtil showMessage:@"请先登录后再查看！" toView:self.view];
    }
}

#pragma mark -- Refresh method
/**
 *  添加下拉刷新事件
 */
//- (void)AddRefreshHeader
//{
//    __weak UITableView *pTableView = _tableView;
//    ///添加刷新事件
//    pTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
//    pTableView.mj_header.automaticallyChangeAlpha = YES;
//}

#pragma mark - 下拉刷新
- (void)StartRefresh
{
    __weak typeof(self) weakSelf = self;
    self.pageNum = 1;
    if (mainTable.mj_footer != nil && [mainTable.mj_footer isRefreshing])
    {
        [mainTable.mj_footer endRefreshing];
    }
    [weakSelf.circleofFriendsList removeAllObjects];
    if ([WOTUserSingleton shareUser].userInfo.spaceId) {
        [WOTHTTPNetwork queryAllCircleofFriendsWithFocusPeopleid:[WOTUserSingleton shareUser].userInfo.userId pageNo:[NSNumber numberWithInt:self.pageNum] pageSize:@10 response:^(id bean, NSError *error) {
            [weakSelf StopRefresh];
            QueryCircleofFriendsModel *model = (QueryCircleofFriendsModel*)bean;
            weakSelf.circleofFriendsList = [[NSMutableArray alloc] initWithArray:model.msg.list];
            if ([model.code isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf configData];
                    [weakSelf loadTextData];
                    [mainTable reloadData];
                    [weakSelf StopRefresh];
                });
            }
            else
            {
                if ([model.code isEqualToString:@"202"]) {
                    [MBProgressHUDUtil showMessage:@"没有数据！" toView:self.view];
                    return ;
                }else
                {
                    [MBProgressHUDUtil showMessage:@"网络错误！" toView:self.view];
                    return ;
                }
            }
        }];
    } else {
        [MBProgressHUDUtil showMessage:@"请先登录后再查看！" toView:self.view];
    }
}

#pragma mark - 停止刷新
- (void)StopRefresh
{
    if (mainTable.mj_header != nil && [mainTable.mj_header isRefreshing])
    {
        [mainTable.mj_header endRefreshing];
    }
}

#pragma mark - 停止刷新
- (void)stoploadMoreTopic
{
    if (mainTable.mj_footer != nil && [mainTable.mj_footer isRefreshing])
    {
        [mainTable.mj_footer endRefreshing];
    }
}

#pragma mark - 上拉刷新
-(void)loadMoreTopic
{
    __weak typeof(self) weakSelf = self;
    self.pageNum++;
    if ([WOTUserSingleton shareUser].userInfo.spaceId) {
        [WOTHTTPNetwork queryAllCircleofFriendsWithFocusPeopleid:[WOTUserSingleton shareUser].userInfo.userId pageNo:[NSNumber numberWithInt:self.pageNum] pageSize:@10 response:^(id bean, NSError *error) {
            [weakSelf StopRefresh];
            QueryCircleofFriendsModel *model = (QueryCircleofFriendsModel*)bean;
            
            
            if ([model.code isEqualToString:@"200"]) {
                [weakSelf.circleofFriendsList addObjectsFromArray:model.msg.list];
                [weakSelf configData];
                [weakSelf loadTextData];
                __weak UITableView *tableView = mainTable;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    // 刷新表格
                    [tableView reloadData];
                    
                    // 拿到当前的上拉刷新控件，结束刷新状态
                    [tableView.mj_footer endRefreshing];
                });
            }
            else
            {
                if ([model.code isEqualToString:@"202"]) {
                    [MBProgressHUDUtil showMessage:@"没有数据！" toView:self.view];
                    return ;
                }else
                {
                    [MBProgressHUDUtil showMessage:@"网络错误！" toView:self.view];
                    return ;
                }
            }
        }];
    } else {
        [MBProgressHUDUtil showMessage:@"请先登录后再查看！" toView:self.view];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _tableDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ILTableViewCell";
    
    YMTableViewCell *cell = (YMTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[YMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
//    if (!cell) {
//        cell = [[YMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.accessoryType  = UITableViewCellAccessoryNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    else{  //重要，释放cell,防止闪退方法，其他CustomCell 均可沿用
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//    }
    
    cell.stamp = indexPath.row;
    cell.replyBtn.appendIndexPath = indexPath;
    [cell.replyBtn addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.delegate = self;
//    if ((mainTable.isDragging || mainTable.isDecelerating) && ![self.arrDLed containsObject:indexPath]) {
//        cell.isShow = NO;
//    }else
//    {
//        cell.isShow = YES;
//    }
    [cell setYMViewWith:[_tableDataSource objectAtIndex:indexPath.row]];//报错有问题
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YMTableViewCell *cell = (YMTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    YMTextData *ym = [_tableDataSource objectAtIndex:indexPath.row];
    BOOL unfold = ym.foldOrNot;
    NSLog(@"行高：%f",TableHeader + kLocationToBottom + ym.replyHeight + ym.showImageHeight  + kDistance + (ym.islessLimit?0:30) + (unfold?ym.shuoshuoHeight:ym.unFoldShuoHeight) + kReplyBtnDistance + ym.favourHeight + (ym.favourHeight == 0?0:kReply_FavourDistance)+20);
    if (ym.replyDataSource.count == 0) {//没有评论，没有数量
        return cell.addTimeLabel.frame.origin.y+cell.addTimeLabel.frame.size.height+10;
    }else if (ym.replyDataSource.count >=  3 )
    {
        return cell.openCommentBtn.frame.origin.y+cell.openCommentBtn.frame.size.height+10;
    }else
    {
        return cell.replyImageView.frame.origin.y+cell.replyImageView.frame.size.height+10;//replyImageView
    }
}

#pragma mark - 评论和关注按钮
- (void)replyAction:(YMButton *)sender{
    //先通过朋友圈id请求这条朋友圈数据
    __weak typeof(self) weakSelf = self;
    CGRect rectInTableView = [mainTable rectForRowAtIndexPath:sender.appendIndexPath];
    CGFloat origin_Y = rectInTableView.origin.y + sender.frame.origin.y;
    CGRect targetRect = CGRectMake(CGRectGetMinX(sender.frame), origin_Y, CGRectGetWidth(sender.bounds), CGRectGetHeight(sender.bounds));
    if (self.operationView.shouldShowed) {
        [self.operationView dismiss];
        return;
    }
    _selectedIndexPath = sender.appendIndexPath;
    YMTextData *ym = [_tableDataSource objectAtIndex:_selectedIndexPath.row];
    [WOTHTTPNetwork querySingleCircleofFriendsWithFriendId:ym.messageBody.friendId userid:[WOTUserSingleton shareUser].userInfo.userId response:^(id bean, NSError *error) {
        QuerySingleCircleofFriendModel *model = (QuerySingleCircleofFriendModel*)bean;
        if ([model.msg.focus isEqualToNumber:@0]) {
            weakSelf.isAttention = NO;
        }else
        {
            weakSelf.isAttention = YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.operationView showAtView:mainTable rect:targetRect isFavour:self.isAttention];
        });
    }];
}

- (WFPopView *)operationView {
    if (!_operationView) {
        _operationView = [WFPopView initailzerWFOperationView];
        WS(ws);
        _operationView.didSelectedOperationCompletion = ^(WFOperationType operationType) {
            switch (operationType) {
                case WFOperationTypeLike:
                    
                    [ws addLike];
                    break;
                case WFOperationTypeReply:
                    [ws replyMessage: nil];
                    break;
                default:
                    break;
            }
        };
    }
    return _operationView;
}

#pragma mark - 加关注
- (void)addLike{
    NSLog(@"加关注");
   // [self createRequest];
    YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:_selectedIndexPath.row];
    WFMessageBody *m = ymData.messageBody;
    [WOTHTTPNetwork querySingleCircleofFriendsWithFriendId:ymData.messageBody.friendId userid:[WOTUserSingleton shareUser].userInfo.userId response:^(id bean, NSError *error) {
        QuerySingleCircleofFriendModel *model = (QuerySingleCircleofFriendModel*)bean;
        if ([model.msg.focus isEqualToNumber:@0]) {
                //执行加关注方法
            m.isFavour = YES;
            [WOTHTTPNetwork addFocusWithfocusPeopleid:[WOTUserSingleton shareUser].userInfo.userId befocusPeopleid:m.issueId response:^(id bean, NSError *error) {
                WOTBaseModel *baseModel = (WOTBaseModel *)bean;
                if ([baseModel.code isEqualToString:@"200"]) {
                    [MBProgressHUDUtil showMessage:@"关注成功！" toView:self.view];
                    //[self createRequest];
                } else {
                    [MBProgressHUDUtil showMessage:@"关注失败！" toView:self.view];
                    
                }
            }];
        } else {
            //执行取消关注方法
            m.isFavour = NO;
            [WOTHTTPNetwork deleteFocusWithFocusId:model.msg.focusId response:^(id bean, NSError *error) {
                WOTBaseModel *baseModel = (WOTBaseModel *)bean;
                if ([baseModel.code isEqualToString:@"200"]) {
                    [MBProgressHUDUtil showMessage:@"取消成功！" toView:self.view];
                    // [self createRequest];
                } else {
                    [MBProgressHUDUtil showMessage:@"取消失败！" toView:self.view];
                }
            }];
        }
    }];
    
    

    ymData.messageBody = m;
    [ymData.attributedDataFavour removeAllObjects];
    //[_tableDataSource replaceObjectAtIndex:_selectedIndexPath.row withObject:ymData];
    [mainTable reloadSections:[NSIndexSet indexSetWithIndex:0]withRowAnimation:UITableViewRowAnimationNone];
    //NSIndexPath *indexPath=[NSIndexPath indexPathForRow:inputTag inSection:0];
//    [UIView animateWithDuration:0 animations:^{
//        [mainTable performBatchUpdates:^{
//            [mainTable reloadData];
//        } completion:nil];
//    }];
//    [UIView setAnimationsEnabled:NO];
//
//    [mainTable performBatchUpdates:^{
//        [mainTable reloadData];
//    } completion:^(BOOL finished) {
//        [UIView setAnimationsEnabled:YES];
//    }];
//    [mainTable performBatchUpdates:^{
//        //[mainTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:_selectedIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//        [mainTable reloadData];
//    }];
    //[mainTable reloadData];
    
}


#pragma mark - 真の评论
- (void)replyMessage:(YMButton *)sender{
    
    if (replyView) {
        return;
    }
    replyView = [[YMReplyInputView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, screenWidth,44) andAboveView:self.view];
    replyView.delegate = self;
    replyView.replyTag = _selectedIndexPath.row;
    [self.view addSubview:replyView];
}


#pragma mark -移除评论按钮
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.operationView dismiss];
    
}


#pragma mark -cellDelegate
- (void)changeFoldState:(YMTextData *)ymD onCellRow:(NSInteger)cellStamp{
    
    [_tableDataSource replaceObjectAtIndex:cellStamp withObject:ymD];
    [mainTable reloadData];
    
}

#pragma mark - 图片点击事件回调
- (void)showImageViewWithImageViews:(NSArray *)imageViews byClickWhich:(NSInteger)clickTag{
    //[UIScreen mainScreen ].applicationFrame
    [self.tabBarController.tabBar setHidden:YES];
    //UIView *maskview = [[UIView alloc] initWithFrame:self.view.bounds];
    UIView *maskview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    maskview.backgroundColor = [UIColor blackColor];
    //[self.view addSubview:maskview];
    [[UIApplication sharedApplication].keyWindow addSubview:maskview];
    YMShowImageView *ymImageV = [[YMShowImageView alloc] initWithFrame:maskview.bounds byClick:clickTag appendArray:imageViews];
    
    ymImageV.delegate = self;
    [ymImageV show:maskview didFinish:^(){
        [UIView animateWithDuration:0.5f animations:^{
            ymImageV.alpha = 0.0f;
            maskview.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [ymImageV removeFromSuperview];
            [maskview removeFromSuperview];
        }];
    }];
}

#pragma mark - 长按评论整块区域的回调
- (void)longClickRichText:(NSInteger)index replyIndex:(NSInteger)replyIndex{
    
    [self.operationView dismiss];
    YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:index];
    WFReplyBody *b = [ymData.messageBody.posterReplies objectAtIndex:replyIndex];
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = b.replyInfo;
    
}

#pragma mark - 点评论整块区域的回调
- (void)clickRichText:(NSInteger)index replyIndex:(NSInteger)replyIndex{
    
    [self.operationView dismiss];
    
    _replyIndex = replyIndex;
    
    YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:index];
    WFReplyBody *b = [ymData.messageBody.posterReplies objectAtIndex:replyIndex];
    if ([b.replyUser isEqualToString:[WOTUserSingleton shareUser].userInfo.userName]) {
        WFActionSheet *actionSheet = [[WFActionSheet alloc] initWithTitle:@"删除评论？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
        actionSheet.actionIndex = index;
        [actionSheet showInView:self.view];
        
    }else{
        //回复
        if (replyView) {
            return;
        }
        replyView = [[YMReplyInputView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, screenWidth,44) andAboveView:self.view];
        replyView.delegate = self;
        replyView.lblPlaceholder.text = [NSString stringWithFormat:@"回复%@:",b.replyUser];
        replyView.replyTag = index;
        [self.view addSubview:replyView];
    }
}

#pragma mark - 评论说说回调
- (void)YMReplyInputWithReply:(NSString *)replyText appendTag:(NSInteger)inputTag{
    SKAddReply *addReply = [[SKAddReply alloc] init];
    YMTextData *ymData = nil;
    if (_replyIndex == -1) {
        self.replyState = @"0";
        WFReplyBody *body = [[WFReplyBody alloc] init];
        body.replyUser = [WOTUserSingleton shareUser].userInfo.userName;
        body.repliedUser = @"";
        body.replyInfo = replyText;
        
        ymData = (YMTextData *)[_tableDataSource objectAtIndex:inputTag];
        WFMessageBody *m = ymData.messageBody;
        [m.posterReplies addObject:body];
        ymData.messageBody = m;
        
        addReply.friendId = ymData.messageBody.friendId;
        addReply.byReplyid = ymData.messageBody.issueId;
        addReply.byReplyname = @"";
        addReply.replyId = [WOTUserSingleton shareUser].userInfo.userId;
        addReply.replyName = [WOTUserSingleton shareUser].userInfo.userName;
        addReply.replyInfo = replyText;
        
    }else{
        self.replyState = @"1";
        ymData = (YMTextData *)[_tableDataSource objectAtIndex:inputTag];
        WFMessageBody *m = ymData.messageBody;
        
        WFReplyBody *body = [[WFReplyBody alloc] init];
        body.replyUser = [WOTUserSingleton shareUser].userInfo.userName;
        body.repliedUser = [(WFReplyBody *)[m.posterReplies objectAtIndex:_replyIndex] replyUser];
        body.replyInfo = replyText;
        
        
        [m.posterReplies addObject:body];
        ymData.messageBody = m;
        
        addReply.friendId = ymData.messageBody.friendId;
        addReply.byReplyid = [(WFReplyBody *)[m.posterReplies objectAtIndex:_replyIndex] replyUserId];
        addReply.byReplyname = [(WFReplyBody *)[m.posterReplies objectAtIndex:_replyIndex] replyUser];
        addReply.replyId = [WOTUserSingleton shareUser].userInfo.userId;
        addReply.replyName = [WOTUserSingleton shareUser].userInfo.userName;
        addReply.replyInfo = replyText;
    }
    NSLog(@"评论信息：%@",addReply.replyInfo);
    if (strIsEmpty(addReply.replyInfo)) {
        [MBProgressHUDUtil showMessage:@"请填写评论信息！" toView:self.view];
        return;
    }
    [WOTHTTPNetwork addReplyWithFriendId:addReply.friendId
                               byReplyid:addReply.byReplyid
                             byReplyname:addReply.byReplyname replyId:addReply.replyId
                               replyName:addReply.replyName
                               replyInfo:addReply.replyInfo
                              replyState:self.replyState
                                response:^(id bean, NSError *error) {
        WOTBaseModel *baseModel = (WOTBaseModel *)bean;
        if ([baseModel.code isEqualToString:@"200"]) {
            [MBProgressHUDUtil showMessage:@"评论成功！" toView:self.view];
            //清空属性数组。否则会重复添加
            [ymData.completionReplySource removeAllObjects];
            [ymData.attributedDataReply removeAllObjects];
            
            
            ymData.replyHeight = [ymData calculateReplyHeightWithWidth:self.view.frame.size.width];
            [_tableDataSource replaceObjectAtIndex:inputTag withObject:ymData];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:inputTag inSection:0];
            [UIView performWithoutAnimation:^{
                [mainTable reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

            }];
            [self createRequest];

        }else if([baseModel.code isEqualToString:@"501"])
        {
            [MBProgressHUDUtil showMessage:@"此条朋友圈已删除" toView:self.view];
            return ;
        }else
        {
            //清空属性数组。否则会重复添加
            [ymData.completionReplySource removeAllObjects];
            [ymData.attributedDataReply removeAllObjects];
            [MBProgressHUDUtil showMessage:@"评论失败！" toView:self.view];
        }
                                    
    }];
}

- (void)destorySelf{
    
    [replyView removeFromSuperview];
    replyView = nil;
    _replyIndex = -1;
    
}

#pragma mark - 删除评论操作
- (void)actionSheet:(WFActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //delete
        
        YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:actionSheet.actionIndex];
        WFMessageBody *m = ymData.messageBody;
        WFReplyBody *body  = m.posterReplies[_replyIndex];
        [WOTHTTPNetwork deleteReplyRecorWithRecordId:body.recordId response:^(id bean, NSError *error) {
            WOTBaseModel *baseModel = (WOTBaseModel *)bean;
            if ([baseModel.code isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUDUtil showMessage:@"删除成功！" toView:self.view];
                    [m.posterReplies removeObjectAtIndex:_replyIndex];
                    ymData.messageBody = m;
                    [ymData.completionReplySource removeAllObjects];
                    [ymData.attributedDataReply removeAllObjects];
                    
                    
                    ymData.replyHeight = [ymData calculateReplyHeightWithWidth:self.view.frame.size.width];
                    [_tableDataSource replaceObjectAtIndex:actionSheet.actionIndex withObject:ymData];
                    
                    [mainTable reloadData];
                });
            }
            else
            {
                [MBProgressHUDUtil showMessage:@"删除失败！" toView:self.view];
                _replyIndex = -1;
            }
        }];
       
        
    }else{
        _replyIndex = -1;
    }
    
}

-(void)updateDeleteComment
{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self StartRefresh];
    //[self createRequest];
}

#pragma mark - 点击更多评论进入单条朋友圈
- (void)showCommentWith:(YMTextData *)ymD onCellRow:(NSInteger) cellStamp
{
    //NSLog(@"打开评论");
    SKSingleCirclesViewController *singleVC = [[SKSingleCirclesViewController alloc]init];
    singleVC.hidesBottomBarWhenPushed = YES;
    singleVC.friendId = ymD.messageBody.friendId;
    [self.navigationController pushViewController:singleVC animated:YES];
}

#pragma mark - 删除朋友圈
-(void)deleteCircleofFriendsWith:(YMTextData *)ymD onCellRow:(NSInteger)cellStamp
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否删除此条朋友圈？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [WOTHTTPNetwork deleteCircleofFriendsWithFriendId:ymD.messageBody.friendId response:^(id bean, NSError *error) {
            WOTBaseModel *model = (WOTBaseModel *)bean;
            if ([model.code isEqualToString:@"200"]) {
                [_tableDataSource removeObjectAtIndex:cellStamp];
                [mainTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:cellStamp inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }else
            {
                [MBProgressHUDUtil showMessage:@"删除失败！" toView:self.view];
                return ;
            }
        }];
   
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - YMShowImageViewDelegate
-(void)showTarbar
{
    [self.tabBarController.tabBar setHidden:NO];
}

//************************优化图片start***********************
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (!decelerate) {
//        [self reload];
//    }
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [self reload];
//}
//
//-(void)reload
//{
//    NSArray *arr = [mainTable indexPathsForVisibleRows];
//    NSMutableArray *arrToReload = [NSMutableArray array];
//    for (NSIndexPath *indexPath in  arr) {
//        if (![self.arrDLed containsObject:indexPath]) {
//            [arrToReload addObject:indexPath];
//        }
//    }
//    [mainTable reloadRowsAtIndexPaths:arrToReload withRowAnimation:UITableViewRowAnimationFade];
//}
//-(NSMutableArray *)arrDLed
//{
//    if (_arrDLed == nil) {
//        _arrDLed = [[NSMutableArray alloc] init];
//    }
//    return _arrDLed;
//}
//************************优化图片end***********************

@end
