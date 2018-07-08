//
//  AccommodationModel.h
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccommodationModel : NSObject

//숙박(32)

@property (nonatomic, strong) NSString *infocenterlodging;    // 문의 및 안내
@property (nonatomic, strong) NSString *reservationurl;       // 예약안내 홈페이지
@property (nonatomic, strong) NSString *checkintime;          // 입실 시간
@property (nonatomic, strong) NSString *checkouttime;           // 퇴실 시간
@property (nonatomic, strong) NSString *scalelodging;              // 규모
@property (nonatomic, strong) NSString *roomcount;              // 객실수
@property (nonatomic, strong) NSString *roomtype;              // 객실 유형
@property (nonatomic, strong) NSString *accomcountlodging;      // 수용인원
@property (nonatomic, strong) NSString *parkinglodging;              // 주차시설


//기타
@property (nonatomic, strong) NSString *chkcooking;      // 객실내 취사 여부
@property (nonatomic, strong) NSString *pickup;              // 픽업 서비스
@property (nonatomic, strong) NSString *foodplace;         // 식음료장
@property (nonatomic, strong) NSString *barbecue;              // 바비큐장 여부
@property (nonatomic, strong) NSString *campfire;              // 캠프파이어 여부
@property (nonatomic, strong) NSString *fitness;              // 휘트니스 센터 여부
@property (nonatomic, strong) NSString *karaoke;              // 노래방 여부
@property (nonatomic, strong) NSString *publicpc;              // 공용 PC실 여부
@property (nonatomic, strong) NSString *sauna;              // 사우나실 여부
@property (nonatomic, strong) NSString *seminar;              // 세미나실 여부
@property (nonatomic, strong) NSString *beauty;              // 뷰티시설 정보
@property (nonatomic, strong) NSString *sports;              // 스포츠 시설 여부
@property (nonatomic, strong) NSString *subfacility;              // 부대시설(기타)

//일단 안씀
@property (nonatomic, strong) NSString *benikia;   // 베니키아 여부
@property (nonatomic, strong) NSString *goodstay;             // 굿스테이 여부
@property (nonatomic, strong) NSString *hanok;                  // 한옥 여부
@property (nonatomic, strong) NSString *reservationlodging;              // 예약안내






-(id)initWithDictionary:(NSDictionary *)jsonDictionary;

@end
