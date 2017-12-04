//
//  WOTSendFriendsModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/9/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WOTSendFriendsModel : JSONModel

@end


@interface WOTSendFriendsModel_msg : JSONModel

@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSString *msg;

@end
