//
//  QueryCircleofFriendsModel.h
//  NetWorking
//
//  Created by wangxiaodong on 2017/12/11.
//  Copyright © 2017年 YiLiANGANG. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "QueryCircleofFriendsModel_msg.h"

@interface QueryCircleofFriendsModel : JSONModel

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) QueryCircleofFriendsModel_msg *msg;

@end
