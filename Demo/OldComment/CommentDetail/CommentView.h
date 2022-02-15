//
//  CommentView.h
//  Demo
//
//  Created by 崔婉莹 on 2022/2/10.
//

#import <UIKit/UIKit.h>
#import "CommentListView.h"
#import "CommentToolView.h"
#import "AppDelegate.h"
#import "PrefixHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentView : UIView

@end

@interface CommentManager : NSObject

+ (instancetype)shareManager;
- (void)showCommentWithSourceId:(NSString *)sourceId;

@end

NS_ASSUME_NONNULL_END
