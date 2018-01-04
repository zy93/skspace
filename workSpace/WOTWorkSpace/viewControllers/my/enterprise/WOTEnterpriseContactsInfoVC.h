//
//  WOTEnterpriseConnectsInfoVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTTableViewBaseVC.h"
@interface WOTEnterpriseContactsInfoVC : WOTTableViewBaseVC

@property (nonatomic,copy) void (^contactsBlock)(NSString *name, NSString *tel, NSString *email);



@end
