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
#import "SKProductView.h"
#import "SKServiceProductModel.h"

#define providersViewWidth  ([[UIScreen mainScreen] bounds].size.width - 40)/2
#define productViewWidth  ([[UIScreen mainScreen] bounds].size.width - 40)/3
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


-(void)setData:(NSArray*)facilitatorArray
{
    NSArray *arr= self.subviews;
    for (UIView *vi in arr ) {
        [vi removeFromSuperview];
    }
    CGFloat height = self.frame.size.height;
    if ([self.typeStr isEqualToString:@"服务商产品"]) {
        for (int i = 0; i<facilitatorArray.count; i++) {
             SKProductView *view = [[SKProductView alloc] initWithFrame:CGRectMake(i==0? providersStartX: i*productViewWidth + ((i)*(providersViewGap)) + providersStartX, 0, productViewWidth, height)];
            //https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530614256&di=ab8d7ce9fc4fd99d8544039853ebad7e&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fgd%2Fpics%2Fhv1%2F132%2F123%2F1613%2F104916822.png
            SKServiceProductModel *infoModel = facilitatorArray[i];
            [view.iconIV sd_setImageWithURL:[infoModel.productImage ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_logo"]];
//            [view.iconIV sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530614256&di=ab8d7ce9fc4fd99d8544039853ebad7e&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.gtimg.com%2Fgd%2Fpics%2Fhv1%2F132%2F123%2F1613%2F104916822.png"] placeholderImage:[UIImage imageNamed:@"placeholder_logo"]];
            view.titleLab.text = infoModel.productName;
            view.priceLab.text = [NSString stringWithFormat:@"¥%@",infoModel.money];
            view.tag = i;
            [self addSubview:view];
        }
        self.contentSize = CGSizeMake(facilitatorArray.count*productViewWidth+ (facilitatorArray.count*(providersViewGap)) + providersStartX, self.frame.size.height);
    }else
    {
        for (int i = 0; i<facilitatorArray.count; i++) {
            SKServiceProvidersView *view = [[SKServiceProvidersView alloc] initWithFrame:CGRectMake(i==0? providersStartX: i*providersViewWidth + ((i)*(providersViewGap)) + providersStartX, 0, providersViewWidth, height)];
            view.clipsToBounds = YES;
            SKFacilitatorInfoModel *infoModel = facilitatorArray[i];
            [view.iconIV sd_setImageWithURL:[infoModel.firmLogo ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_logo"]];
            [view.topIV setImageWithURL:[infoModel.firmShow ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"servcie_bg"]];
            view.titleLab.text = infoModel.firmName;
            view.subtitleLab.text = infoModel.businessScope;
            view.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick:)];
            [view addGestureRecognizer:tap];
            [self addSubview:view];
        }
        self.contentSize = CGSizeMake(facilitatorArray.count*providersViewWidth+ (facilitatorArray.count*(providersViewGap)) + providersStartX, self.frame.size.height);
    }
    
    
    
    NSLog(@"---------HH:%f",CGRectGetHeight(self.frame));
   // self.contentSize = CGSizeMake(facilitatorArray.count*providersViewWidth+ (facilitatorArray.count*(providersViewGap)) + providersStartX, self.frame.size.height);
    
    
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
