//
//  WOTCityTileView.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/28.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTCityTileView.h"
#import "WOTSpaceCityCollectionCell.h"
@interface WOTCityTileView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIView *markView;
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation WOTCityTileView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(WOTCityTileView *)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        
        self.backgroundColor = CLEARCOLOR;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(frame.origin.x,0, SCREEN_WIDTH,[WOTSingtleton shared].spaceCityArray.count/4*50+50) collectionViewLayout:layout];
        _collectionView.backgroundColor = White;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        
     
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView:) ];
        tapGestureRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tapGestureRecognizer];
   
    
   
        
    }
    return self;
}

-(void)hiddenView:(UITapGestureRecognizer*)tap{
    [self setHidden:YES];
    
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
    [collectionView registerNib:[UINib nibWithNibName:@"WOTSpaceCityCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
   WOTSpaceCityCollectionCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    collectionCell.cityName.text = [[WOTSingtleton shared].spaceCityArray objectAtIndex:indexPath.row];
   
        collectionCell.cityName.textColor = MiddleTextColor;
        [collectionCell.cityName setCorenerRadius:10 borderColor:MiddleTextColor];

    return collectionCell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width/5, 35);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10,0,0);
}


//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_tiledelegate respondsToSelector:@selector(selectedCityIndex:)]) {
        [self.tiledelegate selectedCityIndex:indexPath.row];
    }
    
    NSLog(@"选择index：%ld",indexPath.row);
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
 
}


@end
