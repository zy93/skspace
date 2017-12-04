//
//  WOTUserSingleton.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/12.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WOTLoginModel.h"

@interface WOTUserSingleton : NSObject

//用户信息
@property (nonatomic, strong) WOTLoginModel *userInfo;

+(instancetype)shareUser;
-(void)saveUserInfoToPlistWithModel:(WOTLoginModel *)model;
@end
