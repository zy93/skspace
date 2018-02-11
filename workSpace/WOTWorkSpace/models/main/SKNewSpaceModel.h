//
//  SKNewSpaceModel.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WOTSpaceModel.h"

@interface SKNewSpaceModel : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray <WOTSpaceModel> *msg;
@end
