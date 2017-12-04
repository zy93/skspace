//
//  WOTWXPayModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WOTWXPayModel : JSONModel
@property(nonatomic,strong)NSString *result_code;
@property(nonatomic,strong)NSString *sign;
@property(nonatomic,strong)NSString *mch_id;
@property(nonatomic,strong)NSString *timeStamp;
@property(nonatomic,strong)NSString *prepay_id;
@property(nonatomic,strong)NSString *return_msg;
@property(nonatomic,strong)NSString *package;
@property(nonatomic,strong)NSString *appid;
@property(nonatomic,strong)NSString *nonce_str;
@property(nonatomic,strong)NSString *return_code;
@property(nonatomic,strong)NSString *device_info;
@property(nonatomic,strong)NSString *trade_type;
@end

@interface WOTWXPayModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)WOTWXPayModel *msg;
@end
