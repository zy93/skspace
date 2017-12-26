//
//  WFMessageBody.h
//  WFCoretext
//
//  Created by 阿虎 on 15/4/28.
//  Copyright (c) 2015年 tigerwf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WFReplyBody : NSObject

/**
 *  评论者
 */
@property (nonatomic,copy) NSString *replyUser;


/**
 *  回复该评论者的人
 */
@property (nonatomic,copy) NSString *repliedUser;

/**
 *  回复内容
 */
@property (nonatomic,copy) NSString *replyInfo;

/**
 *  评论者id
 */
@property (nonatomic,assign) NSNumber *replyUserId;


/**
 *  评论id
 */
@property (nonatomic,assign) NSNumber *recordId;


@end
