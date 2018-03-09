//
//  WOTFeaturedProvidersCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/8.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTFeaturedProvidersCell;

@protocol WOTFeaturedProvidersCellDelegate <NSObject>
-(void)featuredProvidersCell:(WOTFeaturedProvidersCell *)cell selectIndex:(NSIndexPath *)index;

@end

@interface WOTFeaturedProvidersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *type1Lab;
@property (weak, nonatomic) IBOutlet UILabel *type2Lab;
@property (weak, nonatomic) IBOutlet UILabel *type3Lab;
@property (weak, nonatomic) IBOutlet UILabel *type4Lab;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIImageView *contentIV;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLab;
@property (weak, nonatomic) IBOutlet UILabel *subtitle2Lab;
@property (nonatomic, strong) NSIndexPath * index;
@property (nonatomic, strong) id <WOTFeaturedProvidersCellDelegate> delegate;

@end
