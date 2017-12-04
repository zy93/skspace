//
//  WOTSpaceCityScrollView.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSpaceCityScrollView.h"
#import "WOTSpaceCityCollectionCell.h"
#import "WOTCityTileView.h"
@interface WOTSpaceCityScrollView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
}
@property(nonatomic,strong) WOTSpaceCityCollectionCell *collectionCell;

@property(nonatomic,strong)WOTCityTileView *tileview;
@end
@implementation WOTSpaceCityScrollView

-(void)awakeFromNib{
    [super awakeFromNib];
    _collectionVIew.delegate = self;
    _collectionVIew.dataSource = self;
    self.contentView.backgroundColor = White;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scrollToCity:) name:@"scrollToDestinationCity" object:nil];
    _moreImage.image = [UIImage imageNamed:@"mainmore_unselected"];
    [_moreBtn setSelected: NO];
    
    _tileview = [[WOTCityTileView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH,[WOTSingtleton shared].spaceCityArray.count/4*50+50)];
    [self insertSubview:_tileview aboveSubview:self.moreBtn];
    
    
    
    [_tileview setHidden:YES];
    
    
    
}


#pragma mark --懒加载

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
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld",indexPath.row];
      [_collectionVIew registerNib:[UINib nibWithNibName:@"WOTSpaceCityCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    _collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    _collectionCell.cityName.text = [[WOTSingtleton shared].spaceCityArray objectAtIndex:indexPath.row];
    if (self.selectedindex == indexPath.row) {
        _collectionCell.cityName.textColor = RGBA(77.0, 139.0, 231.0, 1.0);
        [_collectionCell.cityName setCorenerRadius:10 borderColor:RGBA(77.0, 139.0, 231.0, 1.0)];
    } else {
        _collectionCell.cityName.textColor = MiddleTextColor;
        [_collectionCell.cityName setCorenerRadius:10 borderColor:MiddleTextColor];
    }
    
   
    return _collectionCell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionVIew.frame.size.width/5, 35);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 5);
}


//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    WOTSpaceCityCollectionCell *cell = (WOTSpaceCityCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.cityName.textColor = RGBA(77.0, 139.0, 231.0, 1.0);
//    [cell.cityName setCorenerRadius:10 borderColor:RGBA(77.0, 139.0, 231.0, 1.0)];
    self.selectedindex = indexPath.row;
    if ([_delegate respondsToSelector:@selector(selectWithCity:)]) {
        [_delegate selectWithCity:self.selectedindex];
    }
    [self.collectionVIew reloadData];
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    WOTSpaceCityCollectionCell *cell = (WOTSpaceCityCollectionCell *) [collectionView cellForItemAtIndexPath:indexPath];
//    cell.cityName.textColor = HighTextColor;
//    [cell.cityName setCorenerRadius:10 borderColor:HighTextColor];
}
- (IBAction)moreAction:(id)sender {
    
    [_moreBtn setSelected:!_moreBtn.isSelected];
    
    _moreImage.image = _moreBtn.isSelected ? [UIImage imageNamed:@"mainmore_selected"]:[UIImage imageNamed:@"mainmore_unselected"];
    [self.tileview setHidden:!_moreBtn.isSelected];
    
    
}
//MARK：注册通知方法
-(void)scrollToCity:(NSNotification *)noti{
    NSIndexPath *ii = noti.userInfo[@"cityindex"];
    
    [_collectionVIew scrollToItemAtIndexPath:ii atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    self.selectedindex = ii.row;
    [_collectionVIew reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
