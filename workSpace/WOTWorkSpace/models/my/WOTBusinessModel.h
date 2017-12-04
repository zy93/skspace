//
//  WOTBusinessModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WOTBusinessModel : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSString *msg;
@end
