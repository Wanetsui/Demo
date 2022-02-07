//
//  ZFKSControlView.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/ZFPlayer.h>

@interface ZFKSControlView : UIView <ZFPlayerMediaControl>

- (void)resetControlView;

- (void)showCoverViewWithUrl:(NSString *)coverUrl withImageMode:(UIViewContentMode)contentMode;

@end
