//
//  SKSpaceDetailsVC.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/2/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKSpaceDetailsVC.h"
#import "SKTtileView.h"
#import "SKSpaceSiteView.h"
#import "SKSpaceInfoModel.h"
#import "NSArray+ImageArray.h"
#import "WOTVisitorsResultVC.h"
#import "WOTVisitorsAppointmentVC.h"

@interface SKSpaceDetailsVC ()<SDCycleScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *constView;
@property(nonatomic,strong)UIView *spaceDetailView;
@property(nonatomic,strong)SDCycleScrollView *headImageScrollView;
@property(nonatomic,strong)UILabel *spaceNameLabel;
@property(nonatomic,strong)UILabel *spaceTelLabel;
@property(nonatomic,strong)UILabel *spaceAddressLabel;
@property(nonatomic,strong)SKTtileView *titleView;
@property(nonatomic,strong)UILabel *spaceIntroduceLabel;
@property(nonatomic,strong)SKTtileView *serviceTitleView;
@property(nonatomic,strong)SKSpaceSiteView *bookStationView;
@property(nonatomic,strong)SKSpaceSiteView *siteView;
@property(nonatomic,strong)SKSpaceSiteView *meetingView;
@property(nonatomic,strong)NSArray *spaceImageArray;
@property(nonatomic,strong)UIButton *bottomButton;
@property(nonatomic,strong)SKSpaceInfoModel *model;

@end

@implementation SKSpaceDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"空间信息";
    [self querySpaceInfo];
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.constView];
    [self.scrollView addSubview:self.headImageScrollView];
    [self.scrollView addSubview:self.spaceDetailView];
    [self.spaceDetailView addSubview:self.spaceNameLabel];
    [self.spaceDetailView addSubview:self.spaceTelLabel];
    [self.spaceDetailView addSubview:self.spaceAddressLabel];
    [self.scrollView addSubview:self.titleView];
    [self.scrollView addSubview:self.spaceIntroduceLabel];
    [self.scrollView addSubview:self.serviceTitleView];
    [self.scrollView addSubview:self.bookStationView];
    [self.scrollView addSubview:self.siteView];
    [self.scrollView addSubview:self.meetingView];
    [self.scrollView addSubview:self.bottomButton];
    [self layoutSubviews];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)layoutSubviews
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.bottom.equalTo(self.bottomButton.mas_bottom).with.offset(15);
    }];
    
    [self.constView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.height.equalTo(self.scrollView);
    }];
    
    [self.headImageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.mas_offset(180);
    }];
    
    [self.spaceDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageScrollView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.mas_offset(70);
    }];
    
    [self.spaceNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spaceDetailView).with.offset(5);
        make.left.equalTo(self.spaceDetailView).with.offset(10);
    }];
    
    [self.spaceTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spaceNameLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.spaceDetailView).with.offset(10);
    }];
    
    [self.spaceAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spaceTelLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.spaceDetailView).with.offset(10);
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spaceDetailView.mas_bottom);
        make.width.equalTo(self.scrollView);
        make.height.mas_offset(30);
    }];
    
    [self.spaceIntroduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.left.equalTo(self.scrollView).with.offset(10);
        make.right.equalTo(self.scrollView).with.offset(-10);
        make.height.mas_offset(20);
    }];
    
    [self.serviceTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spaceIntroduceLabel.mas_bottom);
        make.width.equalTo(self.scrollView);
        make.height.mas_offset(30);
    }];
    
    [self.bookStationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceTitleView.mas_bottom);
        make.left.equalTo(self.scrollView).with.offset(10);
        make.right.equalTo(self.scrollView).with.offset(-10);
        make.height.mas_offset(100);
    }];
    
    [self.siteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookStationView.mas_bottom);
        make.left.equalTo(self.scrollView).with.offset(10);
        make.right.equalTo(self.scrollView).with.offset(-10);
        make.height.mas_offset(100);
    }];
    
    [self.meetingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.siteView.mas_bottom);
        make.left.equalTo(self.scrollView).with.offset(10);
        make.right.equalTo(self.scrollView).with.offset(-10);
        make.height.mas_offset(100);
    }];
    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.meetingView.mas_bottom).with.offset(10);
        make.right.equalTo(self.scrollView).with.offset(-10);
        make.width.mas_offset(80);
        make.height.mas_offset(30);
    }];
    
    
}

#pragma mark - 预约参观
-(void)visitMethod
{
    WOTVisitorsAppointmentVC *visitorsAppointmentVC =[[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTVisitorsAppointmentVC"];
    [self.navigationController pushViewController:visitorsAppointmentVC animated:YES];
}

#pragma mark - 查询空间信息
-(void)querySpaceInfo
{
    [WOTHTTPNetwork getSpaceInfoWithSpaceId:self.spaceModel.spaceId response:^(id bean, NSError *error) {
        SKSpaceInfoModel_msg *model_msg = (SKSpaceInfoModel_msg *)bean;
        
        if ([model_msg.code isEqualToString:@"200"]) {
            self.model = model_msg.msg;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_bookStationView setDataWith:[NSString stringWithFormat:@"%@个",self.model.stationNum]
                                  moneyString:[NSString stringWithFormat:@"%@元/天",self.model.stationPrice]
                                     imageUrl:[self.spaceImageArray firstObject]];
                
                [_siteView setDataWith:[NSString stringWithFormat:@"%@个",self.model.siteNum]
                                  moneyString:[NSString stringWithFormat:@"%@元/天",self.model.sitePrice]
                                     imageUrl:[[NSArray imageArrayWithString:self.model.sitePicture] firstObject]];
                
                [_meetingView setDataWith:[NSString stringWithFormat:@"%@个",self.model.conferenceNum]
                                  moneyString:[NSString stringWithFormat:@"%@元/天",self.model.conferencePrice]
                                     imageUrl:[[NSArray imageArrayWithString:self.model.conferencePicture] firstObject]];
            });
            
        }
        else
        {
            [MBProgressHUDUtil showMessage:@"空间信息加载失败！" toView:self.view];
        }
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        //_scrollView.backgroundColor = [UIColor blueColor];
    }
    return _scrollView;
}

-(SDCycleScrollView *)headImageScrollView
{
    if (_headImageScrollView == nil) {
        _headImageScrollView  = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        //_headImageScrollView = [[SDCycleScrollView alloc] init];
        //_headImageScrollView.localizationImageNamesGroup = self.spaceImageArray;
        _headImageScrollView.imageURLStringsGroup = self.spaceImageArray;
        _headImageScrollView.backgroundColor = [UIColor redColor];
        _headImageScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headImageScrollView.currentPageDotColor = [UIColor whiteColor];
    }
    return _headImageScrollView;
}

-(NSArray *)spaceImageArray
{
    if (_spaceImageArray == nil) {
        _spaceImageArray = [[NSArray alloc] init];
//        NSURL *image1 =[NSURL URLWithString:@"http://192.168.1.216:8080/SKwork/static/images/maintain/1517451655673.png"];
//        NSURL *image2 =[NSURL URLWithString:@"http://image.baidu.com/search/detail?ct=503316480&z=&tn=baiduimagedetail&ipn=d&word=fengjing%E5%9B%BE%E7%89%87&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=-1&cs=985039564,1467156771&os=2135006321,4162328064&simid=3456198641,477800861&pn=10&rn=1&di=81803990070&ln=1994&fr=&fmq=1517471830357_R&ic=0&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&is=0,0&istype=2&ist=&jit=&bdtype=0&spn=0&pi=0&gsm=0&objurl=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fphotoblog%2F1305%2F11%2Fc3%2F20799748_20799748_1368252787187_mthumb.jpg&rpstart=0&rpnum=0&adpicid=0"];
////        UIImage *image1 = [UIImage imageNamed:@"feedback"];
////        UIImage *image2 = [UIImage imageNamed:@"feedback"];

        _spaceImageArray = [NSArray imageArrayWithString:self.spaceModel.spacePicture];
    }
    return _spaceImageArray;
}

-(UIView *)spaceDetailView
{
    if (_spaceDetailView == nil) {
        _spaceDetailView = [[UIView alloc] init];
        _spaceDetailView.backgroundColor = [UIColor whiteColor];
    }
    return _spaceDetailView;
}

-(UILabel *)spaceNameLabel
{
    if (_spaceNameLabel == nil) {
        _spaceNameLabel = [[UILabel alloc] init];
        _spaceNameLabel.text = self.spaceModel.spaceName;
    }
    return _spaceNameLabel;
}

-(UILabel *)spaceTelLabel
{
    if (_spaceTelLabel == nil) {
        _spaceTelLabel = [[UILabel alloc] init];
        _spaceTelLabel.text = [NSString stringWithFormat:@"电话：%@",self.spaceModel.relationTel];
        [_spaceTelLabel setFont:[UIFont systemFontOfSize:13.f]];
    }
    return _spaceTelLabel;
}
-(UILabel *)spaceAddressLabel
{
    if (_spaceAddressLabel == nil) {
        _spaceAddressLabel = [[UILabel alloc] init];
        _spaceAddressLabel.text = [NSString stringWithFormat:@"地址：%@",self.spaceModel.spaceSite];
        [_spaceAddressLabel setFont:[UIFont systemFontOfSize:13.f]];
    }
    return _spaceAddressLabel;
}

-(SKTtileView *)titleView
{
    if (_titleView == nil) {
        _titleView = [[SKTtileView alloc] init];
        _titleView.titleString = @"空间介绍";
    }
    return _titleView;
}

-(UILabel *)spaceIntroduceLabel
{
    if (_spaceIntroduceLabel == nil) {
        _spaceIntroduceLabel = [[UILabel alloc] init];
        _spaceIntroduceLabel.numberOfLines =0;
        _spaceIntroduceLabel.preferredMaxLayoutWidth = (self.view.frame.size.width -10.0 * 2);
        [_spaceIntroduceLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _spaceIntroduceLabel.text = self.spaceModel.spaceDescribe;
        [_spaceIntroduceLabel setFont:[UIFont systemFontOfSize:13.f]];
    }
    return _spaceIntroduceLabel;
}

-(SKTtileView *)serviceTitleView
{
    if (_serviceTitleView == nil) {
        _serviceTitleView = [[SKTtileView alloc] init];
        _serviceTitleView.titleString = @"社区服务";
    }
    return _serviceTitleView;
}

-(SKSpaceSiteView *)bookStationView
{
    if (_bookStationView == nil) {
        _bookStationView = [[SKSpaceSiteView alloc] init];
        _bookStationView.nameString = @"可使用工位";
        _bookStationView.numString = [NSString stringWithFormat:@"%@个",self.model.stationNum];
        _bookStationView.moneyString = [NSString stringWithFormat:@"%@元/天",self.model.stationPrice];
        _bookStationView.imageUrl = [self.spaceImageArray firstObject];
    }
    return _bookStationView;
}

-(SKSpaceSiteView *)siteView
{
    if (_siteView == nil) {
        _siteView = [[SKSpaceSiteView alloc] init];
        _siteView.nameString = @"可使用场地";
        _siteView.numString = [NSString stringWithFormat:@"%@个",self.model.siteNum];
        _siteView.moneyString = [NSString stringWithFormat:@"%@元/小时",self.model.sitePrice];
        //NSURL *imageURL = [NSURL URLWithString:@"http://192.168.1.216:8080/SKwork/static/images/maintain/1517451655673.png"];
        _siteView.imageUrl = [[NSArray imageArrayWithString:self.model.sitePicture] firstObject];
    }
    return _siteView;
}

-(SKSpaceSiteView *)meetingView
{
    if (_meetingView == nil) {
        _meetingView = [[SKSpaceSiteView alloc] init];
        _meetingView.nameString = @"可使用会议室";
        _meetingView.numString = [NSString stringWithFormat:@"%@个",self.model.conferenceNum];
        _meetingView.moneyString = [NSString stringWithFormat:@"%@元/小时",self.model.conferencePrice];
       // NSURL *imageURL = [NSURL URLWithString:@"http://192.168.1.216:8080/SKwork/static/images/maintain/1517451655673.png"];
        _meetingView.imageUrl = [[NSArray imageArrayWithString:self.model.conferencePicture] firstObject];
    }
    return _meetingView;
}

-(UIButton *)bottomButton
{
    if(_bottomButton == nil){
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"预约参观" forState:UIControlStateNormal];
        _bottomButton.backgroundColor = UICOLOR_MAIN_ORANGE;
        _bottomButton.layer.cornerRadius = 5.f;
        _bottomButton.layer.borderWidth = 1.f;
        _bottomButton.layer.borderColor = UICOLOR_MAIN_ORANGE.CGColor;
        [_bottomButton addTarget:self action:@selector(visitMethod) forControlEvents:UIControlEventTouchDown];
    }
    return _bottomButton;
}

-(UIView *)constView
{
    if (_constView == nil) {
        _constView = [[UIView alloc] init];
    }
    return _constView;
}

@end
