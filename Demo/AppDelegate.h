//
//  AppDelegate.h
//  Demo
//
//  Created by 崔婉莹 on 2022/1/15.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;
@property (nonatomic, strong) UIWindow *window;

- (void)saveContext;


@end

