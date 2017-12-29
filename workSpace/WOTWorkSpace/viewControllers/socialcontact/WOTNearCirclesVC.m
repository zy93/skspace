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
//#import "CircleofFriendsInfoModel.h"
//#import "ReplyModel.h"

#define dataCount 10
#define kLocationToBottom 20
#define kAdmin @"小虎-tiger"


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

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) WFPopView *operationView;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;
@property (nonatomic,strong) NSMutableArray<CircleofFriendsInfoModel *> *circleofFriendsList;
@property (nonatomic,strong) NSString *replyState;
//@property (nonatomic,strong) WFMessageBody *selectMessage;

@end

@implementation WOTNearCirclesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //[_tableView registerNib:[UINib nibWithNibName:@"WOTSocialContactCell" bundle:nil] forCellReuseIdentifier:@"WOTSocialContactCellID"];
    //[self AddRefreshHeader];
    // Do any additional setup after loading the view.
    //解决布局空白问题
    //self.circleofFriendsList = [[NSMutableArray alloc] init];
    //self.replyModelArray = [[NSMutableArray alloc] init];
    
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableview];
    
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
    // mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(StartRefresh)];
    mainTable.mj_header.automaticallyChangeAlpha = YES;
    mainTable.delegate = self;
    mainTable.dataSource = self;
    mainTable.estimatedRowHeight = 0;

    [self.view addSubview:mainTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSString *httpService = @"http://219.143.170.98:10011/SKwork";
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
    //先判断是否已经登录
    [self.circleofFriendsList removeAllObjects];
    if ([WOTUserSingleton shareUser].userInfo.spaceId) {
        [WOTHTTPNetwork queryAllCircleofFriendsWithFocusPeopleid:[WOTUserSingleton shareUser].userInfo.userId pageNo:@1 pageSize:@1000 response:^(id bean, NSError *error) {
            [self StopRefresh];
            QueryCircleofFriendsModel *model = (QueryCircleofFriendsModel*)bean;
            self.circleofFriendsList = [[NSMutableArray alloc] initWithArray:model.msg.list];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self configData];
                [self loadTextData];
            });
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

- (void)StartRefresh
{
    if (mainTable.mj_footer != nil && [mainTable.mj_footer isRefreshing])
    {
        [mainTable.mj_footer endRefreshing];
    }
    [self createRequest];
}

- (void)StopRefresh
{
    if (mainTable.mj_header != nil && [mainTable.mj_header isRefreshing])
    {
        [mainTable.mj_header endRefreshing];
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
    cell.stamp = indexPath.row;
    cell.replyBtn.appendIndexPath = indexPath;
    [cell.replyBtn addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.delegate = self;
    [cell setYMViewWith:[_tableDataSource objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YMTextData *ym = [_tableDataSource objectAtIndex:indexPath.row];
    BOOL unfold = ym.foldOrNot;
    NSLog(@"行高：%f",TableHeader + kLocationToBottom + ym.replyHeight + ym.showImageHeight  + kDistance + (ym.islessLimit?0:30) + (unfold?ym.shuoshuoHeight:ym.unFoldShuoHeight) + kReplyBtnDistance + ym.favourHeight + (ym.favourHeight == 0?0:kReply_FavourDistance)+20);
    return TableHeader + kLocationToBottom + ym.replyHeight + ym.showImageHeight  + kDistance + (ym.islessLimit?0:30) + (unfold?ym.shuoshuoHeight:ym.unFoldShuoHeight) + kReplyBtnDistance + ym.favourHeight + (ym.favourHeight == 0?0:kReply_FavourDistance)+20;
}
#pragma mark - 按钮动画

- (void)replyAction:(YMButton *)sender{
    
    CGRect rectInTableView = [mainTable rectForRowAtIndexPath:sender.appendIndexPath];
    CGFloat origin_Y = rectInTableView.origin.y + sender.frame.origin.y;
    CGRect targetRect = CGRectMake(CGRectGetMinX(sender.frame), origin_Y, CGRectGetWidth(sender.bounds), CGRectGetHeight(sender.bounds));
    if (self.operationView.shouldShowed) {
        [self.operationView dismiss];
        return;
    }
    _selectedIndexPath = sender.appendIndexPath;
    YMTextData *ym = [_tableDataSource objectAtIndex:_selectedIndexPath.row];
    //self.selectMessage = ym.messageBody;
    [self.operationView showAtView:mainTable rect:targetRect isFavour:ym.hasFavour];
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
    YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:_selectedIndexPath.row];
    WFMessageBody *m = ymData.messageBody;
    if (!m.isFavour) {
        //执行加关注方法
        m.isFavour = YES;
        [WOTHTTPNetwork addFocusWithfocusPeopleid:[WOTUserSingleton shareUser].userInfo.userId befocusPeopleid:m.issueId response:^(id bean, NSError *error) {
            WOTBaseModel *baseModel = (WOTBaseModel *)bean;
            if ([baseModel.code isEqualToString:@"200"]) {
                [MBProgressHUDUtil showMessage:@"关注成功！" toView:self.view];
                [self createRequest];
            } else {
                [MBProgressHUDUtil showMessage:@"关注失败！" toView:self.view];
               
            }
        }];
    } else {
        //执行取消关注方法
        m.isFavour = NO;
        [WOTHTTPNetwork deleteFocusWithFocusId:m.focusId response:^(id bean, NSError *error) {
            WOTBaseModel *baseModel = (WOTBaseModel *)bean;
            if ([baseModel.code isEqualToString:@"200"]) {
                [MBProgressHUDUtil showMessage:@"取消成功！" toView:self.view];
                 [self createRequest];
            } else {
                [MBProgressHUDUtil showMessage:@"取消失败！" toView:self.view];
            }
        }];
    }

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
    UIView *maskview = [[UIView alloc] initWithFrame:self.view.bounds];
    maskview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:maskview];
    YMShowImageView *ymImageV = [[YMShowImageView alloc] initWithFrame:self.view.bounds byClick:clickTag appendArray:imageViews];
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
            }
        }];
       
        
    }else{
        
    }
    //_replyIndex = -1;
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
    [self createRequest];
}

- (void)showCommentWith:(YMTextData *)ymD onCellRow:(NSInteger) cellStamp
{
    //NSLog(@"打开评论");
    SKSingleCirclesViewController *singleVC = [[SKSingleCirclesViewController alloc]init];
    singleVC.friendId = ymD.messageBody.friendId;
    [self.navigationController pushViewController:singleVC animated:YES];
    
}

#pragma mark - YMShowImageViewDelegate
-(void)showTarbar
{
    [self.tabBarController.tabBar setHidden:NO];
}

//- (void)dealloc{
//    
//    NSLog(@"销毁");
//    
//}

@end
