//
//  SKMyDemandModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/15.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKMyDemandModel

@end

@interface SKMyDemandModel : JSONModel
@property (nonatomic, strong) NSString *demandContent ;
@property (nonatomic, strong) NSNumber *demandId;
@property (nonatomic, strong) NSString *demandType ;
@property (nonatomic, strong) NSString *dealState;
@property (nonatomic, strong) NSNumber *facilitatorId;
@property (nonatomic, strong) NSString *firmName;
@property (nonatomic, strong) NSString *lookTime ;
@property (nonatomic, strong) NSString *putTime ;
@property (nonatomic, strong) NSString *needType;
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSString *spaceName ;
@property (nonatomic, strong) NSNumber *state ;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSNumber *userId ;
@property (nonatomic, strong) NSString *userName ;
@end

@interface SKMyDemandModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <SKMyDemandModel> *list;
@end

@interface SKMyDemandModel_msg : JSONModel
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *result;
@property (nonatomic, strong) SKMyDemandModel_list *msg;
@end
