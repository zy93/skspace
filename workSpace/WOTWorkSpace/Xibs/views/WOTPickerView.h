//
//  WOTPickerView.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTPickerView;

typedef void (^MyBasicBlock)(id _Nullable result);



@protocol WOTPickerViewDataSource <NSObject>
@required

- (NSInteger)numberOfComponentsInPickerView:(WOTPickerView *_Nullable)pickerView;
- (NSInteger)pickerView:(WOTPickerView *_Nullable)pickerView numberOfRowsInComponent:(NSInteger)component;

@end

@protocol WOTPickerViewDelegate <NSObject>

@optional

- (CGFloat)pickerView:(WOTPickerView *_Nullable)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED;
- (CGFloat)pickerView:(WOTPickerView *_Nullable)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED;
- (nullable NSString *)pickerView:(WOTPickerView *_Nullable)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED;
- (nullable NSAttributedString *)pickerView:(WOTPickerView *_Nullable)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED; // attributed title is favored if both methods are implemented
- (UIView *_Nullable)pickerView:(WOTPickerView *_Nullable)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED;

- (void)pickerView:(WOTPickerView *_Nullable)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED;
@end



@interface WOTPickerView : UIView

@property (nullable, nonatomic, weak) id <WOTPickerViewDelegate> delegate;
@property (nullable, nonatomic, weak) id <WOTPickerViewDataSource> dataSource;

@property (retain, nonatomic) UIPickerView * _Nullable pickerV;

@property (nonatomic, copy) MyBasicBlock _Nullable selectBlock;

- (void)popPickerView;

@end
