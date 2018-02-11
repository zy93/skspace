//
//  WOTMeetingFacilityModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTMeetingFacilityModel
@end

@interface WOTMeetingFacilityModel : JSONModel
@property (nonatomic, strong) NSString * facilities;
@property (nonatomic, strong) NSNumber * facilitiesId;
@property (nonatomic, strong) NSString * facilitiesPicture;
@end

@interface WOTMeetingFacilityModel_msg: JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray <WOTMeetingFacilityModel> *msg;
@end
