//
//  SKAliPayModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/18.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SKAliPayModel : JSONModel

@property(nonatomic,strong)NSString *appId;
@property(nonatomic,strong)NSString *body;
@property(nonatomic,strong)NSString *commodityKind;
@property(nonatomic,strong)NSNumber *commodityNum;
@property(nonatomic,strong)NSString *commodityNumList;
@property(nonatomic,strong)NSNumber *contractMode;
@property(nonatomic,strong)NSString *dealMode;
@property(nonatomic,strong)NSNumber *deduction;
@property(nonatomic,strong)NSNumber *deductionTimes;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *evaluate;
@property(nonatomic,strong)NSString *finishTime;
@property(nonatomic,strong)NSNumber *money;
@property(nonatomic,strong)NSString *orderNum;
@property(nonatomic,strong)NSString *orderState;
@property(nonatomic,strong)NSString *orderTime;
@property(nonatomic,strong)NSNumber *payMode;
@property(nonatomic,strong)NSString *payObject;
@property(nonatomic,strong)NSNumber *payType;
@property(nonatomic,strong)NSNumber *productNum;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSString *spaceName;
@property(nonatomic,strong)NSString *starTime;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userTel;


@end


@interface SKAliPayModel_msg :JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)SKAliPayModel *msg;
@end
