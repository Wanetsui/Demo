//
//  LayerAttributeManager.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import <Foundation/Foundation.h>
#import <ZFPlayer/ZFPlayerMediaPlayback.h>

NS_ASSUME_NONNULL_BEGIN

/// 视频属性，视频资源等管理
@interface LayerAttributeManager : NSObject<ZFPlayerMediaPlayback>

@property (nonatomic) BOOL shouldAutoPlay;

@end

NS_ASSUME_NONNULL_END
