//
//  PlayerController.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import "PlayerController.h"
#import "LayerAttributeManager.h"
#import <KTVHTTPCache.h>
#import <ZFUtilities.h>

@interface PlayerController ()<KTVHCDataLoaderDelegate>

@property (nonatomic, strong) ZFPlayerController *player;

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) UIInterfaceOrientation orientation;

@end

@implementation PlayerController

// MARK: - Init
+ (instancetype)playrWithContainerView:(UIView *)containerView
{
	return [[self alloc] initWithContainerView: containerView];
}

- (instancetype)initWithContainerView:(UIView *)containerView
{
	if (self = [super init])
	{
		LayerAttributeManager *mgr = [[LayerAttributeManager alloc] init];
		_player = [[ZFPlayerController alloc] initWithPlayerManager:mgr containerView:containerView];
		[_player setCustomAudioSession:YES];
		[self setup];
	}
	return self;
}

+ (instancetype)playerWithScrollView:(UIScrollView *)scrollView containerViewTag:(NSInteger)containerViewTag
{
	return [[self alloc] initWithScrollView:scrollView containerViewTag:containerViewTag];
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView containerViewTag:(NSInteger)containerViewTag
{
	if (self = [super init])
	{
		LayerAttributeManager *mgr = [[LayerAttributeManager alloc] init];
		_player = [[ZFPlayerController alloc] initWithScrollView:scrollView playerManager:mgr containerViewTag:containerViewTag];
		_player.disableGestureTypes = ZFPlayerDisableGestureTypesPan;
		[_player setCustomAudioSession:YES];
		[self setup];
	}
	return self;
}

- (instancetype)init
{
	if (self = [super init])
	{
		[self setup];
	}
	return self;
}

/// 初始化
- (void)setup
{
	_preLoadNum = 2;
	_nextLoadNum = 2;
	_preloadPrecent = 0.1;
	_initPreloadNum = 3;
	_player.allowOrentitaionRotation = NO;
	_player.playerDisapperaPercent = 0.5;
	_player.playerApperaPercent = 0.5;
	@weakify(self)
	_player.playerDidToEnd = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
		@strongify(self)
		[self.player.currentPlayerManager replay];
	};
}

// MARK: - Method
- (void)stop
{
	self.player.scrollView.zf_playingIndexPath = nil;
	[self.player stop];
}

- (void)stopCurrentPlayingCell
{
	[self.player stopCurrentPlayingCell];
}

- (void)playWithPlayable: (id<XSTPlayable>)playable
{
	_currentPlayable = playable;
	self.player.assetURL = [NSURL URLWithString:playable.video_url];
}

- (void)setDisapperaPercent: (CGFloat)disappearPercent appearPercent: (CGFloat)appearPercent
{
	self.player.playerDisapperaPercent = disappearPercent;
	self.player.playerApperaPercent = appearPercent;
}

- (void)enterLandscapeFullScreen:(UIInterfaceOrientation)orientation animated:(BOOL)animated
{
	CGFloat cellHeight = iPhoneX ? ZFPlayer_ScreenHeight - 83 : ZFPlayer_ScreenHeight;
	if (self.isAnimating) {
		return;
	}
	if (self.orientation == orientation) {
		return;
	}
	if (self.player.currentPlayerManager.playState == ZFPlayerPlayStatePlaying ||self.player.currentPlayerManager.playState == ZFPlayerPlayStatePaused
	    ) {
		self.isAnimating = YES;
	}
	self.orientation = orientation;
	CGFloat rotation = 0;
	if (orientation == UIInterfaceOrientationLandscapeLeft) {
		rotation = M_PI_2;
	}else if (orientation == UIInterfaceOrientationLandscapeRight) {
		rotation = M_PI_2 * 3;
	}
	UIView *presentView = self.player.currentPlayerManager.view;
	CGRect landRect = CGRectMake(0, 0, cellHeight, ZFPlayer_ScreenWidth);
	[UIView animateWithDuration:0.35 animations:^{
	         presentView.layer.affineTransform = CGAffineTransformMakeRotation(rotation);
	 } completion:^(BOOL finished) {
	         self.isAnimating = NO;
	 }];
	presentView.layer.bounds = landRect;
}

- (void)exitFullScreen: (BOOL)isAnimated
{
	CGFloat cellHeight = iPhoneX ? ZFPlayer_ScreenHeight - 49 : ZFPlayer_ScreenHeight;
	if (self.isAnimating) {
		return;
	}
	if (self.orientation == UIInterfaceOrientationPortrait) {
		return;
	}
	CGRect frame = CGRectMake(0, 0, ZFPlayer_ScreenWidth, cellHeight);
	UIView *presentView = self.player.currentPlayerManager.view;
	if (!isAnimated) {
		presentView.layer.affineTransform = CGAffineTransformIdentity;
		self.orientation = UIInterfaceOrientationPortrait;
	}else {
		self.isAnimating = YES;
		self.orientation = UIInterfaceOrientationPortrait;
		[UIView animateWithDuration:0.35 animations:^{
		         presentView.layer.affineTransform = CGAffineTransformIdentity;
		 } completion:^(BOOL finish){
		         self.isAnimating = NO;
		 }];
	}
	self.player.currentPlayerManager.view.layer.bounds = frame;
}

/// Add Player到Cell上
- (void)updateScrollViewPlayerToCell
{
	if (self.player.currentPlayerManager.view &&
	    self.player.scrollView.zf_playingIndexPath &&
	    self.player.containerViewTag) {
		UIView *cell = [self.player.scrollView zf_getCellForIndexPath:self.player.scrollView.zf_playingIndexPath];
		UIView *containerView = [cell viewWithTag:self.player.containerViewTag];
		[self updateNoramlPlayerWithContainerView:containerView];
	}
}

/// 更新Playerc的容器
- (void)updateNoramlPlayerWithContainerView:(UIView *)containerView
{
	[self.player addPlayerViewToContainerView:containerView];
}

// MARK: - KTVHCDataLoaderDelegate
- (void)ktv_loaderDidFinish:(KTVHCDataLoader *)loader
{
}

// MARK: - Getter
- (BOOL)isViewControllerDisappear
{
	return self.player.isViewControllerDisappear;
}

- (NSIndexPath *)playingIndexPath
{
	return self.player.playingIndexPath;
}



- (id<ZFPlayerMediaPlayback>)currentPlayerManager
{
	return self.player.currentPlayerManager;
}

- (BOOL)isPlaying
{
	return self.player.currentPlayerManager.isPlaying;
}

- (UIView *)containerView
{
	return self.player.containerView;
}

- (BOOL)isWWANAutoPlay
{
	return self.player.isWWANAutoPlay;
}

- (void (^)(id<ZFPlayerMediaPlayback> _Nonnull, NSTimeInterval, NSTimeInterval))playerPlayTimeChanged
{
	return _player.playerPlayTimeChanged;
}

- (CGFloat)playerApperaPercent
{
	return _player.playerApperaPercent;
}

- (CGFloat)playerDisapperaPercent
{
	return _player.playerDisapperaPercent;
}


- (void)setWWANAutoPlay:(BOOL)WWANAutoPlay
{
	self.player.WWANAutoPlay = WWANAutoPlay;
}

- (void)setControlView:(UIView<ZFPlayerMediaControl> *)controlView
{
	_controlView = controlView;
	self.player.controlView = controlView;
}

- (void)setViewControllerDisappear:(BOOL)viewControllerDisappear
{
	self.player.viewControllerDisappear = viewControllerDisappear;
}

- (void)setPlayingIndexPath:(NSIndexPath * _Nullable)playingIndexPath
{
	self.playingIndexPath = playingIndexPath;
}

- (void)setPlayerDidToEnd:(void (^)(id<ZFPlayerMediaPlayback> _Nonnull))playerDidToEnd {
	_player.playerDidToEnd = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
		playerDidToEnd(asset);
	};
}

- (void)setPlayerPlayFailed:(void (^)(id<ZFPlayerMediaPlayback> _Nonnull, id _Nonnull))playerPlayFailed {
	_player.playerPlayFailed = playerPlayFailed;
}

- (void)setPlayerReadyToPlay:(void (^)(id<ZFPlayerMediaPlayback> _Nonnull, NSURL * _Nonnull))playerReadyToPlay {
	_player.playerReadyToPlay = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSURL * _Nonnull assetURL) {
		playerReadyToPlay(asset, assetURL);
	};
}

- (void)setPlayerPlayTimeChanged:(void (^)(id<ZFPlayerMediaPlayback> _Nonnull, NSTimeInterval, NSTimeInterval))playerPlayTimeChanged {
	_player.playerPlayTimeChanged = playerPlayTimeChanged;
}

- (void)setPlayerBufferTimeChanged:(void (^)(id<ZFPlayerMediaPlayback> _Nonnull, NSTimeInterval))playerBufferTimeChanged {
	_player.playerBufferTimeChanged = playerBufferTimeChanged;
}

- (void)setPresentationSizeChanged:(void (^)(id<ZFPlayerMediaPlayback> _Nonnull, CGSize))presentationSizeChanged {
	_player.presentationSizeChanged = presentationSizeChanged;
}

- (void)setPlayerPlayStateChanged:(void (^)(id<ZFPlayerMediaPlayback> _Nonnull, ZFPlayerPlaybackState))playerPlayStateChanged
{
	_player.playerPlayStateChanged = playerPlayStateChanged;
}

- (void)setPlayerLoadStateChanged:(void (^)(id<ZFPlayerMediaPlayback> _Nonnull, ZFPlayerLoadState))playerLoadStateChanged
{
	_player.playerLoadStateChanged = playerLoadStateChanged;
}

- (void)setZf_playerDisappearingInScrollView:(void (^)(NSIndexPath * _Nonnull, CGFloat))zf_playerDisappearingInScrollView
{
	_player.zf_playerDisappearingInScrollView = zf_playerDisappearingInScrollView;
}

- (void)setZf_playerDidDisappearInScrollView:(void (^)(NSIndexPath * _Nonnull))zf_playerDidDisappearInScrollView
{
	_player.zf_playerDidDisappearInScrollView = zf_playerDidDisappearInScrollView;
}

- (void)setPlayerApperaPercent:(CGFloat)playerApperaPercent
{
	_player.playerApperaPercent = playerApperaPercent;
}

- (void)setPlayerDisapperaPercent:(CGFloat)playerDisapperaPercent
{
	_player.playerDisapperaPercent = playerDisapperaPercent;
}

@end
