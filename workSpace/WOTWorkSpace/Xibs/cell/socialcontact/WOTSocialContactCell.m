//
//  WOTSocialContactCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/21.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSocialContactCell.h"
#import "WOTImageCollectionViewCell.h"
#import "MBProgressHUD+Extension.h"
@interface WOTSocialContactCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation WOTSocialContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _contactName.textColor = MainOrangeColor;
    _time.textColor = MiddleTextColor;
    _contactName.textColor = HighTextColor;
    [_headerImage setCorenerRadius:_headerImage.frame.size.height/2 borderColor:CLEARCOLOR];
    _collectionview.delegate = self;
    _collectionview.dataSource =self;
    [_collectionview setScrollEnabled:NO];
    [_collectionview registerNib:[UINib nibWithNibName:@"WOTImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WOTImageCollectionViewCellID"];
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

-(void)setData:(WOTFriendsMessageModel *)data
{
    _data = data;
//    NSURL *url = ;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPBaseURL,data.picture]] placeholderImage:nil];
    [self.contactName setText:data.userName];
    [self.content setText:data.textWord];
    [self.time setText:[NSDate timeDifference:data.creationTime]];
    NSArray *arr = [data.sharePicture componentsSeparatedByString:@","];
    _photosArray = [arr copy];
    [self.collectionview reloadData];
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
    WOTImageCollectionViewCell *cell = [_collectionview dequeueReusableCellWithReuseIdentifier:@"WOTImageCollectionViewCellID" forIndexPath:indexPath];
     ;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPBaseURL,_photosArray[indexPath.row]]];
    [cell.cityImage sd_setImageWithURL:url placeholderImage:nil];
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
    return UIEdgeInsetsMake(10, 5, 10, 10);//分别为上、左、下、右
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
}

//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
}

- (IBAction)reportButton:(id)sender {
    [MBProgressHUDUtil showMessage:@"举报已经提交！" toView:self.superview];
    NSLog(@"被举报了！");
}

@end
