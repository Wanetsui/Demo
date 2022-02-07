//
//  WaterFallLayoutViewController.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/24.
//

#import "WaterFallLayoutViewController.h"
#import "WaterFallCollectionViewCell.h"
#import "WaterFallLayout.h"
#import "ZFUtilities.h"
#import "ZFTableData.h"
#import "DetailViewController.h"

@interface WaterFallLayoutViewController ()<WaterFallLayoutDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) WaterFallLayout *layout;

@property (strong, nonatomic) UIView *bottomView;

@end

@implementation WaterFallLayoutViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupUI];
}

- (void)setupUI
{
	self.view.backgroundColor = [UIColor whiteColor];

	WaterFallLayout *layout = [WaterFallLayout waterFallLayoutWithColumn:2];
	layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 0);
	layout.columnSpacing = 2;
	layout.rowSpacing = 2;
	layout.dataSource = self;
	self.layout = layout;

	CGFloat y = iPhoneX ? 88 : 64;
	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, y, ZFPlayer_ScreenWidth, ZFPlayer_ScreenHeight - y) collectionViewLayout:layout];
	self.collectionView.backgroundColor = [UIColor whiteColor];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
	if (@available(iOS 11.0, *)) {
		self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
	} else {
		self.automaticallyAdjustsScrollViewInsets = NO;
	}

	[self.view addSubview:self.collectionView];
	[self requestData];
	[self.collectionView reloadData];
}

- (void)requestData {
	NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
	NSData *data = [NSData dataWithContentsOfFile:path];
	NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

	self.dataSource = @[].mutableCopy;
	NSArray *videoList = [rootDict objectForKey:@"list"];
	for (NSDictionary *dataDic in videoList) {
		ZFTableData *data = [[ZFTableData alloc] init];
		[data setValuesForKeysWithDictionary:dataDic];
		data.thumbnail_height = (self.layout.itemWidth / data.thumbnail_width) * data.thumbnail_height;
		[self.dataSource addObject:data];
	}
}


// MARK: - MPWaterFallLayoutDataSource
- (CGFloat)waterFallLayout:(WaterFallLayout *)layout itemHeightForItemWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath
{
	ZFTableData *data = self.dataSource[indexPath.row];
	return data.thumbnail_height;
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	WaterFallCollectionViewCell *cell = (WaterFallCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
	ZFTableData *data = self.dataSource[indexPath.row];
	cell.data = data;
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	WaterFallCollectionViewCell *cell = (WaterFallCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
	DetailViewController *vc = [[DetailViewController alloc] init];
	vc.index = indexPath.row;
	vc.startImage = cell.imageView.image;
	vc.startView = cell.imageView;
	vc.dataSource = [self.dataSource mutableCopy];
	self.navigationController.delegate = vc;
	[self.navigationController pushViewController:vc animated:YES];
}

@end
