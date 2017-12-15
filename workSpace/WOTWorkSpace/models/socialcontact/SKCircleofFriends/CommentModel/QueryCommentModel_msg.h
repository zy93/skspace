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

@property (nonatomic, assign) NSNumber *byReplyid;
@property (nonatomic, strong) NSString *byReplyname;
@property (nonatomic, assign) NSNumber *friendId;
@property (nonatomic, assign) NSNumber *recordId;
@property (nonatomic, assign) NSNumber *replyId;
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

@property (nonatomic, assign) NSNumber *bottomPageNo;
@property (nonatomic, strong) NSArray<CommentModel> *list;
@property (nonatomic, assign) NSNumber *nextPageNo;
@property (nonatomic, assign) NSNumber *pageNo;
@property (nonatomic, assign) NSNumber *pageSize;
@property (nonatomic, assign) NSNumber *previousPageNo;
@property (nonatomic, assign) NSNumber *topPageNo;
@property (nonatomic, assign) NSNumber *totalPages;
@property (nonatomic, assign) NSNumber *totalRecords;

@end
