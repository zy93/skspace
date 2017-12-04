//
//  WOTworkSpaceSearchCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTworkSpaceSearchCell.h"
#import "UISearchBar+JCSearchBarPlaceholder.h"

@interface WOTworkSpaceSearchCell()<UISearchBarDelegate>
@property (strong, nonatomic) UISearchBar *searchBar;
@end
@implementation WOTworkSpaceSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, self.contentView.frame.size.height)];
    
    [_searchBar changeLeftPlaceholder:@"搜索城市或空间"];
    [_searchBar setBarTintColor:White];
    [_searchBar setTintColor:White];
    [_searchBar setBackgroundColor:White];
    _searchBar.delegate = self;
    _searchBar.searchBarStyle = UISearchBarStyleMinimal; 
    _searchBar.layer.borderWidth = 0;
   
    
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    
    if (is7Version) {
        
        _searchField = [[[_searchBar.subviews firstObject] subviews] lastObject];
        
    }else{// iOS6以下版本searchBar内部子视图的结构不一样
        for(UIView *subview in _searchBar.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                _searchField = subview;
                
            }
        }
    }
    _searchField.backgroundColor = MainColor;
    
    [self.contentView addSubview:_searchBar];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
//    UITextField *searchTextField = nil;
//    if (is7Version) {
//        
//        searchTextField = [[[_searchBar.subviews firstObject] subviews] lastObject];
//        
//    }else{// iOS6以下版本searchBar内部子视图的结构不一样
//        for(UIView *subview in _searchBar.subviews)
//        {
//            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
//                searchTextField = subview;
//                
//            }
//        }
//    }
//    [searchTextField resignFirstResponder];
//}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (_searchBarBlock) {
        self.searchBarBlock(searchBar.text);
    }
}
@end
