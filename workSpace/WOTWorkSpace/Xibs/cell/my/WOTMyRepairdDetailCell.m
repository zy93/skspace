//
//  WOTMyRepairdDetailCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/13.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTMyRepairdDetailCell.h"

@implementation WOTMyRepairdDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //列距
    flowLayout.minimumInteritemSpacing = 30;
    //行距
    flowLayout.minimumLineSpacing = 40;
    //item大大小
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-60)/3, 200);
    //注册时用UICollectionViewCell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPictureStr:(NSString *)pictureStr
{
    _pictureStr = pictureStr;
    _selectedPhotos = [pictureStr componentsSeparatedByString:@","];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _selectedPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    UIImageView *iv = [[UIImageView alloc] init];
    [iv setImageWithURL:[self.selectedPhotos[indexPath.row] ToResourcesUrl]];
    [cell.contentView addSubview:iv];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(75, 75);
}



@end
