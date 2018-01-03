//
//  WOTPickerView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTPickerView.h"

#define PICKERVIEW_HEIGHT  240

@interface WOTPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSInteger selectRow;
}

@property (retain, nonatomic) UIView *baseView;

@end

@implementation WOTPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commInit];
    }
    return self;
}



-(void)commInit
{
    
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-PICKERVIEW_HEIGHT, SCREEN_WIDTH, PICKERVIEW_HEIGHT)];
    _baseView.backgroundColor = [UIColor orangeColor];
    _baseView.clipsToBounds = YES;
    [self addSubview:_baseView];
    
    
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [toolView setBackgroundColor:[UIColor whiteColor]];
    [_baseView addSubview:toolView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, .5f)];
    [line setBackgroundColor:UIColorFromRGB(0x898989)];
    [toolView addSubview:line];
    
    _pickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(toolView.frame), SCREEN_WIDTH, PICKERVIEW_HEIGHT-CGRectGetHeight(toolView.frame))];
    _pickerV.delegate = self;
    _pickerV.dataSource = self;
    _pickerV.backgroundColor = [UIColor whiteColor];
    [_baseView addSubview:_pickerV];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_pickerV.frame)/2+CGRectGetMinY(_pickerV.frame)-19, SCREEN_WIDTH, .5f)];
    [line2 setBackgroundColor:UIColorFromRGB(0x898989)];
    [_baseView addSubview:line2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_pickerV.frame)/2+CGRectGetMinY(_pickerV.frame)+18.5, SCREEN_WIDTH, .5f)];
    [line3 setBackgroundColor:UIColorFromRGB(0x898989)];
    [_baseView addSubview:line3];
    
    
    UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 40, 40)];
    [btnOK setTitle:@"确定" forState:UIControlStateNormal];
    [btnOK setTitleColor:UIColorFromRGB(0x10c801) forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(pickerViewBtnOK:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:btnOK];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:UIColorFromRGB(0x898989) forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(pickerViewBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:btnCancel];
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPickerView)];
    [self addGestureRecognizer:tapGesture];

}


#pragma mark - UIPickerViewDataSource

//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [_dataSource numberOfComponentsInPickerView:self];
}

//每列对应多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_dataSource pickerView:self numberOfRowsInComponent:component];
}


#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if ([_delegate respondsToSelector:@selector(pickerView:widthForComponent:)]) {
       return [_delegate pickerView:self widthForComponent:component];
    }
    return 100;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if ([_delegate respondsToSelector:@selector(pickerView:rowHeightForComponent:)]) {
       return [_delegate pickerView:self rowHeightForComponent:component];
    }
    return 35;
}


//每行显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if ([_delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        return [_delegate pickerView:self titleForRow:row forComponent:component];
    }
    return nil;
}

//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    if ([_delegate respondsToSelector:@selector(pickerView:attributedTitleForRow:forComponent:)]) {
//        return [_delegate pickerView:self attributedTitleForRow:row forComponent:component];
//    }
//    return nil;
//}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
//{
//    if ([_delegate respondsToSelector:@selector(pickerView:viewForRow:forComponent:reusingView:)]) {
//        return [_delegate pickerView:self viewForRow:row forComponent:component reusingView:view];
//    }
//    return nil;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([_delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [_delegate pickerView:self didSelectRow:row inComponent:component];
    }
}

#pragma mark - Private Menthods

//弹出pickerView
- (void)popPickerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
    
}

//取消pickerView
- (void)dismissPickerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
}

-(void)reloadData
{
    [self.pickerV reloadAllComponents];
}

//确定
- (void)pickerViewBtnOK:(id)sender
{
    if (self.selectBlock) {
        self.selectBlock(YES, [self.pickerV selectedRowInComponent:0]);
    }
    [self dismissPickerView];
}

//取消
- (void)pickerViewBtnCancel:(id)sender
{
    if (self.selectBlock) {
        self.selectBlock(NO,0);
    }
    
    [self dismissPickerView];
    
}

@end
