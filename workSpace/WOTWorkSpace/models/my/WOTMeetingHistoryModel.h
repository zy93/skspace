//
//  WOTMeetingHistoryModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/12.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTMeetingHistoryModel
@end


@interface WOTMeetingHistoryModel : JSONModel
@property (nonatomic, strong) NSString * company;
@property (nonatomic, strong) NSString * conferenceDescribe;
@property (nonatomic, strong) NSNumber * conferenceDetailsId;
@property (nonatomic, strong) NSNumber * conferenceId ;
@property (nonatomic, strong) NSString * conferenceName;
@property (nonatomic, strong) NSNumber * conferencePrice ;
@property (nonatomic, strong) NSNumber * conferenceState ;
@property (nonatomic, strong) NSString * conferenceTime ;
@property (nonatomic, strong) NSString * deduction ;
@property (nonatomic, strong) NSNumber * deductionTimes;
@property (nonatomic, strong) NSString * endTime ;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * openTime ;
@property (nonatomic, strong) NSNumber * payState ;
@property (nonatomic, strong) NSString * people ;
@property (nonatomic, strong) NSNumber * spaceId;
@property (nonatomic, strong) NSString * spaceName ;
@property (nonatomic, strong) NSString * startTime ;
@property (nonatomic, strong) NSNumber * userId;

@end


@interface WOTMeetingHistoryModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <WOTMeetingHistoryModel> *list;
@end


@interface WOTMeetingHistoryModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTMeetingHistoryModel_list *msg;
@end
