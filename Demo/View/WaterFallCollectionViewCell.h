//
//  WaterFallCollectionViewCell.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import <UIKit/UIKit.h>
#import "ZFTableData.h"

//#import "LayoutConstraint.h"

@interface WaterFallCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ZFTableData *data;
@property (nonatomic, strong) UIButton *likeBtn;

@end
