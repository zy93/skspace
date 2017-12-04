//
//  WOTSiteReservationsModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/8/3.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol WOTSiteReservationsRsponseModel <NSObject>

@end

@interface WOTSiteReservationsRsponseModel : JSONModel

@end


@interface WOTSiteReservationsRsponseModel_Msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSString *msg;
@end



//TODO: 场地预定情况model
@protocol WOTSiteReservationsModel <NSObject>

@end

@interface WOTSiteReservationsModel :JSONModel
@property(nonatomic,strong)NSNumber *siteId;
@property(nonatomic,strong)NSNumber *siteOrderId;
@property(nonatomic,strong)NSString *siteName;
@property(nonatomic,strong)NSNumber *siteOrderState;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *startTime;
@end




@interface WOTSiteReservationsModel_Msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray <WOTSiteReservationsModel> *msg;

@end
