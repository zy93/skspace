//
//  WOTServiceProvidersView.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/9.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTServiceCategoryModel.h"
#import "SKFacilitatorModel.h"

@interface WOTServiceProvidersView : UIView

@property (nonatomic, strong) UIView *topBgView;
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subtitleLab;
@property (nonatomic, strong) UILabel *projectNameLab;

-(void)setData:(SKFacilitatorInfoModel *)facilitatorInfoModel;


@end
