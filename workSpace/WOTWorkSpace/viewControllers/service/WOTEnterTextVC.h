//
//  WOTEnterTextVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTEnterTextVC : UIViewController
@property (nonatomic,copy) void (^popVCWithEnterString)(NSString *enterString);
@end
