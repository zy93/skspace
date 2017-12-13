//
//  SKAddReply.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/12.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKAddReply : NSObject

@property (nonatomic, assign)NSNumber *friendId;
@property (nonatomic, assign)NSNumber *byReplyid;
@property (nonatomic, strong)NSString *byReplyname;
@property (nonatomic, assign)NSNumber *replyId;
@property (nonatomic, strong)NSString *replyName;
@property (nonatomic, strong)NSString *replyInfo;

@end
