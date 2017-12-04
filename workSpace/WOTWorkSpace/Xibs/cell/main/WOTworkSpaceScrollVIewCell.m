//
//  WOTworkSpaceScrollVIewCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTworkSpaceScrollVIewCell.h"
#import "WOTImageCollectionViewCell.h"
@interface WOTworkSpaceScrollVIewCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
@implementation WOTworkSpaceScrollVIewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"WOTImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WOTImageCollectionViewCellID"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [WOTSingtleton shared].spaceCityArray.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    WOTImageCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"WOTImageCollectionViewCellID" forIndexPath:indexPath];
    NSArray *imageArrays = @[@"space_bj",@"space_bj", @"space_sh",@"space_tj",@"space_sz",@"space_bj",@"space_sh",@"space_tj",@"space_sz"];

    cell.cityImage.image = [UIImage imageNamed:imageArrays[indexPath.row]];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (IS_IPHONE_5) {
          return CGSizeMake(self.collectionView.frame.size.width/3.8, self.collectionView.frame.size.height-40);
    } else {
          return CGSizeMake(self.collectionView.frame.size.width/3.5, self.collectionView.frame.size.height-40);
    }
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}

//每个item之间的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 100;
//}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
      UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor greenColor]];
    if (self.collectionImageViewBlock != nil) {
       weakSelf.collectionImageViewBlock(indexPath.row);
    }
}

//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor redColor]];
}

@end
