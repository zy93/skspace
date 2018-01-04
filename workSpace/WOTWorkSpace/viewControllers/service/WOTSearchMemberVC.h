//
//  WOTSearchMemberVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/27.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTSearchMemberVC : UIViewController
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, copy) void(^selectMemberBlock)(WOTLoginModel *model);
@end
