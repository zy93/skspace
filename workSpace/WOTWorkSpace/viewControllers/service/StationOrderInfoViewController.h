//
//  StationOrderInfoViewController.h
//  LoginDemo
//
//  Created by wangxiaodong on 2017/12/4.
//  Copyright © 2017年 YiLiANGANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTWXPayModel.h"
#import "WOTMeetingListModel.h"

@interface StationOrderInfoViewController : UIViewController


@property (nonatomic, strong) WOTWXPayModel *model;
@property (nonatomic, strong) WOTMeetingListModel *meetingModel;
@property (nonatomic, strong) NSDictionary *dic;

@end
