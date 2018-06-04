//
//  SKCommunityServiceModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/6/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SKCommunityServiceModel : JSONModel
@property(nonatomic,strong)NSNumber *shortStationNum;
@property(nonatomic,strong)NSNumber *longStationNum;
@property(nonatomic,strong)NSNumber *longStationPrice;
@property(nonatomic,copy)NSString *shortStationPicture;
@property(nonatomic,copy)NSString *longStationPicture;
@end

@interface SKCommunityServiceModel_msg : JSONModel
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *result;
@property(nonatomic,strong)SKCommunityServiceModel *msg;
@end
