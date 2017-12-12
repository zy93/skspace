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

@property (nonatomic, assign) NSNumber *byReplyid;
@property (nonatomic, strong) NSString *byReplyname;//被回复的名字
@property (nonatomic, assign) NSNumber *friendId;
@property (nonatomic, assign) NSNumber *recordId;
@property (nonatomic, assign) NSNumber *replyId;
@property (nonatomic, strong) NSString *replyInfo;//回复的信息
@property (nonatomic, strong) NSString *replyName;//回复的名字
@property (nonatomic, strong) NSString *replyTime;

@end

@interface CircleofFriendsInfoModel : JSONModel

@property (nonatomic, strong) NSArray<ReplyModel> *ReplyRecord;
@property (nonatomic, strong) NSString <Optional>*circleMessage;
@property (nonatomic, assign) NSNumber <Optional> *focus;
@property (nonatomic, strong) NSString <Optional>*focusId;
@property (nonatomic, assign) NSNumber <Optional>*friendId;
@property (nonatomic, strong) NSString <Optional>*friendTime;
@property (nonatomic, strong) NSString <Optional>*imageMessage;
@property (nonatomic, assign) NSNumber <Optional>*userId;
@property (nonatomic, strong) NSString <Optional>*userName;
@property (nonatomic, strong) NSString <Optional>*userUrl;
@property (nonatomic, assign) NSNumber <Optional>*zan;
@property (nonatomic, strong) NSString <Optional>*zanPersonId;
@property (nonatomic, strong) NSString <Optional>*zanPersonName;

@end


@interface QueryCircleofFriendsModel_msg : JSONModel

@property (nonatomic, assign) NSNumber *bottomPageNo;
@property (nonatomic, strong) NSArray<CircleofFriendsInfoModel> *list;
@property (nonatomic, assign) NSNumber *nextPageNo;
@property (nonatomic, assign) NSNumber *pageNo;
@property (nonatomic, assign) NSNumber *pageSize;
@property (nonatomic, assign) NSNumber *previousPageNo;
@property (nonatomic, assign) NSNumber *topPageNo;
@property (nonatomic, assign) NSNumber *totalPages;
@property (nonatomic, assign) NSNumber *totalRecords;

@end
