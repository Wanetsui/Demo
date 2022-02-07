//
//  Transition.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PlayerController;

/// 用于视频信息流的转场动画
@interface Transition : NSObject<UIViewControllerAnimatedTransitioning>

/**
   初始化动画

   @param duration 动画时长
   @param startView 开始视图
   @param startImage 开始图片
   @param  player 播放器
   @param operation 动画形式
   @param completion 动画完成block
   @return 动画实例
 */
+ (instancetype)animationWithDuration:(NSTimeInterval)duration
        startView:(UIView *)startView
        startImage:(UIImage *)startImage
        player: (PlayerController *)player
        operation:(UINavigationControllerOperation)operation
        completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
