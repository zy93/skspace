//
//  SKInfoNotifationModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/15.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKInfoNotifationModel

@end


@interface SKInfoNotifationModel : JSONModel
@property(nonatomic,strong)NSNumber *newsId;
@property(nonatomic,copy)NSString *summary;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *objectId;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *readState;
@property(nonatomic,strong)NSNumber *userId;
@end


@interface SKInfoNotifationModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <SKInfoNotifationModel> *list;
@end

@interface SKInfoNotifationModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)SKInfoNotifationModel_list *msg;
@end
