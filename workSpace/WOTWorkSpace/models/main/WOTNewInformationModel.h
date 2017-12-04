//
//  WOTNewInformationModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
@protocol WOTNewInformationModel


@end
@interface WOTNewInformationModel : JSONModel
@property(nonatomic,strong)NSNumber *issueCompanyId;
@property(nonatomic,strong)NSNumber *issueSpaceId;
@property(nonatomic,strong)NSString *issueTime;
@property(nonatomic,strong)NSNumber *messageId;
@property(nonatomic,strong)NSString *messageInfo;
@property(nonatomic,strong)NSString *messageState;
@property(nonatomic,strong)NSNumber *messageType;
@property(nonatomic,strong)NSString *pictureSite;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *writer;
@property(nonatomic,strong)NSString *spared1;
@property(nonatomic,strong)NSString *spared2;
@property(nonatomic,strong)NSString *spared3;

@end

@interface WOTNewInformationModel_spacefirm : JSONModel
@property(nonatomic,strong)NSArray<WOTNewInformationModel> *space;
@property(nonatomic,strong)NSArray<WOTNewInformationModel> *firm;
@end

@interface WOTNewInformationModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTNewInformationModel_spacefirm *msg;
@end
