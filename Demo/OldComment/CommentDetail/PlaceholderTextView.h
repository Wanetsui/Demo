//
//  PlaceholderTextView.h
//  Demo
//
//  Created by 崔婉莹 on 2022/2/10.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceholderTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end

NS_ASSUME_NONNULL_END
