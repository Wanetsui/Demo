//
//  CoverView.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/20.
//

#import "CoverView.h"
#import "ListItem.h"
#import "SDWebImage.h"
#import "PlayerToolbar.h"

@interface CoverView ()

@property (nonatomic, strong, readwrite) UIImageView *coverView;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, strong, readwrite) UILabel *title;
@property (nonatomic, strong, readwrite) UILabel *time;
@property (nonatomic, strong, readwrite) PlayerToolbar *toolbar;

@end

@implementation CoverView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];

	if (self) {

		[self addSubview:({
			_coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - PlayerToolbarHeight)];
			_coverView;
		})];

		[_coverView addSubview:({
//            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake( (frame.size.width - 50) / 2, (frame.size.height - 50) / 2, 50, 50)];
			_playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - 50) / 2, (frame.size.height - PlayerToolbarHeight - 50) / 2, 50, 50)];
			_playButton.image = [UIImage imageNamed:@"videoPlay"];
			_playButton;
		})];

		[self addSubview:({
			_toolbar = [[PlayerToolbar alloc] initWithFrame:CGRectMake(0, _coverView.bounds.size.height, frame.size.width, PlayerToolbarHeight)];
			_toolbar;
		})];
	}
	return self;
}

- (void)dealloc {
}

#pragma mark - public method

- (void)layoutWithCoverUrl:(ListItem *)item {
//    self.title.textColor = [UIColor blackColor];
//    self.title.text = item.authorName;
//    [self.title sizeToFit];
//
//    self.time.text = item.date;
//    [self.time sizeToFit];
//    self.time.frame = CGRectMake(self.title.frame.origin.x + self.title.frame.size.width + 5, self.time.frame.origin.y, self.time.frame.size.width, self.time.frame.size.height);
	[self.coverView sd_setImageWithURL:[NSURL URLWithString:item.picURL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL){
	 }];
	[_toolbar layoutWithModel:nil];
}

@end
