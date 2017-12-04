//
//  WOTReservationsMeetingVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTReservationsMeetingVC : UIViewController

@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSString *spaceName;
//已选时间记录
@property (nonatomic,assign) CGFloat beginTime;
@property (nonatomic,assign) CGFloat endTime;

@end
