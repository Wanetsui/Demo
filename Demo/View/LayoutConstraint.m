//
//  LayoutConstraint.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/25.
//

#import "LayoutConstraint.h"

@implementation LayoutConstraint

- (instancetype)init{
    self = [super init];
    if (!self) return nil;
    
    UIView *purpleView = UIView.new;
    purpleView.backgroundColor = UIColor.purpleColor;
    purpleView.layer.borderColor = UIColor.blackColor.CGColor;
    purpleView.layer.borderWidth = 2;
    [self addSubview:purpleView];
    
    //example of using constants
    
    [purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.left.equalTo(@20);
        make.bottom.equalTo(@-20);
        make.right.equalTo(@-20);
    }];
    return self;
}

@end
