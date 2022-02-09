//
//  Location.h
//  Demo
//
//  Created by 崔婉莹 on 2022/2/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Location : NSObject

+ (Location *)locationManager;

- (void)checkLocationAuthorization;

@end

NS_ASSUME_NONNULL_END
