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

@property (nonatomic, strong) NSNumber * conferenceId;
@property (nonatomic, strong) NSString * conferenceName;
@property (nonatomic, strong) NSString * conferenceDescribe;
@property (nonatomic, strong) NSString * conferencePicture;
@property (nonatomic, strong) NSString * openTime;
@property (nonatomic, strong) NSNumber * spaceId;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSNumber * conferenceState;
@property (nonatomic, strong) NSString * conferencePrice;
@property (nonatomic, strong) NSNumber * conferenceType;
@property (nonatomic, strong) NSString * spared1;
@property (nonatomic, strong) NSString * spared2;
@property (nonatomic, strong) NSString * spared3;
//新添加字段
@property (nonatomic, strong) NSString *facility;


@end


@interface WOTMeetingListModel_msg:JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray<WOTMeetingListModel> *msg;

@end
