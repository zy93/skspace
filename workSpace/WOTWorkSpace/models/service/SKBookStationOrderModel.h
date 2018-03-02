//
//  SKBookStationOrderModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/2/6.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKBookStationOrderModel <NSObject>

@end

@protocol SKBookStationOrderModel_array <NSObject>

@end

@protocol SKBookStationOrderModel_object <NSObject>

@end

@interface SKBookStationOrderModel_array : JSONModel

@property(nonatomic,strong)NSNumber *gross;
@property(nonatomic,strong)NSNumber *surplusId;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSNumber *surplus;
@property(nonatomic,strong)NSString *time;

@end

@interface SKBookStationOrderModel_object : JSONModel
@property(nonatomic,strong)NSString <Optional>*appId;
@property(nonatomic,strong)NSString <Optional>*body;
@property(nonatomic,strong)NSString <Optional>*commodityKind;
@property(nonatomic,strong)NSString <Optional>*commodityNum;
@property(nonatomic,strong)NSString <Optional>*commodityNumList;

@property(nonatomic,strong)NSNumber <Optional>*conferenceDetailsId;
@property(nonatomic,strong)NSNumber <Optional>*contractMode;
@property(nonatomic,strong)NSString <Optional>*dealMode;
@property(nonatomic,strong)NSNumber <Optional>*deduction;
@property(nonatomic,strong)NSNumber <Optional>*deductionTimes;

@property(nonatomic,strong)NSString <Optional>*endTime;
@property(nonatomic,strong)NSString <Optional>*evaluate;
@property(nonatomic,strong)NSString <Optional>*finishTime;
@property(nonatomic,strong)NSString <Optional>*invoiceInfo;
@property(nonatomic,strong)NSNumber <Optional>*money;

@property(nonatomic,strong)NSString <Optional>*orderNum;
@property(nonatomic,strong)NSString <Optional>*orderState;
@property(nonatomic,strong)NSString <Optional>*orderTime;
@property(nonatomic,strong)NSNumber <Optional>*payMode;
@property(nonatomic,strong)NSString <Optional>*payObject;

@property(nonatomic,strong)NSNumber <Optional>*payType;
@property(nonatomic,strong)NSNumber <Optional>*productNum;
@property(nonatomic,strong)NSNumber <Optional>*spaceId;
@property(nonatomic,strong)NSString <Optional>*spaceName;
@property(nonatomic,strong)NSString <Optional>*starTime;

@property(nonatomic,strong)NSNumber <Optional>*userId;
@property(nonatomic,strong)NSString <Optional>*userName;
@property(nonatomic,strong)NSString <Optional>*userTel;

@end

@interface SKBookStationOrderModel : JSONModel
@property(nonatomic,strong)SKBookStationOrderModel_object *Object;
@property(nonatomic,strong)NSArray <SKBookStationOrderModel_array> *Array;
@end


@interface SKBookStationOrderModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)SKBookStationOrderModel *msg;

@end
