//
//  WOTMenuView.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WOTFilterTypeModel.h"
@class DropMenuView;

#pragma mark - 协议
@protocol WOTMenuDelegate <NSObject>

@required
- (void)menu:(DropMenuView *)menu tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark - 数据源

@protocol WOTMenuDataSource <NSObject>

//防止下拉错位
- (CGFloat)menu_updateFilterViewPosition;

@required

- (NSMutableArray<WOTFilterTypeModel *> *)menu_filterDataArray;

@end


@interface WOTMenuView : UIView
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *transformImageView;

@property (nonatomic, weak) id<WOTMenuDataSource> dataSource;
@property (nonatomic, weak) id<WOTMenuDelegate> delegate;

- (void)reloadData;
- (void)backgroundTapped;
- (void)menuTappedWithSuperView:(UIView *)view;

- (WOTMenuView *)initWithOrigin:(CGPoint)origin;
@end
