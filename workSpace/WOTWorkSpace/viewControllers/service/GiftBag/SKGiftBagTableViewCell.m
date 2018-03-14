//
//  SKGiftBagTableViewCell.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/26.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKGiftBagTableViewCell.h"
#import "Masonry.h"

@implementation SKGiftBagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.giftBagImageView = [[UIImageView alloc] init];
        [self addSubview:self.giftBagImageView];
        [self imageViewLayout];
    }
    return self;
}

-(void)imageViewLayout
{
    [self.giftBagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.height.mas_offset(180);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
