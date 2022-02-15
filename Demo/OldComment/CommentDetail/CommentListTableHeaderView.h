//
//  CommentListTableHeaderView.h
//  Demo
//
//  Created by 崔婉莹 on 2022/2/10.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentListTableHeaderView : UIView

@property (nonatomic, copy) void(^closeBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
