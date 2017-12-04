//
//  WOTSpaceModel.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSpaceModel.h"

@implementation WOTSpaceModel

+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

-(instancetype)initWithSpaceId:(NSNumber *)spaceId spaceName:(NSString *)spaceName spaceDescribe:(NSString *)spaceDescribe city:(NSString *)city spaceSite:(NSString *)spaceSite fixPhone:(NSString *)fixPhone relationTel:(NSString *)relationTel spaceState:(NSNumber *)spaceState creationTime:(NSString *)creationTime spacePicture:(NSString *)spacePicture{
    self = [super init];
    if (self) {
        self.spaceId = spaceId;
        self.spaceName = spaceName;
        self.spaceDescribe = spaceDescribe;
        self.city = city;
        self.spaceSite = spaceSite;
        self.fixPhone = self.fixPhone;
        self.relationTel = self.relationTel;
        self.spaceState = self.spaceState;
        self.creationTime = self.creationTime;
        self.spacePicture  = self.spacePicture;
        
        
    }
    return  self;
}
@end

@implementation WOTSpaceModel_msg
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
