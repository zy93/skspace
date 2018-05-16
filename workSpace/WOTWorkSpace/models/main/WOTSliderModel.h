//
//  WOTSliderModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/17.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WOTSliderModel
@end

@interface WOTSliderModel : JSONModel

@property(nonatomic,strong)NSString *addTime;
@property(nonatomic,strong)NSString *coverPicture ;
@property(nonatomic,strong)NSString *expirationTime ;
@property(nonatomic,strong)NSNumber *priority ;
@property(nonatomic,strong)NSNumber *proclamationId ;
@property(nonatomic,strong)NSString *proclamationTitle ;
@property(nonatomic,strong)NSString *proclamationType;
@property(nonatomic,strong)NSString *spaceId;
@property(nonatomic,strong)NSString *spaceList;
@property(nonatomic,strong)NSString *webpageUrl ;
@property(nonatomic,strong)NSString *objectId;
@property(nonatomic,strong)NSString *objectName;
@property(nonatomic,strong)NSString *time;
@end

@interface WOTSliderModel_list:JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property(nonatomic,strong)NSArray <WOTSliderModel> *list;
@end


@interface WOTSliderModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTSliderModel_list *msg;
@end
