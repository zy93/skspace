//
//  WOTShortcutMenuView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTShortcutMenuView.h"
#import "UIDevice+Resolutions.h"

@interface WOTShortcutMenuView ()
{
    NSArray *imageNameList;
    NSArray *titleList;
    
    NSMutableArray *buttonList;
    CGFloat buttonDefaultY;
    CGFloat lineDefaultHeight;
    CGFloat buttonWidth;
    CGFloat buttonHeight;
    
    
    NSArray *sbNameList;
    NSArray *vcNameList;
    
}

@end


@implementation WOTShortcutMenuView



-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    //self.backgroundColor = UIColorFromRGB(0x8fc5f3);
    self.backgroundColor = [UIColor whiteColor];
    sbNameList = @[@"Service",@"Service",@"Service",@"Service",@"",
                   @"spaceMain",@"spaceMain",@"Service",];
    
    vcNameList = @[ @"WOTBookStationVCID",
                    @"WOTBookStationVCID",
                   @"WOTReservationsMeetingVC",
                   @"WOTReservationsMeetingVC",
                   @"SKGiftBagViewController",
                   @"WOTInformationListVC",
                   @"WOTActivitiesLIstVC",
                   @"WOTVisitorsAppointmentVC"
                   ];
    
    
    titleList = @[@"分时预定",@"工位租赁",@"订会议室",@"预订场地", @"礼包", @"尚科资讯", @"尚科活动", @"访客预约"];
    imageNameList = @[@"shortcut_finds_icon",
                      @"shortcut_station_icon",
                      @"shortcut_meeting_icon",
                      @"shortcut_site_icon",
                      @"shortcut_open_icon",
                      @"shortcut_news_icon",
                      @"shortcut_activity_icon",
                      @"shortcut_visitors_icon"];
    buttonDefaultY = 15;//15，50
    lineDefaultHeight = 10;//10，90
    if ([[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina58 ||
        [[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina55) {
        buttonDefaultY = 20;
        lineDefaultHeight = 80;
    }
    
    if ([[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina47) {
        buttonDefaultY = 20;
        lineDefaultHeight = 40;
    }
    NSLog(@"---_%lf",self.frame.size.height);;
    CGFloat buttonBottom = 20;
    buttonHeight = (self.frame.size.height-(buttonDefaultY*2)-buttonBottom)/2;
    buttonWidth = (SCREEN_WIDTH-20)/4;
    
    for (int i = 0; i<titleList.count; i++) {
        UIButton *btn = [self createButtonWithTitle:titleList[i] imgName:imageNameList[i] i:i];
        [buttonList addObject:btn];
    }
}

-(UIButton *)createButtonWithTitle:(NSString *)title imgName:(NSString *)imgName i:(int)i
{
    CGFloat startX = 10;
    NSInteger index = i%4;
    NSInteger line = i/4;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(index*buttonWidth+startX, line*buttonHeight+buttonDefaultY, buttonWidth, buttonHeight)];
    button.tag = i;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *img = [UIImage imageNamed:imgName];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    [imgV setImage:img];
    imgV.center = CGPointMake(buttonWidth*0.5, buttonHeight*0.5-15);
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgV.frame), buttonWidth, 20)];
    lab.text = title;
    //lab.textColor = UICOLOR_WHITE;
    //lab.textColor = RGBA(72,134,236,1);
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:12.f];
    [button addSubview:imgV];
    [button addSubview:lab];
    [self addSubview:button];
    return button;
}


-(void)clickButton:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(shortcutMenu:pushToVCWithStoryBoardName:vcName:)]) {
        
        if (sender.tag == 0) {
            [WOTSingtleton shared].orderType = ORDER_TYPE_BOOKSTATION;
            [WOTSingtleton shared].skTimeType = SKTIMETYPE_SHORTPERIOD;
        }else if (sender.tag == 1)
        {
            [WOTSingtleton shared].orderType = ORDER_TYPE_BOOKSTATION;
            [WOTSingtleton shared].skTimeType = SKTIMETYPE_LONGTIME;
        }
        else if (sender.tag == 2) {
            [WOTSingtleton shared].orderType = ORDER_TYPE_MEETING;
        }else if (sender.tag == 3) {
            [WOTSingtleton shared].orderType = ORDER_TYPE_SITE;
        }
        [_delegate shortcutMenu:self pushToVCWithStoryBoardName:sbNameList[sender.tag] vcName:vcNameList[sender.tag]];
    }
}


@end
