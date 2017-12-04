//
//  WOTworkSpaceScrollVIewCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTworkSpaceScrollVIewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,copy) void (^collectionImageViewBlock)(NSInteger index);
@end
