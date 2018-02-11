//
//  WOTStaffModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTStaffModel

@end


@interface WOTStaffModel : JSONModel
@property (nonatomic, strong) NSString *alias ;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *birthDate;
@property (nonatomic, strong) NSString *contacts ;
@property (nonatomic, strong) NSNumber *departmentId ;
@property (nonatomic, strong) NSString *departmentName ;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *headPortrait;
@property (nonatomic, strong) NSString *jurisdiction;
@property (nonatomic, strong) NSString *realName ;
@property (nonatomic, strong) NSString *registerTime ;
@property (nonatomic, strong) NSString *sex ;
@property (nonatomic, strong) NSString *spaceList;
@property (nonatomic, strong) NSNumber *staffId ;
@property (nonatomic, strong) NSString *staffName ;
@property (nonatomic, strong) NSNumber *staffType;
@property (nonatomic, strong) NSNumber *state ;
@property (nonatomic, strong) NSString *tel ;
@end

@interface WOTStaffModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <WOTStaffModel> *list;

@end

@interface WOTStaffModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong) WOTStaffModel_list *msg;

@end
