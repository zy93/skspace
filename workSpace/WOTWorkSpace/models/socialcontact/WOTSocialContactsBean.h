//
//  WOTSocialContactsBean.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/21.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTSocialContactsBean : NSObject
@property (nonatomic, copy, readonly) NSString *content;
@property (nonatomic, copy, readonly) NSString *contactname;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSArray *imageNames;
@end
