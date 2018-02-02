//
//  SKSpaceInfoModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/2/2.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKSpaceInfoModel

@end

@interface SKSpaceInfoModel : JSONModel
@property(nonatomic,strong)NSNumber *conferenceNum;
@property(nonatomic,strong)NSNumber *conferencePrice;
@property(nonatomic,strong)NSString *conferencePicture;
@property(nonatomic,strong)NSNumber *siteNum;
@property(nonatomic,strong)NSNumber *sitePrice;
@property(nonatomic,strong)NSString *sitePicture;
@property(nonatomic,strong)NSNumber *stationNum;
@property(nonatomic,strong)NSNumber *stationPrice;
@end


@interface SKSpaceInfoModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)SKSpaceInfoModel *msg;
@property(nonatomic,strong)NSString *result;
@end
