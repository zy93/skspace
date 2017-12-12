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

@interface WOTNearCirclesVC ()<UITableViewDelegate,UITableViewDataSource,cellDelegate,InputDelegate,UIActionSheetDelegate>{
    NSMutableArray *_imageDataSource;
    
    NSMutableArray *_contentDataSource;//模拟接口给的数据
    
    NSMutableArray *_tableDataSource;//tableview数据源
    
    NSMutableArray *_shuoshuoDatasSource;//说说数据源
    
    UITableView *mainTable;
    
    UIView *popView;
    
    YMReplyInputView *replyView ;
    
    NSInteger _replyIndex;
    
}

//@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) WFPopView *operationView;
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;
@property (nonatomic,strong) NSMutableArray<CircleofFriendsInfoModel *> *circleofFriendsList;
//@property (nonatomic,strong) NSMutableArray<ReplyModel *> *replyModelArray;

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
    _tableDataSource = [[NSMutableArray alloc] init];
    _contentDataSource = [[NSMutableArray alloc] init];
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableview];
    [self createRequest];
    
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
    [self.view addSubview:mainTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark - 数据源
- (void)configData{
    
    _replyIndex = -1;//代表是直接评论

//    WFReplyBody *body1 = [[WFReplyBody alloc] init];
//    body1.replyUser = kAdmin;
//    body1.repliedUser = @"红领巾";
//    body1.replyInfo = kContentText1;
//
//
//    WFReplyBody *body2 = [[WFReplyBody alloc] init];
//    body2.replyUser = @"迪恩";
//    body2.repliedUser = @"";
//    body2.replyInfo = kContentText2;
//
//
//    WFReplyBody *body3 = [[WFReplyBody alloc] init];
//    body3.replyUser = @"山姆";
//    body3.repliedUser = @"";
//    body3.replyInfo = kContentText3;
//
//
//    WFReplyBody *body4 = [[WFReplyBody alloc] init];
//    body4.replyUser = @"雷锋";
//    body4.repliedUser = @"简森·阿克斯";
//    body4.replyInfo = kContentText4;
//
//
//    WFReplyBody *body5 = [[WFReplyBody alloc] init];
//    body5.replyUser = kAdmin;
//    body5.repliedUser = @"";
//    body5.replyInfo = kContentText5;
//
//
//    WFReplyBody *body6 = [[WFReplyBody alloc] init];
//    body6.replyUser = @"红领巾";
//    body6.repliedUser = @"";
//    body6.replyInfo = kContentText6;
//
//
//    WFMessageBody *messBody1 = [[WFMessageBody alloc] init];
//    messBody1.posterContent = kShuoshuoText1;
//    messBody1.posterPostImage = @[@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=3631486a793771845ad437b1f7e6ca6c&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F4a36acaf2edda3ccd54348cf0be93901203f92be.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=9192c5ba55a497a171d0ea3954f3117e&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fcrop%253D0%252C0%252C640%252C405%2Fsign%3D3ba608d54136acaf4dafccbc41e9a120%2F4a36acaf2edda3cc8c90f3cc0be93901203f92e2.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071839&di=a4088bd915b33e68e7c2afb2552de365&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fcrop%253D0%252C0%252C640%252C405%2Fsign%3D7ba8ce2314178a82da7325e0cb335fbd%2F1f178a82b9014a900f8d7252a3773912b21beeaa.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635072076&di=d8b48489c2b646267fb5410948520a0a&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F72f082025aafa40f368b9133a164034f79f0198a.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635072075&di=ccaa4e5e6064877aa0d48f08550d2c18&imgtype=0&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Ffaf2b2119313b07e949e9bda06d7912396dd8cc5.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635072601&di=5f56a0c97d1d5e0ce77a937e3bc5eec1&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Ffd039245d688d43f37f5b120771ed21b0ff43b87.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635072600&di=7fd4ce9538d6a12db1363af5ccf34969&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F3bf33a87e950352a639fa0e35943fbf2b3118b5b.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635072600&di=d97ab6a72c6b0ef7771fc254b2428d2b&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fbd315c6034a85edffd03e8cb43540923dc54754e.jpg"];
//    messBody1.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4, nil];
//    messBody1.posterImgstr = @"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg";
//    messBody1.posterName = @"迪恩·温彻斯特";
//    messBody1.posterIntro = @"这个人很懒，什么都没有留下";
//    messBody1.posterFavour = [NSMutableArray new];
//    messBody1.isFavour = YES;
//
//    WFMessageBody *messBody2 = [[WFMessageBody alloc] init];
//    messBody2.posterContent = kShuoshuoText1;
//    messBody2.posterPostImage = @[@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=3631486a793771845ad437b1f7e6ca6c&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F4a36acaf2edda3ccd54348cf0be93901203f92be.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=9192c5ba55a497a171d0ea3954f3117e&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fcrop%253D0%252C0%252C640%252C405%2Fsign%3D3ba608d54136acaf4dafccbc41e9a120%2F4a36acaf2edda3cc8c90f3cc0be93901203f92e2.jpg"];
//    messBody2.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4, nil];
//    messBody2.posterImgstr = @"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg";
//    messBody2.posterName = @"山姆·温彻斯特";
//    //messBody2.posterIntro = @"这个人很懒，什么都没有留下";
//    messBody2.posterFavour = [NSMutableArray new];
//    messBody2.isFavour = NO;
//
//
//    WFMessageBody *messBody3 = [[WFMessageBody alloc] init];
//    messBody3.posterContent = kShuoshuoText3;
//    messBody3.posterPostImage = @[@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=3631486a793771845ad437b1f7e6ca6c&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F4a36acaf2edda3ccd54348cf0be93901203f92be.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=9192c5ba55a497a171d0ea3954f3117e&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fcrop%253D0%252C0%252C640%252C405%2Fsign%3D3ba608d54136acaf4dafccbc41e9a120%2F4a36acaf2edda3cc8c90f3cc0be93901203f92e2.jpg"];
//    messBody3.posterReplies = [NSMutableArray arrayWithObjects:body1,body2,body4,body6,body5,body4, nil];
//    messBody3.posterImgstr = @"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg";
//    messBody3.posterName = @"伊利丹怒风";
//    messBody3.posterIntro = @"这个人很懒，什么都没有留下";
//    messBody3.posterFavour = [NSMutableArray new];
//    messBody3.isFavour = YES;
//
//    WFMessageBody *messBody4 = [[WFMessageBody alloc] init];
//    messBody4.posterContent = kShuoshuoText4;
//    messBody4.posterPostImage = @[@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=3631486a793771845ad437b1f7e6ca6c&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F4a36acaf2edda3ccd54348cf0be93901203f92be.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=9192c5ba55a497a171d0ea3954f3117e&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fcrop%253D0%252C0%252C640%252C405%2Fsign%3D3ba608d54136acaf4dafccbc41e9a120%2F4a36acaf2edda3cc8c90f3cc0be93901203f92e2.jpg"];
//    messBody4.posterReplies = [NSMutableArray arrayWithObjects:body1, nil];
//    messBody4.posterImgstr = @"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg";
//    messBody4.posterName = @"基尔加丹";
//    messBody4.posterIntro = @"这个人很懒，什么都没有留下";
//    messBody4.posterFavour = [NSMutableArray new];
//    messBody4.isFavour = NO;
//
//    WFMessageBody *messBody5 = [[WFMessageBody alloc] init];
//    messBody5.posterContent = kShuoshuoText5;
//    messBody5.posterPostImage = @[@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=3631486a793771845ad437b1f7e6ca6c&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F4a36acaf2edda3ccd54348cf0be93901203f92be.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=9192c5ba55a497a171d0ea3954f3117e&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fcrop%253D0%252C0%252C640%252C405%2Fsign%3D3ba608d54136acaf4dafccbc41e9a120%2F4a36acaf2edda3cc8c90f3cc0be93901203f92e2.jpg"];
//    messBody5.posterReplies = [NSMutableArray arrayWithObjects:body2,body4,body5, nil];
//    messBody5.posterImgstr = @"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg";
//    messBody5.posterName = @"阿克蒙德";
//    messBody5.posterIntro = @"这个人很懒，什么都没有留下";
//    messBody5.posterFavour = [NSMutableArray new];
//    messBody5.isFavour = NO;
//
//    WFMessageBody *messBody6 = [[WFMessageBody alloc] init];
//    messBody6.posterContent = kShuoshuoText5;
//    messBody6.posterPostImage = @[@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=3631486a793771845ad437b1f7e6ca6c&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F4a36acaf2edda3ccd54348cf0be93901203f92be.jpg",
//
//                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1512635071840&di=9192c5ba55a497a171d0ea3954f3117e&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fcrop%253D0%252C0%252C640%252C405%2Fsign%3D3ba608d54136acaf4dafccbc41e9a120%2F4a36acaf2edda3cc8c90f3cc0be93901203f92e2.jpg"];
//    messBody6.posterReplies = [NSMutableArray arrayWithObjects:body2,body4,body5,body4,body6, nil];
//    messBody6.posterImgstr = @"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D220/sign=b53348899eeef01f52141fc7d0fc99e0/fd039245d688d43f8628601f771ed21b0ff43b5d.jpg";
//    messBody6.posterName = @"红领巾";
//    messBody6.posterIntro = @"这个人很懒，什么都没有留下";
//    messBody6.posterFavour = [NSMutableArray new];
//    messBody6.isFavour = NO;
//
//
//    [_contentDataSource addObject:messBody1];
//    [_contentDataSource addObject:messBody2];
//    [_contentDataSource addObject:messBody3];
//    [_contentDataSource addObject:messBody4];
//    [_contentDataSource addObject:messBody5];
//    [_contentDataSource addObject:messBody6];
    //[self initTableview];
    //[mainTable reloadData];
    //NSLog(@"测试：%@",self.circleofFriendsList[0].circleMessage);
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
            [replyModelList addObject:body];
        }
        messBody.posterReplies = replyModelList;
        messBody.posterImgstr = infoModel.userUrl;
        messBody.posterName = infoModel.userName;
        messBody.posterIntro = @"";
        messBody.posterFavour = [NSMutableArray new];
        if ([infoModel.focus isEqualToNumber:@0]) {
            messBody.isFavour = NO;
        }else
        {
            messBody.isFavour = YES;
        }
        
        messBody.friendTime = infoModel.friendTime;
        [_contentDataSource addObject:messBody];
    }
    
}

#pragma mark - 请求数据
-(void)createRequest
{
    //先判断是否已经登录
    
    if ([WOTUserSingleton shareUser].userInfo.spaceId) {
        [WOTHTTPNetwork queryAllCircleofFriendsWithFocusPeopleid:[WOTUserSingleton shareUser].userInfo.userId pageNo:@1 pageSize:@1000 response:^(id bean, NSError *error) {
            [self StopRefresh];
            QueryCircleofFriendsModel *model = (QueryCircleofFriendsModel*)bean;
            self.circleofFriendsList = [[NSMutableArray alloc] initWithArray:model.msg.list];
            //model.msg.list;
            [self configData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self configData];
                [self loadTextData];
                [mainTable reloadData];
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

#pragma mark - 赞
- (void)addLike{
    
    YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:_selectedIndexPath.row];
    WFMessageBody *m = ymData.messageBody;
    if (m.isFavour == YES) {//此时该取消赞
        [m.posterFavour removeObject:kAdmin];
        m.isFavour = NO;
    }else{
        [m.posterFavour addObject:kAdmin];
        m.isFavour = YES;
    }
    ymData.messageBody = m;
    
    
    //清空属性数组。否则会重复添加
    
    [ymData.attributedDataFavour removeAllObjects];
    
    
    ymData.favourHeight = [ymData calculateFavourHeightWithWidth:self.view.frame.size.width];
    [_tableDataSource replaceObjectAtIndex:_selectedIndexPath.row withObject:ymData];
    
    [mainTable reloadData];
    
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
    
    UIView *maskview = [[UIView alloc] initWithFrame:self.view.bounds];
    maskview.backgroundColor = [UIColor blackColor];
    [self.view addSubview:maskview];
    
    YMShowImageView *ymImageV = [[YMShowImageView alloc] initWithFrame:self.view.bounds byClick:clickTag appendArray:imageViews];
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
    if ([b.replyUser isEqualToString:kAdmin]) {
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
    
    YMTextData *ymData = nil;
    if (_replyIndex == -1) {
        
        WFReplyBody *body = [[WFReplyBody alloc] init];
        body.replyUser = kAdmin;
        body.repliedUser = @"";
        body.replyInfo = replyText;
        
        ymData = (YMTextData *)[_tableDataSource objectAtIndex:inputTag];
        WFMessageBody *m = ymData.messageBody;
        [m.posterReplies addObject:body];
        ymData.messageBody = m;
    }else{
        
        ymData = (YMTextData *)[_tableDataSource objectAtIndex:inputTag];
        WFMessageBody *m = ymData.messageBody;
        
        WFReplyBody *body = [[WFReplyBody alloc] init];
        body.replyUser = kAdmin;
        body.repliedUser = [(WFReplyBody *)[m.posterReplies objectAtIndex:_replyIndex] replyUser];
        body.replyInfo = replyText;
        
        [m.posterReplies addObject:body];
        ymData.messageBody = m;
        
    }
    
    
    
    //清空属性数组。否则会重复添加
    [ymData.completionReplySource removeAllObjects];
    [ymData.attributedDataReply removeAllObjects];
    
    
    ymData.replyHeight = [ymData calculateReplyHeightWithWidth:self.view.frame.size.width];
    [_tableDataSource replaceObjectAtIndex:inputTag withObject:ymData];
    
    [mainTable reloadData];
    
}

- (void)destorySelf{
    
    [replyView removeFromSuperview];
    replyView = nil;
    _replyIndex = -1;
    
}

- (void)actionSheet:(WFActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //delete
        YMTextData *ymData = (YMTextData *)[_tableDataSource objectAtIndex:actionSheet.actionIndex];
        WFMessageBody *m = ymData.messageBody;
        [m.posterReplies removeObjectAtIndex:_replyIndex];
        ymData.messageBody = m;
        [ymData.completionReplySource removeAllObjects];
        [ymData.attributedDataReply removeAllObjects];
        
        
        ymData.replyHeight = [ymData calculateReplyHeightWithWidth:self.view.frame.size.width];
        [_tableDataSource replaceObjectAtIndex:actionSheet.actionIndex withObject:ymData];
        
        [mainTable reloadData];
        
    }else{
        
    }
    _replyIndex = -1;
}

//- (void)dealloc{
//    
//    NSLog(@"销毁");
//    
//}

@end
