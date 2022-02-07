//
//  PreLoaderModel.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import <Foundation/Foundation.h>
#import <KTVHTTPCache.h>
NS_ASSUME_NONNULL_BEGIN

/// 预加载模型
@interface PreLoaderModel : NSObject

/// 加载的URL
@property (nonatomic, copy, readonly) NSString *url;
/// 请求URL的Loader
@property (nonatomic, strong, readonly) KTVHCDataLoader *loader;

- (instancetype)initWithURL: (NSString *)url loader: (KTVHCDataLoader *)loader;

@end

NS_ASSUME_NONNULL_END

