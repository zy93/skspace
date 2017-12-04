//
//  WOTEnterpriseConnectsInfoVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTEnterpriseConnectsInfoVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *telTextfield;

@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;

@property (nonatomic,copy) void (^cancelBlokc)();

@property (nonatomic,copy) void (^okBlock)(NSString *name,NSString *tel,NSString *email);



@end
