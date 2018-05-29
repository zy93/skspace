//
//  WOTBookStationVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

typedef NS_ENUM(NSInteger,SKTIMETYPE) {
    SKTIMETYPE_SHORTPERIOD,
    SKTIMETYPE_LONGTIME,
};

@interface WOTBookStationVC : UIViewController

@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSString *spaceName;
@property (nonatomic, assign) SKTIMETYPE skTimeType;
@end
