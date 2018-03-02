//
//  QueryCommentModel_msg.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol CommentModel

@end

@interface CommentModel_msg: JSONModel

@property (nonatomic, strong) NSNumber *byReplyid;
@property (nonatomic, strong) NSString *byReplyname;
@property (nonatomic, strong) NSNumber *friendId;
@property (nonatomic, strong) NSNumber *recordId;
@property (nonatomic, strong) NSNumber *replyId;
@property (nonatomic, strong) NSString *replyInfo;
@property (nonatomic, strong) NSString *replyName;
@property (nonatomic, strong) NSString *replyTime;
@property (nonatomic, strong) NSString *replyState;

@end

@interface CommentModel: JSONModel

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) CommentModel_msg *ReplyRecord;
@property (nonatomic, strong) NSString *userUrl;

@end

@interface QueryCommentModel_msg : JSONModel

@property (nonatomic, strong) NSNumber *bottomPageNo;
@property (nonatomic, strong) NSArray<CommentModel> *list;
@property (nonatomic, strong) NSNumber *nextPageNo;
@property (nonatomic, strong) NSNumber *pageNo;
@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSNumber *previousPageNo;
@property (nonatomic, strong) NSNumber *topPageNo;
@property (nonatomic, strong) NSNumber *totalPages;
@property (nonatomic, strong) NSNumber *totalRecords;

@end
