//
//  WOTApplyRepairCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/20.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTApplyRepairCell.h"
#import "WOTImageCollectionViewCell.h"
@interface WOTApplyRepairCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation WOTApplyRepairCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _cellTitle.textColor = HighTextColor;
    _cellValue.textColor = MiddleTextColor;
    _collectionView.delegate = self;
    _collectionView.dataSource =self;
    [_collectionView setScrollEnabled:NO];
     [_collectionView registerNib:[UINib nibWithNibName:@"WOTImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WOTImageCollectionViewCellID"];
  
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(NSMutableArray *)photosArray{
    if (_photosArray) {
        _photosArray = [[NSMutableArray alloc]init];
        
    }
    return _photosArray;
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
    return _photosArray.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    WOTImageCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"WOTImageCollectionViewCellID" forIndexPath:indexPath];
    
    cell.cityImage.image = _photosArray[indexPath.row];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (IS_IPHONE_5) {
        return CGSizeMake((SCREEN_WIDTH-20)/3.8,(SCREEN_WIDTH-20)/3.8);
    } else {
        return CGSizeMake((SCREEN_WIDTH-20)/3.5,(SCREEN_WIDTH-20)/3.5);
    }
    
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  
    if (self.collectionImageViewBlock != nil) {
        weakSelf.collectionImageViewBlock(indexPath.row);
    }
}

//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
}
@end
