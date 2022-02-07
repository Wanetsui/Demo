//
//  AppDelegate.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/15.
//

#import "AppDelegate.h"
#import "WaterFallLayoutViewController.h"
#import "FlowLayoutViewController.h"
//#import "FlowLayoutViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	WaterFallLayoutViewController *flowLayoutController =[[WaterFallLayoutViewController alloc] init];
//    FlowLayoutViewController *flowLayoutController =[[FlowLayoutViewController alloc] init];

	UITabBarController *tabbarController= [[UITabBarController alloc] init];

	flowLayoutController.tabBarItem.title = @"视频";
	flowLayoutController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/video@2x.png"];
	flowLayoutController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/video_selected@2x.png"];

	UIViewController *mineViewController = [[UIViewController alloc] init];
	mineViewController.view.backgroundColor = [UIColor blueColor];
	mineViewController.tabBarItem.title = @"朋友圈";
	mineViewController.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/page@2x.png"];
	mineViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/page_selected@2x.png"];

	[tabbarController setViewControllers:@[flowLayoutController,mineViewController]];

	tabbarController.delegate = self;

	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabbarController];
	self.window.rootViewController = navigationController;
	[self.window makeKeyAndVisible];

	return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    NSLog(@"did select");
}
//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentCloudKitContainer *)persistentContainer {
	// The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
	@synchronized (self) {
		if (_persistentContainer == nil) {
			_persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:@"Demo"];
			[_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
			         if (error != nil) {
					 // Replace this implementation with code to handle the error appropriately.
					 // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

					 /*
					    Typical reasons for an error here include:
					  * The parent directory does not exist, cannot be created, or disallows writing.
					  * The persistent store is not accessible, due to permissions or data protection when the device is locked.
					  * The device is out of space.
					  * The store could not be migrated to the current model version.
					    Check the error message to determine what the actual problem was.
					  */
					 NSLog(@"Unresolved error %@, %@", error, error.userInfo);
					 abort();
				 }
			 }];
		}
	}

	return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
	NSManagedObjectContext *context = self.persistentContainer.viewContext;
	NSError *error = nil;
	if ([context hasChanges] && ![context save:&error]) {
		// Replace this implementation with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, error.userInfo);
		abort();
	}
}

@end
