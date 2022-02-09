//
//  Login.h
//  Demo
//
//  Created by 崔婉莹 on 2022/2/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginFinishBlock)(BOOL isLogin);

@interface Login : NSObject

@property(nonatomic, strong, readonly)NSString *nick;
@property(nonatomic, strong, readonly)NSString *address;
@property(nonatomic, strong, readonly)NSString *avatarUrl;

+ (instancetype)sharedLogin;

#pragma - mark - 登录

- (BOOL)isLogin;
- (void)loginWithFinishBlock:(LoginFinishBlock)finishBlock;
- (void)logOut;

#pragma mark - 分享
- (void)shareToQQWithArticleUrl:(NSURL *)articleUrl;

@end

NS_ASSUME_NONNULL_END
