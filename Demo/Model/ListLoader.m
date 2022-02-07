//
//  ListLoader.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/20.
//

#import "ListLoader.h"
#import "ListItem.h"
#import <AFNetworking.h>

@implementation ListLoader

-(void)loadListDataWithFinishBlock:(ListLoaderFinishBlock)finishBlock{
    
//    NSArray<ListItem *> *listdata = [self _readDataFromLocal];
//    if (listdata) {
//        finishBlock(YES, listdata);
//    }
    
    NSString *urlString = @"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e";
    NSURL *listURL = [NSURL URLWithString:urlString];

    NSURLSession *session = [NSURLSession sharedSession];
    
    __weak typeof(self) weakSelf = self;

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        //url失效了先做视频吧
#warning 类型的检查
        NSArray *dataArray = [((NSDictionary *)[((NSDictionary *)jsonObj) objectForKey:@"result"]) objectForKey:@"data"];
        NSMutableArray *listItemArray = @[].mutableCopy;
        for(NSDictionary *info in dataArray){
            ListItem *listItem = [[ListItem alloc] init];
            [listItem configWithDictionary:info];
            [listItemArray addObject:listItem];
        }
        NSLog(@"");
        
//        [weakSelf _archiveListDataWithArray:listItemArray.copy];
//
        dispatch_async(dispatch_get_main_queue(), ^{
            if(finishBlock) {
                finishBlock(error == nil, listItemArray.copy);
            }
        });
    }];

    [dataTask resume];
}


//- (NSArray<ListItem *> *)_readDataFromLocal{
//    
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *cachePath = [pathArray firstObject];
//    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"GTData/list"];
//
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    NSData *readListData = [fileManager contentsAtPath:listDataPath];
//
//    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[ListItem class], nil]  fromData:readListData error:nil];
//    
//    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
//        return (NSArray<ListItem *> *)unarchiveObj;
//    }
//    return nil;;
//}
//
//- (void)_archiveListDataWithArray:(NSArray<ListItem *> *)array{
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *cachePath = [pathArray firstObject];
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    //创建文件夹
//    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"GTData"];
//    NSError *creatError;
//    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&creatError];
//    //创建文件
//    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
//    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
//    
//    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
//}

@end
