//
//  WOTCityModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/18.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTCityModel
@end

@interface WOTCityModel : JSONModel

@end


@interface WOTCityModel_msg:JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray  *msg;

@end
