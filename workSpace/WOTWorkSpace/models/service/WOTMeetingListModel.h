//
//  WOTMeetingListModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/17.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//TODO:会议室列表Model


@protocol WOTMeetingListModel <NSObject>

@end

@interface WOTMeetingListModel : JSONModel

@property (nonatomic, strong) NSNumber * area;
@property (nonatomic, strong) NSNumber * conferenceId;
@property (nonatomic, strong) NSString * conferenceName;
@property (nonatomic, strong) NSString * conferenceDescribe;
@property (nonatomic, strong) NSString * conferencePicture;
@property (nonatomic, strong) NSString * conferencePrice;
@property (nonatomic, strong) NSNumber * conferenceState;
@property (nonatomic, strong) NSNumber * conferenceType;
@property (nonatomic, strong) NSString * facility;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * openTime;
@property (nonatomic, strong) NSNumber * peopleNum;
@property (nonatomic, strong) NSNumber * spaceId;
@property (nonatomic, strong) NSString * spared1;
@property (nonatomic, strong) NSString * spared2;
@property (nonatomic, strong) NSString * spared3;

@end

@interface WOTMeetingListModel_list:JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property(nonatomic,strong)NSArray <WOTMeetingListModel> *list;

@end


@interface WOTMeetingListModel_msg:JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTMeetingListModel_list *msg;

@end
