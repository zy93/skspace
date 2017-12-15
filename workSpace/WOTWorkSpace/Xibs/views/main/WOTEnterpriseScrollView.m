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
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake((i*enterpriseIVWidth)+( (i+1)*enterpriseIVSpaceGap), 0, enterpriseIVWidth, self.frame.size.height)];
        [iv setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPBaseURL,model.companyPicture]] placeholderImage:[UIImage imageNamed:@"zhanwei"]];
        [self addSubview:iv];
    }
    self.contentSize = CGSizeMake(enterpriseIVWidth*data.count+(enterpriseIVSpaceGap*(data.count+1)), self.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
