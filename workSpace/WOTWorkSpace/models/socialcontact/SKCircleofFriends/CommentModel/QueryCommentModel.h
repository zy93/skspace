//
//  QueryCommentModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "QueryCommentModel_msg.h"

@interface QueryCommentModel : JSONModel
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) QueryCommentModel_msg *msg;
@end
