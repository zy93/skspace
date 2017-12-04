//
//  WOTServiceCategoryModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/4.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol WOTServiceCategoryModel_mm
@end
@protocol WOTServiceCategoryModel
@end


@interface WOTServiceCategoryModel : JSONModel
@property (nonatomic,strong) NSString *classifySubclass;
@property (nonatomic,strong) NSString *labelClassify;
@property (nonatomic,strong) NSNumber *labelId;

@end

@interface WOTServiceCategoryModel_mm : JSONModel
@property (nonatomic,strong) NSString *labelClassify;
@property(nonatomic,strong)NSArray  <WOTServiceCategoryModel> *classifySubclass;
@end


@interface WOTServiceCategoryModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSArray  <WOTServiceCategoryModel_mm> *msg;
@end
