//
//  WaterFallCollectionViewCell.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import "WaterFallCollectionViewCell.h"
#import <ZFPlayer/UIImageView+ZFCache.h>

#import <ZFPlayer/UIView+ZFFrame.h>

@implementation WaterFallCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	[self setup];
    if(self){
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.likeBtn];
    }
	return self;
}

- (void)setup
{
	self.imageView = [[UIImageView alloc] init];
	[self.contentView addSubview:self.imageView];
    
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.imageView.frame = self.contentView.bounds;
    
    self.imageView.layer.cornerRadius = 15;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 2;
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.zf_width;
    CGFloat min_view_h = self.zf_height;
    CGFloat margin = 10;
    
    min_w = 40;
    min_h = min_w;
    min_x = min_view_w - min_w;
    min_y = min_view_h - min_h;
    self.likeBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);

    min_x = 10;
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
        [_likeBtn setImage:[UIImage imageNamed:@"praise"] forState:UIControlStateNormal];
    }
    return _likeBtn;
}


- (void)setData:(ZFTableData *)data
{
	_data = data;
	[self.imageView setImageWithURLString:data.thumbnail_url placeholder:nil];
    self.titleLabel.text = data.title;
}

@end
