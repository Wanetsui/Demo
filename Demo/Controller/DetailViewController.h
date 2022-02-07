//
//  DetailViewController.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import <UIKit/UIKit.h>
#import "PlayerController.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController<UINavigationControllerDelegate>

@property (nonatomic, strong) PlayerController *player;
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *startView;
@property (nonatomic, strong) UIImage *startImage;
@property (nonatomic, copy) void (^popbackBlock)(void);

@end

NS_ASSUME_NONNULL_END
