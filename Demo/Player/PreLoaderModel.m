//
//  PreLoaderModel.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import "PreLoaderModel.h"

@implementation PreLoaderModel

- (instancetype)initWithURL: (NSString *)url loader: (KTVHCDataLoader *)loader
{
	if (self = [super init])
	{
		_url = url;
		_loader = loader;
	}
	return self;
}


@end
