//
//  ListLoader.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/20.
//

#import <Foundation/Foundation.h>

@class ListItem;

NS_ASSUME_NONNULL_BEGIN

typedef void(^ListLoaderFinishBlock)(BOOL success, NSArray<ListItem *> *dataArray);

@interface ListLoader : NSObject

-(void)loadListDataWithFinishBlock:(ListLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
