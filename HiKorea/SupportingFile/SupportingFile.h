//
//  SupportingFile.h
//  HiKorea
//
//  Created by 김승진 on 2017. 12. 30..
//  Copyright © 2017년 김승진. All rights reserved.
//

#ifndef SupportingFile_h

//공공API KEY
#define SERVICEKEY          @"kFubPeqU340%2FSiZ8ZIEH7fUoO0P2Gdi2NKbZWS1CGF9Zn9wzxdLGjDWutpP1DfN45cwKu%2FAhVuFH6TtEN5QI2A%3D%3D"

//Device Check
#define IS_iPhoneSE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] nativeBounds].size.height == 1136)
#define IS_iPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] nativeBounds].size.height == 1334)
#define IS_iPhonePlus ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] nativeBounds].size.height == 2208)
#define IS_iPhoneX ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] nativeBounds].size.height == 2436)
#define IS_iPad [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

typedef NS_ENUM(NSInteger, ContentTypeID)
{
    TouristSpot         = 12, //관광지
    CulturalFacility    = 14, //문화시설
    Festival            = 15, //행사,공연,축제
    TravelingCourse     = 25, //여행코스
    Leports             = 28, //레포츠
    Accommodation       = 32, //숙박시설
    Shopping            = 38, //쇼핑
    Restaurant          = 39  //음식점
};

typedef NS_ENUM(NSInteger, areaCode)
{
    Seoul               = 1,
    Incheon             = 2,
    Daejeon             = 3,
    Daegu               = 4,
    Gwangju             = 5,
    Busan               = 6,
    Ulsan               = 7,
    Gyeonggido          = 31,
    Gangwondo           = 32,
    Chungcheongbukdo    = 33,
    Chungcheongnamdo    = 34,
    Gyeongsangbukdo     = 35,
    Gyeongsangnamdo     = 36,
    Jeollabukdo         = 37,
    Jeollanamdo         = 38,
    Jeju                = 39
};





#define SupportingFile_h


#endif /* SupportingFile_h */
