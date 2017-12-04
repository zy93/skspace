//
//  WOTBookStationReservationsModel.h
//  WOTWorkSpace
//
//  Created by 编程 on 2017/9/29.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WOTBookStationReservationsModel <NSObject>

@end

@interface WOTBookStationReservationsModel : JSONModel

@end


@interface WOTBookStationReservationsModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray <WOTBookStationReservationsModel> *msg;

@end
