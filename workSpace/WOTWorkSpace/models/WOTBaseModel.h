//
//  WOTBaseModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WOTBaseModel : JSONModel

@property (nonatomic, strong) NSString*code;
@property (nonatomic, strong) NSString*result;
@property (nonatomic, strong) NSString* msg;

@end



@interface  WOTImagePathModel_w: JSONModel
@property(nonatomic,strong) NSString *site;
@property(nonatomic,strong) NSString *fileName;

@end


@interface WOTImagePathModel : JSONModel
@property(nonatomic,strong)NSArray<WOTImagePathModel_w *>*headPortrait;

@end

