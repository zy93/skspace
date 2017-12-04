//
//  WOTPhotosBaseUtils.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/18.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTPhotosBaseUtils.h"
#import "ZSImagePickerController.h"
#import <Photos/Photos.h>
@interface WOTPhotosBaseUtils ()

@end

@implementation WOTPhotosBaseUtils : NSObject 

-(instancetype)init{
    self = [super init];
    if (self) {
        _vc = [[UIViewController alloc]init];
        _onlyOne = YES;
    }
    return  self;
}

/**
 
 * 打开相机
 
 */
- (void)openCamera

{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = _vc;
    imagePicker.allowsEditing = YES;
    //判断是否可以打开照相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [_vc presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
    else
        
    {
        
        [MBProgressHUDUtil showMessage:@"摄像头不可用" toView:_vc.view];
        
    }
    
}

-(void)showSelectedPhotoSheet{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self addActionTarget:alert title:@"拍照" color: [UIColor blackColor] action:^(UIAlertAction *action) {
        [self openCamera];
    }];
    [self addActionTarget:alert title:@"从相册中选择" color:[UIColor blackColor] action:^(UIAlertAction *action) {
        [self openPhotoLibrary];
    }];
    [self addCancelActionTarget:alert title:@"取消"];
    [_vc presentViewController:alert animated:YES completion:nil];
    
}




- (void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(UIColor *)color action:(void(^)(UIAlertAction *action))actionTarget
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        actionTarget(action);
    }];
    [action setValue:color forKey:@"_titleTextColor"];
    [alertController addAction:action];
}

-(void)addCancelActionTarget:(UIAlertController*)alertController title:(NSString *)title
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [action setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    [alertController addAction:action];
}


/**
 
 *  打开相册
 
 */

-(void)openPhotoLibrary

{
    // 进入相册
    if (_onlyOne) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            
            UIImagePickerController *imageVC = [[UIImagePickerController alloc]init];
            imageVC.allowsEditing = YES;
            imageVC.delegate = _vc;
            imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [_vc presentViewController:imageVC animated:YES completion:^{
                NSLog(@"打开相册");
            }];
        }
        else
        {
            NSLog(@"不能打开相册");
            
        }
    }
    else
    {
        ZSImagePickerController *imagePicker = [[ZSImagePickerController alloc]init];
        imagePicker.isNeedCustom = YES;
        imagePicker.zs_delegate = _vc;
        [_vc presentViewController:imagePicker animated:YES completion:nil];
    }
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
