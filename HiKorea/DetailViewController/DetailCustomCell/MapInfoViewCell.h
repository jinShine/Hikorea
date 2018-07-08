//
//  MapInfoViewCell.h
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 30..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

#import "DetailViewController.h"
#import "MapViewController.h"

@class DetailViewController;

@interface MapInfoViewCell : UITableViewCell

@property (strong, nonatomic) DetailViewController *detailVC;

//구글 맵
@property (strong, nonatomic) GMSCameraPosition *camera;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

//response Data
@property (weak, nonatomic) NSMutableArray *selectedArrData;

- (IBAction)pushMapVC:(id)sender;

@end
