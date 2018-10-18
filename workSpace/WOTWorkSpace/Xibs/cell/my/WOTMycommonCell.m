//
//  WOTMycommonCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMycommonCell.h"
#import "UIColor+ColorChange.h"

#import "WOTConstants.h"
@implementation WOTMycommonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubViews];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}


-(void)loadSubViews{
 
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = UICOLOR_MAIN_BLACK;
    _nextImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backAcssory"]];
    _redDotImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redDot"]];
    _cellImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"enterprise"]];
    _cellImage.contentMode = UIViewContentModeScaleAspectFit;
    _lineview = [[UIView alloc]init];
    _lineview.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [self.contentView addSubview:_lineview];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_nextImageView];
    [self.contentView addSubview:_cellImage];
    [self.contentView addSubview:_redDotImage];
    
}
-(void)layoutSubviews{
  
    
    [_nextImageView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.right.mas_equalTo(self.contentView).offset(-8);
        maker.centerY.mas_equalTo(self.contentView);
        maker.height.mas_equalTo(13);
        maker.width.mas_equalTo(7);
    }];
    
    [_redDotImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nextImageView);
        make.width.height.mas_offset(6);
        make.right.equalTo(_nextImageView.mas_left).with.offset(-5);
    }];
    
    [_lineview mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.height.mas_equalTo(1);
        maker.bottom.mas_equalTo(self.contentView);
        maker.left.mas_equalTo(self.contentView);
        maker.right.mas_equalTo(self.contentView);
    }];
    
    
    [_cellImage mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.height.mas_equalTo(25);
        maker.width.mas_equalTo(19);
        maker.left.mas_equalTo(self.contentView).offset(20);
        maker.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.left.mas_equalTo(self.cellImage.mas_right).offset(10);
        maker.centerY.mas_equalTo(self.contentView);
    }];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
