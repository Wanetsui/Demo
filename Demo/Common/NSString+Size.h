//
//  NSString+Size.h
//  Demo
//
//  Created by 崔婉莹 on 2022/2/10.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Size)

- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

+ (NSString *)reverseString:(NSString *)strSrc;

+ (CGFloat)heightWithLabelSizeToFitContent:(NSString *)content numberOfLines:(NSInteger)line constrainedToWidth:(CGFloat)width;

+ (BOOL)content:(NSString *)content beyondMaxLine:(NSInteger)line constrainedToWidth:(CGFloat)width;

@end
