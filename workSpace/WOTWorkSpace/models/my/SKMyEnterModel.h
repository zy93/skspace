//
//  SKMyEnterModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/15.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKMyEnterModel

@end

@interface SKMyEnterModel : JSONModel
@property (nonatomic, strong) NSString *clientName ;
@property (nonatomic, strong) NSString *companyName;//公司名称
@property (nonatomic, strong) NSString *companyType ;
@property (nonatomic, strong) NSString *contacts;//联系人
@property (nonatomic, strong) NSString *createTime ;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *intention ;
@property (nonatomic, strong) NSNumber *leaderId;
@property (nonatomic, strong) NSString *leaderName ;
@property (nonatomic, strong) NSString *record ;
@property (nonatomic, strong) NSString *remark;//备注
@property (nonatomic, strong) NSNumber *sellId;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSString *spaceName;
@property (nonatomic, strong) NSString *specificSource;
@property (nonatomic, strong) NSString *stage;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *tel;//联系人电话
@property (nonatomic, strong) NSString *will;
@property (nonatomic, strong) NSString *appointmentTime;//预约日期
@property (nonatomic, strong) NSNumber *peopleNum;//入驻人数
@property (nonatomic, strong) NSNumber *userId;

@end


@interface SKMyEnterModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <SKMyEnterModel> *list;
@end


@interface SKMyEnterModel_msg : JSONModel
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *result;
@property(nonatomic,strong)SKMyEnterModel_list *msg;
@end
