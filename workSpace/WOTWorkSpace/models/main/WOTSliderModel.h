//
//  WOTSliderModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/17.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WOTSliderModel
@end

@interface WOTSliderModel : JSONModel
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *headline;
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *url;

@end
@interface WOTSliderModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray<WOTSliderModel> *msg;
@end
