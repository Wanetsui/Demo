//
//  FlowLayoutViewController.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/20.
//

#import "FlowLayoutViewController.h"
#import "WaterfallLayout.h"
#import "CoverView.h"
#import "ListLoader.h"
#import "ListItem.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface FlowLayoutViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong, readwrite) UICollectionView *collectionView;

@property(nonatomic, strong, readwrite) NSArray *dataArray;
@property(nonatomic, strong, readwrite) ListLoader *listLoader;

@end

@implementation FlowLayoutViewController

- (instancetype)init {
	self = [super init];
	if (self) {

	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];

	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	flowLayout.minimumLineSpacing = 10;
	flowLayout.minimumInteritemSpacing = 10;
	flowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 10)/2, (self.view.frame.size.width - 10) / 8 * 4 + 20);

	UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
	collection.delegate = self;
	collection.dataSource = self;
	[collection registerClass:[CoverView class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
	[self.view addSubview:collection];

	self.listLoader = [[ListLoader alloc] init];
	__weak typeof(self) wself = self;
	[self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<ListItem *> * _Nonnull dataArray) {
	         __strong typeof(wself) strongSelf = wself;
	         strongSelf.dataArray = dataArray;
	         [strongSelf.collectionView reloadData];
	 }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

	ListItem *item = [self.dataArray objectAtIndex:indexPath.item];

	// url can be remote or local
	NSURL *url = [[NSURL alloc] initWithString:@"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"];
	AVPlayer *player = [AVPlayer playerWithURL:url];
	// create a player view controller
	AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
	[self presentViewController:controller animated:YES completion:nil];
	controller.player = player;
	[player play];
	controller.title = [NSString stringWithFormat:@"%@", @(indexPath.item)];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSLog(@"_dataArray.count - %@", _dataArray.count);
//    return MAX(self.dataArray.count, 0);
	return 30;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	CoverView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
	[cell layoutWithCoverUrl:[self.dataArray objectAtIndex:indexPath.item]];
	cell.backgroundColor = [UIColor whiteColor];
	return cell;
}

@end
