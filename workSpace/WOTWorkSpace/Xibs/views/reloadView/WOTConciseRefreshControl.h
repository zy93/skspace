//
//  WOTConciseRefreshControl.h
//  YNCCProduct
//
//  Created by YNKJMACMINI4 on 16/6/30.
//  Copyright © 2016年 YNKJMACMINI2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTConciseRefreshControl : UIControl
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIImageView *centerImage;
@property (strong, nonatomic) IBOutlet UILabel *reloadText;
@property (strong, nonatomic) IBOutlet UIImageView *centerTopImage;
@property (strong, nonatomic) IBOutlet UIView *centerView;



@property (nonatomic,assign) BOOL forbidSunSet;
@property (nonatomic,assign) BOOL forbidContentInsetChanges;
@property (nonatomic, assign) BOOL imageIsRoting;
@property (nonatomic, strong) UIScrollView *scrollView;


- (instancetype)initWithFrame:(CGRect)frame;
- (void)attachToScrollView:(UIScrollView *)scrollView;
-(void)endRefreshing;
@end
