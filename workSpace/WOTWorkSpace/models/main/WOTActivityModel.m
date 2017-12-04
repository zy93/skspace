//
//  WOTActivityModel.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTActivityModel.h"

@implementation WOTActivityModel
-(instancetype)initWithTitle:(NSString *)title activityId:(NSNumber *)activityId activityState:(NSNumber *)activityState activityType:(NSNumber *)activityType issueCompanyId:(NSNumber *)issueCompanyId issueTime:(NSString *)issueTime issueUserId:(NSNumber *)issueUserId peopleNum:(NSNumber *)peopleNum pictureSite:(NSString *)pictureSite principalName:(NSString *)principalName principalTel:(NSString *)principalTel activityDescribe:(NSString *)activityDescribe starTime:(NSString *)starTime endTime:(NSString *)endTime spaceId:(NSNumber *)spaceId spared1:(NSString *)spared1 spared2:(NSString *)spared2 spared3:(NSString *)spared3{
    self = [super init];
    if (self) {
        self.title = title;
        self.activityId = activityId;
        self.activityState = activityState;
        self.activityType = activityType;
        self.issueCompanyId = issueCompanyId;
        self.issueTime = self.issueTime;
        self.issueUserId = issueUserId;
        self.peopleNum = peopleNum;
        self.pictureSite = self.pictureSite;
        self.principalName = self.principalName;
        self.principalTel = self.principalTel;
        self.activityDescribe = self.activityDescribe;
        self.starTime = self.starTime;
        self.endTime = self.endTime;
        self.spaceId = self.spaceId;
        self.spaceName = self.spaceName;
        self.spared1 = self.spared1;
        self.spared2 = self.spared2;
        self.spared3 = self.spared3;
    }
    return self;
    
}
@end
@implementation WOTActivityModel_msg



@end

@implementation WOTMyActivityModel


@end

@implementation WOTMyActivityModel_msg

@end
