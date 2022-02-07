//
//  ZFTableData.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import <Foundation/Foundation.h>
#import "PlayableProtocol.h"
#import <UIKit/UIKit.h>

@interface ZFTableData : NSObject<XSTPlayable>
/// 记录播放进度
@property (nonatomic, assign) NSTimeInterval current_time;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *head;
@property (nonatomic, assign) NSInteger agree_num;
@property (nonatomic, assign) NSInteger share_num;
@property (nonatomic, assign) NSInteger post_num;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat thumbnail_width;
@property (nonatomic, assign) CGFloat thumbnail_height;
@property (nonatomic, assign) CGFloat video_duration;
@property (nonatomic, assign) CGFloat video_width;
@property (nonatomic, assign) CGFloat video_height;
@property (nonatomic, copy) NSString *thumbnail_url;
@property (nonatomic, copy) NSString *video_url;

@end
