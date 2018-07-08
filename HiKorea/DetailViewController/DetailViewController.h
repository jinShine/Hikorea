//
//  DetailViewController.h
//  HiKorea
//
//  Created by 김승진 on 2018. 1. 28..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <GoogleMaps/GoogleMaps.h>

#import "AppDelegate.h"
#import "SupportingFile.h"
#import "DetailMainImageCell.h"
#import "TitleCell.h"
#import "OverViewCell.h"
#import "MapInfoViewCell.h"
#import "MapViewController.h"
#import "DefaultViewCell.h"

#import "InfoModel.h"

/////////////////////////////////////////////
//Model
#import "TouristSpotModel.h"
#import "CulturalFacilityModel.h"
#import "FestivalModel.h"
#import "TravelingCourseModel.h"
#import "LeportsModel.h"
#import "AccommodationModel.h"
#import "ShoppingModel.h"
#import "RestaurantModel.h"


typedef NS_ENUM(NSUInteger, DetailViewSection){
    MainImageSetion = 0,
    MapInfoViewSection,
    DefaultInfoSection,
    
    DetailSectionTotal
};

typedef NS_ENUM(NSUInteger, MainImageRow){
    ImageRow = 0,
    TitleRow,
    OverViewRow,
    
    MainImageRowTotal
};

typedef NS_ENUM(NSUInteger, MapViewRow){
    MapInfoRow = 0,
    
    MapInfoRowTotal
};

typedef NS_ENUM(NSUInteger, TouristSpotRow){
    infocenterRow = 0,
    touristSpotHomepageRow,
    opendateRow,
    restdateRow,
    usetimeRow,
    parkingRow,
    accomcountRow,
    expguideRow,
    expagerangeRow,
    chkpetRow,
    
    TouristSpotRowTotal
};

typedef NS_ENUM(NSUInteger, CulturalFacilityRow){
    infocentercultureRow = 0,
    culturalFacilityHomepageRow,
    restdatecultureRow,
    usetimecultureRow,
    usefeeRow,
    discountinfoRow,
    scaleRow,
    spendtimeRow,
    parkingcultureRow,
    parkingfeeRow,
    accomcountcultureRow,
    chkpetcultureRow,

    CulturalFacilityRowTotal
};

typedef NS_ENUM(NSUInteger, FestivalRow){
    bookingplaceRow = 0,
    festivalHomepageRow,
    eventstartdateRow,
    eventenddateRow,
    discountinfofestivalRow,
    agelimitRow,
    eventplaceRow,
    placeinfoRow,
    playtimeRow,
    programRow,
    spendtimefestivalRow,
    sponsor1Row,
    sponsor1telRow,
    sponsor2Row,
    sponsor2telRow,
    subeventRow,
    
    FestivalRowTotal
};

typedef NS_ENUM(NSUInteger, TravelingCourseRow){
    infocentertourcourseRow = 0,
    travelingCourseHomepageRow,
    themeRow,
    scheduleRow,
    distanceRow,
    taketimeRow,
    
    TravelingCourseRowTotal
};

typedef NS_ENUM(NSUInteger, LeportsRow){
    infocenterleportsRow = 0,
    leportsHomepageRow,
    openperiodRow,
    restdateleportsRow,
    accomcountleportsRow,
    scaleleportsRow,
    usefeeleportsRow,
    usetimeleportsRow,
    reservationRow,
    expagerangeleportsRow,
    parkingleportsRow,
    parkingfeeleportsRow,
    chkbabycarriageleportsRow,
    chkcreditcardleportsRow,
    chkpetleportsRow,
    
    LeportsRowTotal
};

typedef NS_ENUM(NSUInteger, AccommodationRow){
    infocenterlodgingRow = 0,
    accommodationHomepageRow,
    checkintimeRow,
    checkouttimeRow,
    scalelodgingRow,
    roomcountRow,
    roomtypeRow,
    accomcountlodgingRow,
    parkinglodgingRow,
    chkcookingRow,
    pickupRow,
    foodplaceRow,
    barbecueRow,
    campfireRow,
    fitnessRow,
    karaokeRow,
    publicpcRow,
    saunaRow,
    seminarRow,
    beautyRow,
    sportsRow,
    subfacilityRow,
    
    AccommodationRowTotal
};

typedef NS_ENUM(NSUInteger, ShoppingRow){
    infocentershoppingRow = 0,
    shoppingHomepageRow,
    culturecenterRow,
    opendateshoppingRow,
    fairdayRow,
    opentimeRow,
    restdateshoppingRow,
    saleitemRow,
    saleitemcostRow,
    scaleshoppingRow,
    shopguideRow,
    parkingshoppingRow,
    restroomRow,
    chkbabycarriageshoppingRow,
    chkcreditcardshoppingRow,
    chkpetshoppingRow,
    
    
    ShoppingRowTotal
};

typedef NS_ENUM(NSUInteger, RestaurantRow){
    infocenterfoodRow = 0,
    restaurantHomepageRow,
    opentimefoodRow,
    opendatefoodRow,
    restdatefoodRow,
    firstmenuRow,
    treatmenuRow,
    discountinfofoodRow,
    packingRow,
    scalefoodRow,
    seatRow,
    parkingfoodRow,
    reservationfoodRow,
    chkcreditcardfoodRow,
    kidsfacilityRow,
    smokingRow,
    
    RestaurantRowTotal
};




@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate, GMSMapViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) NSMutableArray *selectedArrData;

@property (strong, nonatomic) NSMutableArray *parserDataArr;
@property (strong, nonatomic) NSMutableArray *imageDataArr;
@property (strong, nonatomic) NSMutableDictionary *introduceDataArr;

@property (nonatomic) BOOL isOverViewHeight;



@end
