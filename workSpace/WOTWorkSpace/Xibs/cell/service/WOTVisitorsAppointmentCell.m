//
//  WOTVisitorsAppointmentCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTVisitorsAppointmentCell.h"

@implementation WOTVisitorsAppointmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    self.contentText.delegate = self;
    self.manBtn.layer.borderColor = UIColor_blue_40.CGColor;
    self.manBtn.layer.borderWidth = 1.f;
    self.manBtn.layer.cornerRadius = 5.f;
    
    self.womBtn.layer.borderColor = UIColor_gray_89.CGColor;
    self.womBtn.layer.borderWidth = 1.f;
    self.womBtn.layer.cornerRadius = 5.f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
   // NSLog(@"测试：%@",textField.text);
    if ([_delegate respondsToSelector:@selector(textFiledEndEnter:text:)]) {
        [_delegate textFiledEndEnter:self text:textField.text];
    }
}
- (IBAction)manBtn:(id)sender {
    self.manBtn.selected = YES;
    self.womBtn.selected = NO;
    self.manBtn.layer.borderColor = UIColor_blue_40.CGColor;
    self.womBtn.layer.borderColor = UIColor_gray_89.CGColor;
    if ([_delegate respondsToSelector:@selector(textFiledEndEnter:text:)]) {
        [_delegate textFiledEndEnter:self text:@"Man"];
    }
}

- (IBAction)womBtn:(id)sender {
    self.manBtn.selected = NO;
    self.womBtn.selected = YES;
    self.womBtn.layer.borderColor = UIColor_blue_40.CGColor;
    self.manBtn.layer.borderColor = UIColor_gray_89.CGColor;
    if ([_delegate respondsToSelector:@selector(textFiledEndEnter:text:)]) {
        [_delegate textFiledEndEnter:self text:@"wom"];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hiddleKeyboard];
    return YES;
}


-(void)hiddleKeyboard{
    [self.contentText resignFirstResponder];
}





//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.contentText resignFirstResponder];
//
//}

@end
