//
//  SKServiceProviderScrollView.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/2/8.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKServiceProviderScrollView.h"
#import "SKFacilitatorModel.h"
#import "WOTServiceProvidersView.h"
#import "SKServiceProvidersView.h"

#define providersViewWidth  ([[UIScreen mainScreen] bounds].size.width - 40)/2
#define providersViewHeight ([[UIScreen mainScreen] bounds].size.width/350 * 180)
#define providersViewGap  10
#define providersStartX   20

@implementation SKServiceProviderScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


-(void)setData:(NSArray <SKFacilitatorInfoModel*>*)facilitatorArray
{
    NSArray *arr= self.subviews;
    for (UIView *vi in arr ) {
        [vi removeFromSuperview];
    }
    CGFloat height = self.frame.size.height;
    for (int i = 0; i<facilitatorArray.count; i++) {
        SKServiceProvidersView *view = [[SKServiceProvidersView alloc] initWithFrame:CGRectMake(i==0? providersStartX: i*providersViewWidth + ((i)*(providersViewGap)) + providersStartX, 0, providersViewWidth, height)];
//        view.backgroundColor = UICOLOR_GRAY_99;
        view.clipsToBounds = YES;
        SKFacilitatorInfoModel *infoModel = facilitatorArray[i];
        [view.iconIV sd_setImageWithURL:[infoModel.firmLogo ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_logo"]];
        [view.topIV setImageWithURL:[infoModel.firmShow ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"servcie_bg"]];
        view.titleLab.text = infoModel.firmName;
        view.subtitleLab.text = infoModel.businessScope;
        view.tag = i;
//        view.subtitleLab.text = infoModel.businessScope;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick:)];
        [view addGestureRecognizer:tap];
        [self addSubview:view];
    }
    NSLog(@"---------HH:%f",CGRectGetHeight(self.frame));
    self.contentSize = CGSizeMake(facilitatorArray.count*providersViewWidth+ (facilitatorArray.count*(providersViewGap)) + providersStartX, self.frame.size.height);
    
    //老代码
//    for (int i = 0; i<facilitatorArray.count; i++) {
//        WOTServiceProvidersView *view = [[WOTServiceProvidersView alloc] initWithFrame:CGRectMake(i==0? providersStartX: i*providersViewWidth + ((i)*(providersViewGap)) + providersStartX, 0, providersViewWidth, height)];
//        view.clipsToBounds = YES;
//        SKFacilitatorInfoModel *infoModel = facilitatorArray[i];
//        //NSURL *image = [infoModel.firmLogo ToResourcesUrl];
//        [view.iconIV sd_setImageWithURL:[infoModel.firmLogo ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_logo"]];
//        view.titleLab.text = infoModel.firmName;
//        [view setData:infoModel];
//        view.tag = i;
//        view.subtitleLab.text = infoModel.businessScope;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick:)];
//        [view addGestureRecognizer:tap];
//        [self addSubview:view];
//    }
//    NSLog(@"---------HH:%f",CGRectGetHeight(self.frame));
//    self.contentSize = CGSizeMake(facilitatorArray.count*providersViewWidth+ (facilitatorArray.count*(providersViewGap)) + providersStartX, self.frame.size.height);
    
}
-(void)scrollViewClick:(UITapGestureRecognizer*)tap
{
    //取到点击手势视图的tag值
    NSInteger tapTag= [[tap view] tag];
    if (tap) {
        //self.imageBlock(tapTag);
        self.imageBlock(tapTag);
    }
    //NSLog(@"%ld",tapTag);
}

@end
