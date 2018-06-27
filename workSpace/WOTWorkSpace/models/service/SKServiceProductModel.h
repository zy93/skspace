//
//  SKServiceProductModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 27/6/18.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol SKServiceProductModel <NSObject>

@end

@interface SKServiceProductModel : JSONModel
@property(nonatomic,strong)NSString *productExplain;
@property(nonatomic,strong)NSString *productImage;
@property(nonatomic,strong)NSString *productName;
@property(nonatomic,strong)NSNumber *facilitatorId;
@property(nonatomic,strong)NSNumber *money;
@property(nonatomic,strong)NSNumber *productId;
@end


@interface SKServiceProductModel_msg : JSONModel
@property(nonatomic,copy)NSString *result;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSArray <SKServiceProductModel>*msg;
@end
