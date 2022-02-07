//
//  PlayerToolbar.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/25.
//

#import "PlayerToolbar.h"

@interface PlayerToolbar ()

@property (nonatomic, strong, readwrite) UIImageView *avatorImageView;
@property (nonatomic, strong, readwrite) UILabel *nickLabel;

@property (nonatomic, strong, readwrite) UIImageView *commentImageView;
@property (nonatomic, strong, readwrite) UILabel *commentLabel;

@property (nonatomic, strong, readwrite) UIImageView *likeImageView;
@property (nonatomic, strong, readwrite) UILabel *likeLabel;

@property (nonatomic, strong, readwrite) UIImageView *shareImageView;
@property (nonatomic, strong, readwrite) UILabel *shareLabel;

@end

@implementation PlayerToolbar

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {

		self.backgroundColor = [UIColor whiteColor];

		[self addSubview:({
			_avatorImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
			_avatorImageView.layer.masksToBounds = YES;
			_avatorImageView.layer.cornerRadius = 15;
			_avatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
			_avatorImageView;
		})];
		[self addSubview:({
			_nickLabel = [[UILabel alloc] init];
			_nickLabel.font = [UIFont systemFontOfSize:10];
			_nickLabel.textColor = [UIColor blackColor];
			_nickLabel.translatesAutoresizingMaskIntoConstraints = NO;
			_nickLabel;
		})];

		[self addSubview:({
			_commentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
			_commentImageView.layer.masksToBounds = YES;
			_commentImageView.layer.cornerRadius = 15;
			_commentImageView.translatesAutoresizingMaskIntoConstraints = NO;

			_commentImageView;
		})];
		[self addSubview:({
			_commentLabel = [[UILabel alloc] init];
			_commentLabel.font = [UIFont systemFontOfSize:10];
			_commentLabel.textColor = [UIColor blackColor];
			_commentLabel.translatesAutoresizingMaskIntoConstraints = NO;

			_commentLabel;
		})];

//        [self addSubview:({
//            _likeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//            _likeImageView.layer.masksToBounds = YES;
//            _likeImageView.layer.cornerRadius = 15;
//            _likeImageView.translatesAutoresizingMaskIntoConstraints = NO;
//
//            _likeImageView;
//        })];
//        [self addSubview:({
//            _likeLabel = [[UILabel alloc] init];
//            _likeLabel.font = [UIFont systemFontOfSize:15];
//            _likeLabel.textColor = [UIColor blackColor];
//            _likeLabel.translatesAutoresizingMaskIntoConstraints = NO;
//
//            _likeLabel;
//        })];
//
//        [self addSubview:({
//            _shareImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//            _shareImageView.layer.masksToBounds = YES;
//            _shareImageView.layer.cornerRadius = 15;
//            _shareImageView.translatesAutoresizingMaskIntoConstraints = NO;
//            _shareImageView.contentMode = UIViewContentModeScaleToFill;
//            _shareImageView;
//        })];
//
//        [self addSubview:({
//            _shareLabel = [[UILabel alloc] init];
//            _shareLabel.font = [UIFont systemFontOfSize:15];
//            _shareLabel.textColor = [UIColor blackColor];
//            _shareLabel.translatesAutoresizingMaskIntoConstraints = NO;
//            _shareLabel;
//        })];


		[self.layer addSublayer:({
			CALayer *bottomLine = [[CALayer alloc] init];
//            bottomLine.frame = CGRectMake(0, frame.size.height - 0.5, [[UIScreen mainScreen ] bounds].size.width / 2, 0.5);
//            bottomLine.backgroundColor = [UIColor blackColor].CGColor;
			bottomLine;
		})];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	//观察下View的frame
}

- (void)layoutWithModel:(id)model {

	_avatorImageView.image = [UIImage imageNamed:@"icon.bundle/icon.png"];
	_nickLabel.text = @"极客时间";

	_commentImageView.image = [UIImage imageNamed:@"comment"];
	_commentLabel.text = @"100";

	_likeImageView.image = [UIImage imageNamed:@"praise"];
	_likeLabel.text = @"25";

	_shareImageView.image = [UIImage imageNamed:@"share"];
	_shareLabel.text = @"分享";

	[NSLayoutConstraint activateConstraints:@[

		 [NSLayoutConstraint constraintWithItem:_avatorImageView
		  attribute:NSLayoutAttributeCenterY
		  relatedBy:NSLayoutRelationEqual
		  toItem:self
		  attribute:NSLayoutAttributeCenterY
		  multiplier:1
		  constant:0],

		 [NSLayoutConstraint constraintWithItem:_avatorImageView
		  attribute:NSLayoutAttributeLeft
		  relatedBy:NSLayoutRelationEqual
		  toItem:self
		  attribute:NSLayoutAttributeLeft
		  multiplier:1
		  constant:2],

		 [NSLayoutConstraint constraintWithItem:_avatorImageView
		  attribute:NSLayoutAttributeWidth
		  relatedBy:NSLayoutRelationEqual
		  toItem:nil
		  attribute:NSLayoutAttributeNotAnAttribute
		  multiplier:1
		  constant:4],

		 [NSLayoutConstraint constraintWithItem:_avatorImageView
		  attribute:NSLayoutAttributeHeight
		  relatedBy:NSLayoutRelationEqual
		  toItem:nil
		  attribute:NSLayoutAttributeNotAnAttribute
		  multiplier:1
		  constant:4],

		 [NSLayoutConstraint constraintWithItem:_nickLabel
		  attribute:NSLayoutAttributeCenterY
		  relatedBy:NSLayoutRelationEqual
		  toItem:_avatorImageView
		  attribute:NSLayoutAttributeCenterY
		  multiplier:1
		  constant:0],

		 [NSLayoutConstraint constraintWithItem:_nickLabel
		  attribute:NSLayoutAttributeLeft
		  relatedBy:NSLayoutRelationEqual
		  toItem:_avatorImageView
		  attribute:NSLayoutAttributeRight
		  multiplier:1
		  constant:0],

	]];

//    NSString *vflString = @"H:|-5-[_avatorImageView]-0-[_nickLabel]-(>=0)-[_commentImageView(==_avatorImageView)]-0-[_commentLabel]-5-[_likeImageView(==_avatorImageView)]-0-[_likeLabel]-5-[_shareImageView(==_avatorImageView)]-0-[_shareLabel]-5-|";
	NSString *vflString = @"H:|-2-[_avatorImageView]-0-[_nickLabel]-(>=0)-[_commentImageView(==_avatorImageView)]-0-[_commentLabel]-2-|";

//    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflString options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_avatorImageView, _nickLabel, _commentImageView, _commentLabel, _likeImageView, _likeLabel, _shareImageView, _shareLabel)]];
	[NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vflString options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_avatorImageView, _nickLabel, _commentImageView, _commentLabel)]];

}

@end
