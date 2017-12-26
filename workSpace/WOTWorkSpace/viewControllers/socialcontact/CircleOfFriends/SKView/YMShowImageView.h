//
//  YMShowImageView.h
//  WFCoretext
//
//  Created by 阿虎 on 14/11/3.
//  Copyright (c) 2014年 tigerwf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YMShowImageViewDelegate <NSObject>
-(void)showTarbar;
@end

typedef  void(^didRemoveImage)(void);

@interface YMShowImageView : UIView<UIScrollViewDelegate>
{
    UIImageView *showImage;
}
@property (nonatomic,copy) didRemoveImage removeImg;
@property(nonatomic,weak) id<YMShowImageViewDelegate> delegate;

- (void)show:(UIView *)bgView didFinish:(didRemoveImage)tempBlock;

- (id)initWithFrame:(CGRect)frame byClick:(NSInteger)clickTag appendArray:(NSArray *)appendArray;

@end
