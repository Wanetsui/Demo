//
//  Location.m
//  Demo
//
//  Created by 崔婉莹 on 2022/2/9.
//

#import "Location.h"
#import <CoreLocation/CoreLocation.h>

@interface Location()<CLLocationManagerDelegate>

@property(nonatomic, strong, readwrite) CLLocationManager *manager;

@end

@implementation Location

+ (Location *)locationManager{
    static Location *location;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[Location alloc] init];
    });
    return location;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [[CLLocationManager alloc] init];
//        self.manager.delegate = self;
    }
    return self;
}

- (void)checkLocationAuthorization{
    
    //判断系统是否开启
    if(![CLLocationManager locationServicesEnabled]){
        //引导弹窗
        //
    }
    
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        [self.manager requestWhenInUseAuthorization];
    }
}

#pragma mark - delegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //
        [self.manager startUpdatingLocation];

    }else if (status == kCLAuthorizationStatusDenied){
        //
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {

    //地理信息
    CLLocation *location = [locations firstObject];

    CLGeocoder *coder = [[CLGeocoder alloc] init];

    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //地标信息
    }];

     [self.manager stopUpdatingLocation];
}

@end
