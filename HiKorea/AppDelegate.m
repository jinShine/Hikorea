//
//  AppDelegate.m
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 28..
//  Copyright © 2017년 김승진. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "SupportingFile.h"

//전역 변수
NSString *mContentType;
NSString *mDistance;
NSString *mArrange;
float mLongtitude;
float mLatitude;

@interface AppDelegate ()

@property (strong, nonatomic) MainViewController *mainVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [GMSServices provideAPIKey:@"AIzaSyAPI33CBs0uQKCKTijRF0X9AyBvJMWAwrM"];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTranslucent:YES];
    [UINavigationBar appearance].barStyle = UIStatusBarStyleLightContent;

    //[NSThread sleepForTimeInterval:2.0];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)initLocationSetting
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //사용중에만 위치 정보 요청
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusDenied)
    {
        NSLog(@"%s : ","kCLAuthorizationStatusDenied");
        
        SCLAlertView *alertView = [[SCLAlertView alloc] init];
        
        [alertView addButton:@"확인" actionBlock:^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                if(success)
                    NSLog(@"openURL Success");
            }];
        }];
        
        [alertView showNotice:_mainVC title:@"현재 위치" subTitle:@"현재 위치를 불러 올 수 없습니다.\n 보다 편리한 검색을 위해 위치서비스를 사용해 보세요.\n iOS 기기의 [설정] > [HiKorea] > [위치]를 ON으로 설정해주세요."
             closeButtonTitle:@"close" duration:0.0f];
    }
    else if(status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        NSLog(@"%s : ","kCLAuthorizationStatusAuthorizedWhenInUse");
        
        
        
        [_mainVC parsingDataWithContentType:mContentType withArrange:mArrange withLongtitude:mLongtitude withLatitude:mLatitude withDistance:mDistance];
    }
}
@end
