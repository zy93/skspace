//
//  WOTMyHistoryDemandsModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/21.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WOTMyHistoryDemandsModel
@end

@interface WOTMyHistoryDemandsModel : JSONModel

@property(nonatomic,strong)NSString *describe;
@property(nonatomic,strong)NSArray *facilitatorLabel;
@property(nonatomic,strong)NSString *facilitatorType;
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSNumber *spaceId;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSNumber *userId;
@end

@interface WOTMyHistoryDemandsModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray<WOTMyHistoryDemandsModel> *msg;

@end
