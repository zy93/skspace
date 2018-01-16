//
//  WOTServiceForProvidersCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/9.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTServiceForProvidersCell.h"
#import "SKFacilitatorModel.h"

#define providersViewWidth  ([[UIScreen mainScreen] bounds].size.width - 50)
#define providersViewHeight ([[UIScreen mainScreen] bounds].size.width/350 * 180)
#define providersViewGap  10
#define providersStartX   20

@implementation WOTServiceForProvidersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.backgroundColor = [UIColor grayColor];
//    self.providersScrollView.backgroundColor = UIColorFromRGB(0x1234ff);
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    UIImage *im = self.arrowIV.image;
    im = [im imageWithColor:UICOLOR_MAIN_ORANGE];
    [self.arrowIV setImage:im];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(NSArray <SKFacilitatorInfoModel*>*)facilitatorArray
{
    NSArray *arr= self.providersScrollView.subviews;
    for (UIView *vi in arr ) {
        [vi removeFromSuperview];
    }
    
    for (int i = 0; i<facilitatorArray.count; i++) {
        WOTServiceProvidersView *view = [[WOTServiceProvidersView alloc] initWithFrame:CGRectMake(i==0? providersStartX: i*providersViewWidth + ((i)*(providersViewGap)) + providersStartX, 0, providersViewWidth, providersViewHeight)];
        view.clipsToBounds = YES;
        SKFacilitatorInfoModel *infoModel = facilitatorArray[i];
        NSURL *image = [infoModel.firmLogo ToResourcesUrl];
        [view.iconIV sd_setImageWithURL:[infoModel.firmLogo ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_logo"]];
        view.titleLab.text = infoModel.firmName;
        [view setData:infoModel];
        view.tag = i;
        view.subtitleLab.text = infoModel.businessScope;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick:)];
        [view addGestureRecognizer:tap];
        [self.providersScrollView addSubview:view];
    }
    NSLog(@"---------HH:%f",CGRectGetHeight(self.providersScrollView.frame));
    self.providersScrollView.contentSize = CGSizeMake(facilitatorArray.count*providersViewWidth+ (facilitatorArray.count*(providersViewGap)) + providersStartX, self.providersScrollView.frame.size.height);
    
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
