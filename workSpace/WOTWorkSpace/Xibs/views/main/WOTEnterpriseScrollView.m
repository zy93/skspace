//
//  WOTEnterpriseScrollView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/8.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterpriseScrollView.h"
#import "WOTEnterpriseModel.h"
#import "UIImageView+AFNetworking.h"

#define enterpriseIVSpaceStartX 20
#define enterpriseIVSpaceGap   10
#define enterpriseIVWidth    ([[UIScreen mainScreen] bounds].size.width-(enterpriseIVSpaceGap*4))/3



@implementation WOTEnterpriseScrollView



-(void)setData:(NSArray *)data
{
    NSArray *arr = self.subviews;
    for (UIView *view in arr) {
        [view removeFromSuperview];
    }
    for (int i = 0; i<data.count; i++) {
        WOTEnterpriseModel *model = data[i];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i==0?enterpriseIVSpaceStartX: (i*enterpriseIVWidth)+((i)*enterpriseIVSpaceGap)+enterpriseIVSpaceStartX, 0, enterpriseIVWidth, self.frame.size.height)];
        [iv setImageWithURL:[model.companyPicture ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholder_logo"]];
        
        UILabel *companyName = [[UILabel alloc] initWithFrame:CGRectMake(i==0?enterpriseIVSpaceStartX: (i*enterpriseIVWidth)+((i)*enterpriseIVSpaceGap)+enterpriseIVSpaceStartX, self.frame.size.height-20, enterpriseIVWidth, 20)];
        companyName.backgroundColor =[UIColor colorWithWhite:0.0 alpha:0.3];;
        companyName.textAlignment = NSTextAlignmentCenter;
        [companyName setFont:[UIFont systemFontOfSize:12]];
        companyName.textColor = [UIColor whiteColor];
        companyName.text = model.companyName;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:iv.frame];
        
        [self addSubview:iv];
        [self addSubview:companyName];
        [self addSubview:btn];
    }
    self.contentSize = CGSizeMake(enterpriseIVWidth*data.count+(enterpriseIVSpaceGap*(data.count+1)+enterpriseIVSpaceStartX), self.frame.size.height);
}

-(void)selectBtn:(UIButton *)sender
{
    if ([_mDelegate respondsToSelector:@selector(enterpriseScroll:didSelectWithIndex:)]) {
        [_mDelegate enterpriseScroll:self didSelectWithIndex:sender.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
