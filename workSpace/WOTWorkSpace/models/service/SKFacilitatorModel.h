//
//  SKFacilitatorModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKFacilitatorInfoModel <NSObject>

@end

@interface SKFacilitatorInfoModel : JSONModel

@property(nonatomic,strong)NSNumber *facilitatorId;
@property(nonatomic,strong)NSString *businessScope;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *contacts;
@property(nonatomic,strong)NSString *facilitatorState;
@property(nonatomic,strong)NSString *facilitatorType;
@property(nonatomic,strong)NSString *firmLogo;
@property(nonatomic,strong)NSString *firmShow;
@property(nonatomic,strong)NSString *firmName;
@property(nonatomic,strong)NSString *tel;
@property(nonatomic,strong)NSString *facilitatorDescribe;
@property(nonatomic,copy)NSString *introduce;
@property(nonatomic,copy)NSString *website;
@property(nonatomic,copy)NSString *site;
@property(nonatomic,copy)NSString *spaceList;

@end

@interface SKFacilitatorModel_msg:JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property(nonatomic,strong)NSArray <SKFacilitatorInfoModel> *list;

@end


@interface SKFacilitatorModel:JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)SKFacilitatorModel_msg *msg;

@end


