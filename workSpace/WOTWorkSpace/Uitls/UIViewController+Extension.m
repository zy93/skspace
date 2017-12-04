//
//  UIViewController+Extension.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "UISearchBar+JCSearchBarPlaceholder.h"


@implementation UIViewController(Extension)
-(void)configNaviBackItem{
   
    UIBarButtonItem *backitem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goback)];
    
    [self.navigationItem.backBarButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setLeftBarButtonItem:backitem];
//    [self.tabBarController.tabBar setHidden:YES];
 
}


-(void)configNaviView:(NSString *)searchTitle block:(void(^)())search{
    UISearchBar *searchview = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 30.0)];

    [searchview changeLeftPlaceholder:searchTitle];
    [searchview setBarTintColor:[UIColor grayColor]];
    
    [searchview setBarStyle:UIBarStyleBlackTranslucent];
    
    UIView *searchTextField = nil;
    
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    
    if (is7Version) {
       
        searchTextField = [[[searchview.subviews firstObject] subviews] lastObject];
       
    }else{// iOS6以下版本searchBar内部子视图的结构不一样
        for(UIView *subview in searchview.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                searchTextField = subview;
                
            }
        }
    }
    searchTextField.backgroundColor = MainColor;
   
    search();
    [self.navigationItem setTitleView:searchview];
    
}


-(void)configNaviRightItemWithImage:(UIImage *)image{
    UIButton *rightbtn = [[UIButton alloc]init];
    [rightbtn setFrame:CGRectMake(0,0,25,25)];
    [rightbtn setImage:image forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightItemAction) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    
}


-(void)configNaviRightItemWithTitle:(NSString *)title textColor:(UIColor *)textColor{
    UIButton *rightbtn = [[UIButton alloc]init];
    [rightbtn setFrame:CGRectMake(0,0,50,30)];
    [rightbtn setTitle:title forState:UIControlStateNormal];
    [rightbtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [rightbtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    [rightbtn setTitleColor:textColor forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightItemAction) forControlEvents: UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightbtn];
    
}



-(void)goback{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(void)rightItemAction{
    //跳转页面
}
@end
