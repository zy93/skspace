//
//  SKSingleFacilitatorModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/15.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "SKFacilitatorModel.h"

@interface SKSingleFacilitatorModel : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)SKFacilitatorInfoModel *msg;
@end
