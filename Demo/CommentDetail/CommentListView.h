//
//  CommentListView.h
//  Demo
//
//  Created by 崔婉莹 on 2022/2/10.
//

#import <UIKit/UIKit.h>
#import "CommentToolView.h"
#import "CommentListTableHeaderView.h"
#import "CommentListContentCell.h"
#import "CommentListReplyContentCell.h"
#import "PrefixHeader.h"

#define CommentViewTopHeight 101
#define ComentBottomViewHeight 55

NS_ASSUME_NONNULL_BEGIN

@interface CommentListView : UIView

@property (nonatomic, strong) CommentToolView *toolView;
@property (nonatomic, copy) void(^sendBtnBlock)(NSString *text);
@property (nonatomic, copy) void(^closeBtnBlock)(void);
@property (nonatomic, copy) void(^replyBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
