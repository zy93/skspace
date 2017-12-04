//
//  WOTImageLookoverVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/20.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTImageLookoverVC.h"

@interface WOTImageLookoverVC ()<UIScrollViewDelegate>

@end

@implementation WOTImageLookoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.backgroundColor = Black;
    self.imageView.backgroundColor = Black;
    self.view.backgroundColor = Black;
    _mainimageurl = @"";
    
    if (_mainimage) {
          [_imageView sd_setImageWithURL:[NSURL URLWithString:_mainimageurl] placeholderImage:_mainimage];
    }
  
    if (_imageView.image) {
          _scrollView.contentSize = _imageView.image.size;
    }
  
    _scrollView.bounces = false;
    _scrollView.delegate = self;
    _scrollView.maximumZoomScale = 5.0;    //设置图片最大放大到原来的5倍
    _scrollView.minimumZoomScale = 0.5;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
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
