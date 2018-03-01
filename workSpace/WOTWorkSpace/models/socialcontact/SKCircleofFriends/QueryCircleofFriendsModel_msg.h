//
//  QueryCircleofFriendsModel_msg.h
//  NetWorking
//
//  Created by wangxiaodong on 2017/12/11.
//  Copyright © 2017年 YiLiANGANG. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//#import "CircleofFriendsInfoModel.h"

@protocol CircleofFriendsInfoModel

@end

@protocol ReplyModel

@end


@interface ReplyModel : JSONModel

@property (nonatomic, strong) NSNumber *byReplyid;
@property (nonatomic, strong) NSString *byReplyname;//被回复的名字
@property (nonatomic, strong) NSNumber *friendId;
@property (nonatomic, strong) NSNumber *recordId;
@property (nonatomic, strong) NSNumber *replyId;
@property (nonatomic, strong) NSString *replyInfo;//回复的信息
@property (nonatomic, strong) NSString *replyName;//回复的名字
@property (nonatomic, strong) NSString *replyTime;
@property (nonatomic, strong) NSString *replyState;

@end

@interface CircleofFriendsInfoModel : JSONModel

@property (nonatomic, strong) NSArray<ReplyModel> *ReplyRecord;
@property (nonatomic, strong) NSString <Optional>*circleMessage;
@property (nonatomic, strong) NSNumber <Optional> *focus;
@property (nonatomic, strong) NSNumber <Optional>*focusId;
@property (nonatomic, strong) NSNumber <Optional>*friendId;
@property (nonatomic, strong) NSString <Optional>*friendTime;
@property (nonatomic, strong) NSString <Optional>*imageMessage;
@property (nonatomic, strong) NSNumber <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*userName;
@property (nonatomic, strong) NSString <Optional>*userUrl;
@property (nonatomic, strong) NSNumber <Optional>*zan;
@property (nonatomic, strong) NSString <Optional>*zanPersonId;
@property (nonatomic, strong) NSString <Optional>*zanPersonName;

@end


@interface QueryCircleofFriendsModel_msg : JSONModel

@property (nonatomic, strong) NSNumber *bottomPageNo;
@property (nonatomic, strong) NSArray<CircleofFriendsInfoModel> *list;
@property (nonatomic, strong) NSNumber *nextPageNo;
@property (nonatomic, strong) NSNumber *pageNo;
@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSNumber *previousPageNo;
@property (nonatomic, strong) NSNumber *topPageNo;
@property (nonatomic, strong) NSNumber *totalPages;
@property (nonatomic, strong) NSNumber *totalRecords;

@end
