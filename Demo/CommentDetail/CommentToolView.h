//
//  CommentToolView.h
//  Demo
//
//  Created by 崔婉莹 on 2022/2/10.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"

#define CommentEditToolViewHeight 60

NS_ASSUME_NONNULL_BEGIN

@interface CommentToolView : UIView

@property (nonatomic, copy) void(^sendBtnBlock)(NSString*text);
@property (nonatomic, copy) void(^changeTextBlock)(NSString *text,CGRect frame);
@property (nonatomic, strong) PlaceholderTextView *textView;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) CGFloat defaultHeight;
@property (nonatomic, assign) CGFloat defaultY;
- (void)showTextView;
- (void)hideTextView;
- (void)resetView;

@end

NS_ASSUME_NONNULL_END
