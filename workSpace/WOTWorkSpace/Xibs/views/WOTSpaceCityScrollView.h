//
//  WOTSpaceCityScrollView.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTSpaceCityScrollView;
@protocol WOTSpaceCityScrollViewDelegate<NSObject>
@required

-(void)spaceCityScrollView:(WOTSpaceCityScrollView*)scrollView selectCity:(NSString *)cityName;

@end
@interface WOTSpaceCityScrollView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;
@property (weak, nonatomic) IBOutlet UIImageView *moreImage;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (nonatomic, strong) NSArray *cityList;
@property(nonatomic,strong)id<WOTSpaceCityScrollViewDelegate>delegate;
@property NSInteger selectedindex;


@end
