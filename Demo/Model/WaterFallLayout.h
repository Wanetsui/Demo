//
//  WaterFallLayout.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import <UIKit/UIKit.h>

@class WaterFallLayout;

@protocol WaterFallLayoutDataSource <NSObject>

@required
/// 获取item高度，返回itemWidth和indexPath去获取
- (CGFloat)waterFallLayout: (WaterFallLayout *)layout itemHeightForItemWidth: (CGFloat)itemWidth atIndexPath: (NSIndexPath *)indexPath;

@end

@interface WaterFallLayout : UICollectionViewLayout

@property (nonatomic, weak) id<WaterFallLayoutDataSource> dataSource;
/// 根据设置的列数，列间距，返回itemWidth
@property (nonatomic, readonly) CGFloat itemWidth;
/// 总共有多少列，默认为2
@property (nonatomic) NSInteger column;
/// 列间距，默认为0
@property (nonatomic) CGFloat columnSpacing;
/// 行间距
@property (nonatomic) CGFloat rowSpacing;
/// section与collectionView的间距，默认是（0，0，0，0）
@property (nonatomic) UIEdgeInsets sectionInset;

+ (instancetype)waterFallLayoutWithColumn:(NSInteger)column;
- (instancetype)initWIthColumn:(NSInteger)column;


@end
