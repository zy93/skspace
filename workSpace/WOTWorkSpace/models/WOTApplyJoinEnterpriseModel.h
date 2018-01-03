//
//  WOTApplyJoinEnterpriseModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/2.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTApplyModel <NSObject>

@end


@interface WOTApplyModel : JSONModel
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userTel;
@property (nonatomic, strong) NSString *headPortrait;
@property (nonatomic, strong) NSNumber *companyId;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *applyForTime;
@property (nonatomic, strong) NSString *applyForState;
@property (nonatomic, strong) NSNumber *handlerId;
@property (nonatomic, strong) NSString *handlerName;
@property (nonatomic, strong) NSString *disposeTime;

@end


@interface WOTApplyJoinEnterpriseModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <WOTApplyModel> *list;
@end



@interface WOTApplyJoinEnterpriseModel_msg : JSONModel
@property (nonatomic, strong) NSString*code;
@property (nonatomic, strong) NSString*result;
@property (nonatomic, strong) WOTApplyJoinEnterpriseModel_list* msg;
@end
