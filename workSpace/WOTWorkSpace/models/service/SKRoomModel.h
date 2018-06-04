//
//  SKRoomModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/29.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKRoomModel <NSObject>

@end


@interface SKRoomModel : JSONModel

@property(nonatomic,strong)NSString *showPicture;
@property(nonatomic,strong)NSString *onlineBooking;
@property(nonatomic,strong)NSString *companyId;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *particularsPicture;
@property(nonatomic,strong)NSString *subareaName;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSNumber *yyprice;//年价格
@property(nonatomic,strong)NSNumber *stationArea;//面积大小
@property(nonatomic,strong)NSNumber *averagePrice;//分区均价-原价
@property(nonatomic,strong)NSNumber *halfYyprice;//半年价格
@property(nonatomic,strong)NSNumber *subareaId;//
@property(nonatomic,strong)NSNumber *superiorSubareaId;//
@property(nonatomic,strong)NSNumber *quarter;//季度价格
@property(nonatomic,strong)NSNumber *spaceId;//
@property(nonatomic,strong)NSNumber *stationNum;//
@property(nonatomic,strong)NSNumber *mmprice;//
@property(nonatomic,strong)NSNumber *subareaGrade;//
@property(nonatomic,strong)NSNumber *areaArea;

@end


@interface SKRoomModel_list : JSONModel
@property(nonatomic, strong) NSNumber * bottomPageNo;
@property(nonatomic, strong) NSNumber * nextPageNo;
@property(nonatomic, strong) NSNumber * pageNo;
@property(nonatomic, strong) NSNumber * pageSize;
@property(nonatomic, strong) NSNumber * previousPageNo;
@property(nonatomic, strong) NSNumber * topPageNo;
@property(nonatomic, strong) NSNumber * totalPages;
@property(nonatomic, strong) NSNumber * totalRecords;
@property(nonatomic, strong) NSArray <SKRoomModel> *list;
@end

@interface SKRoomModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)SKRoomModel_list *msg;
@end
