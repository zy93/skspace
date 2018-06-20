//
//  SKGiftBagModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/3/2.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKGiftBagModel

@end

@interface SKGiftBagModel : JSONModel

@property(nonatomic,strong)NSNumber *conferenceDate;
@property(nonatomic,strong)NSString *giftExplain;
@property(nonatomic,strong)NSNumber *giftId;
@property(nonatomic,strong)NSString *giftInfo;
@property(nonatomic,strong)NSString *giftName;
@property(nonatomic,strong)NSString *giftValidity;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSNumber *price;
@property(nonatomic,strong)NSNumber *stationDate;
@property(nonatomic,strong)NSString *type;

@end

@interface SKGiftBagModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <SKGiftBagModel> *list;
@end

@interface SKGiftBagModel_msg : JSONModel

@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)SKGiftBagModel_list *msg;
@property(nonatomic,copy)NSString *result;

@end
