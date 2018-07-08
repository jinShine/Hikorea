//
//  MapViewController.m
//  HiKorea
//
//  Created by 김승진 on 2018. 2. 16..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initGoogleMap:_selectedArrData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initGoogleMap:(NSMutableArray *)responseData
{
    
    double longtitude = [[[responseData objectAtIndex:0] valueForKey:@"mapx"] doubleValue];
    double latitude = [[[responseData objectAtIndex:0] valueForKey:@"mapy"] doubleValue];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longtitude zoom:16];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    mapView.settings.compassButton = YES;
    mapView.camera = camera;
    [mapView setPadding:UIEdgeInsetsMake((IS_iPhoneX? 24.0f : 20.0f), 0, (IS_iPhoneX? 21.0f: 10.0f), 0)];
    
    //backButton 커스텀
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(8, (IS_iPhoneX? 50.0f: 26.0f), 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [backBtn setTintColor:[UIColor colorWithRed:43.0/255.0 green:64.0/255.0 blue:107.0/255.0 alpha:1.0 ]];
    [mapView addSubview:backBtn];

    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.view = mapView;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude, longtitude);
    
    if([[[responseData objectAtIndex:0] valueForKey:@"title"] isEqualToString:@""] == NO)
        marker.title = [[responseData objectAtIndex:0] valueForKey:@"title"];
    else if([[[responseData objectAtIndex:0] valueForKey:@"addr2"] isEqualToString:@""] == NO)
        marker.snippet = [[responseData objectAtIndex:0] valueForKey:@"addr2"];
    
    marker.map = mapView;

}

-(void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
