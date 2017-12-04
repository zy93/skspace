//
//  WOTMyFeedBackModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/18.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WOTMyFeedBackModel
@end

@interface WOTMyFeedBackModel : JSONModel
@property (nonatomic,strong)NSString *opinionContent;
@property (nonatomic,strong)NSNumber *opinionId;
@property (nonatomic,strong)NSNumber *opinionState;
@property (nonatomic,strong)NSNumber *spaceId;
@property (nonatomic,strong)NSString *spared3;
@property (nonatomic,strong)NSString *tel;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSNumber *userId;
@property (nonatomic,strong)NSString *userName;
@end

@interface WOTMyFeedBackModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray<WOTMyFeedBackModel> *msg;
@end
