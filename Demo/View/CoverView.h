//
//  CoverView.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ListItem;

@interface CoverView : UICollectionViewCell

- (void)layoutWithCoverUrl:(ListItem *)item;

@end

NS_ASSUME_NONNULL_END
