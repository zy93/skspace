//
//  WOTMyRepairdDetailCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/3/13.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTMyRepairdDetailCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *typeValueLab;
@property (weak, nonatomic) IBOutlet UILabel *addrLab;
@property (weak, nonatomic) IBOutlet UILabel *addrValueLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *timeValueLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *contentValueLab;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray * selectedPhotos;
@property (nonatomic, strong) NSString *pictureStr;

@end
