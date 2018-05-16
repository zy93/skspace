//
//  SKPayDelegateModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/16.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface SKPayDelegateModel : JSONModel
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,copy)NSString *agreementAdress;
@property(nonatomic,copy)NSString *agreement;
@end

@interface SKPayDelegateModel_msg : JSONModel
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *result;
@property(nonatomic,strong)SKPayDelegateModel *msg;
@end
