//
//  WOTSocialContactCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/21.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTSocialContactsBean.h"
#import "WOTFriendsMessageListModel.h"
@interface WOTSocialContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (weak, nonatomic) IBOutlet UILabel *content;
//@property(nonatomic,strong) WOTSocialContactsBean *cellBean;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic,strong)NSMutableArray *photosArray;

@property (nonatomic, strong) WOTFriendsMessageModel *data;

@end
