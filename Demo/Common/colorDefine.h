//
//  colorDefine.h
//  Demo
//
//  Created by 崔婉莹 on 2022/2/10.
//
#define RGBHexColor(hexValue, alphaValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
// Views
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define STATUS_BAR_HEIGHT CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
#define NAV_BAR_HEIGHT 74
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)
//iPhone X底部边距
#define SAFE_AREA_BOTTOM (STATUS_BAR_HEIGHT > 25 ? 34.0 : 0.0)

// block
#define weakify(var) \
try {} @catch (...) {} \
__weak __typeof__(var) var ## _weak = var;


#define strongify(var) \
try {} @catch (...) {} \
__strong __typeof__(var) var = var ## _weak;
