//
//  ZFKSCell.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//
#import "ZFKSCell.h"
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/ZFUtilities.h>
#import "ZFLoadingView.h"
//#import "CommentView.h"

#import <Lottie/Lottie.h>

@interface ZFKSCell ()

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UIButton *likeBtn;

@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, strong) UIButton *shareBtn;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) UIView *effectView;

//@property (nonatomic, strong) LOTAnimationView *animation;

@end

@implementation ZFKSCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		[self.contentView addSubview:self.bgImgView];
		[self.bgImgView addSubview:self.effectView];
		[self.contentView addSubview:self.coverImageView];
		[self.contentView addSubview:self.titleLabel];
		[self.contentView addSubview:self.likeBtn];
		[self.contentView addSubview:self.commentBtn];
		[self.contentView addSubview:self.shareBtn];
      }
	return self;
}

- (void)switchToggled:(LOTAnimatedSwitch *)animatedSwitch {
  NSLog(@"The switch is %@", (animatedSwitch.on ? @"ON" : @"OFF"));
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.coverImageView.frame = self.contentView.bounds;
	self.bgImgView.frame = self.contentView.bounds;
	self.effectView.frame = self.bgImgView.bounds;

	CGFloat min_x = 0;
	CGFloat min_y = 0;
	CGFloat min_w = 0;
	CGFloat min_h = 0;
	CGFloat min_view_w = self.zf_width;
	CGFloat min_view_h = self.zf_height;
	CGFloat margin = 30;

	min_w = 40;
	min_h = min_w;
	min_x = min_view_w - min_w - 20;
	min_y = min_view_h - min_h - 80;
	self.shareBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);

	min_w = CGRectGetWidth(self.shareBtn.frame);
	min_h = min_w;
	min_x = CGRectGetMinX(self.shareBtn.frame);
	min_y = CGRectGetMinY(self.shareBtn.frame) - min_h - margin;
	self.commentBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);

	min_w = CGRectGetWidth(self.shareBtn.frame);
	min_h = min_w;
	min_x = CGRectGetMinX(self.commentBtn.frame);
	min_y = CGRectGetMinY(self.commentBtn.frame) - min_h - margin;
	self.likeBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);

	min_x = 20;
	min_h = 20;
	min_y = min_view_h - min_h - 50;
	min_w = self.likeBtn.zf_left - margin;
	self.titleLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
}

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [UILabel new];
		_titleLabel.textColor = [UIColor whiteColor];
		_titleLabel.font = [UIFont systemFontOfSize:15];
	}
	return _titleLabel;
}

- (UIButton *)likeBtn {
	if (!_likeBtn) {
		_likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(likeAnmination) forControlEvents:UIControlEventTouchUpInside];
	}
	return _likeBtn;
}


- (UIButton *)commentBtn {
	if (!_commentBtn) {
		_commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[_commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(commentList) forControlEvents:UIControlEventTouchUpInside];
	}
	return _commentBtn;
}

- (UIButton *)shareBtn {
	if (!_shareBtn) {
		_shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
	}
	return _shareBtn;
}

- (UIImage *)placeholderImage {
	if (!_placeholderImage) {
		_placeholderImage = [ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)];
	}
	return _placeholderImage;
}

- (void)setData:(ZFTableData *)data {
	_data = data;
	if (data.thumbnail_width >= data.thumbnail_height) {
		self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
		self.coverImageView.clipsToBounds = NO;
	} else {
		self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
		self.coverImageView.clipsToBounds = YES;
	}
	[self.coverImageView setImageWithURLString:data.thumbnail_url placeholder:[UIImage imageNamed:@"loading_bgView"]];
	[self.bgImgView setImageWithURLString:data.thumbnail_url placeholder:[UIImage imageNamed:@"loading_bgView"]];
	self.titleLabel.text = data.title;
}

- (UIImageView *)coverImageView {
	if (!_coverImageView) {
		_coverImageView = [[UIImageView alloc] init];
		_coverImageView.userInteractionEnabled = YES;
		_coverImageView.tag = 10086;
//        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
	}
	return _coverImageView;
}

- (UIImageView *)bgImgView {
	if (!_bgImgView) {
		_bgImgView = [[UIImageView alloc] init];
		_bgImgView.userInteractionEnabled = YES;
	}
	return _bgImgView;
}

- (UIView *)effectView {
	if (!_effectView) {
		if (@available(iOS 8.0, *)) {
			UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
			_effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
		} else {
			UIToolbar *effectView = [[UIToolbar alloc] init];
			effectView.barStyle = UIBarStyleBlackTranslucent;
			_effectView = effectView;
		}
	}
	return _effectView;
}

- (void)commentList {
    //old commentList example
//    [[CommentManager shareManager] showCommentWithSourceId:nil];
}

- (void)likeAnmination {
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"TwitterHeartAnimation"];
    UIImage* image1=[UIImage imageNamed:@"like"];
    animation.frame = CGRectMake(self.zf_width - 100, self.zf_width - 9, image1.size.width, image1.size.width);
    [self.contentView addSubview:animation];
    [animation playWithCompletion:^(BOOL animationFinished) {
      // Do Something when finished
    }];

}
@end
