//
//  WOTNewInformationModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@protocol WOTNewsModel
@end


@interface WOTNewsModel : JSONModel

@property (nonatomic, strong) NSString *htmlLocation ;
@property (nonatomic, strong) NSNumber *issueCompanyId ;
@property (nonatomic, strong) NSNumber *issueSpaceId ;
@property (nonatomic, strong) NSString *issueTime ;
@property (nonatomic, strong) NSNumber *messageId;
@property (nonatomic, strong) NSString *messageInfo;
@property (nonatomic, strong) NSNumber *messageState;
@property (nonatomic, strong) NSNumber *messageType;
@property (nonatomic, strong) NSString *pictureSite;
@property (nonatomic, strong) NSString *spared1 ;
@property (nonatomic, strong) NSString *spared2 ;
@property (nonatomic, strong) NSString *spared3;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *writer;

@end

@interface WOTNewsModel_list : JSONModel

@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <WOTNewsModel> *list;


@end

@interface WOTNewsModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTNewsModel_list *msg;
@end
