//
//  FestivalModel.h
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FestivalModel : NSObject

//행사/공연/축제(15)
@property (nonatomic, strong) NSString *eventhomepage;          // 행사 홈페이지
@property (nonatomic, strong) NSString *eventstartdate;         // 행사 시작일
@property (nonatomic, strong) NSString *eventenddate;           // 행사 종료일
@property (nonatomic, strong) NSString *bookingplace;           // 예매처
@property (nonatomic, strong) NSString *discountinfofestival;   // 할인정보
@property (nonatomic, strong) NSString *agelimit;               // 관람 가능 연령
@property (nonatomic, strong) NSString *festivalgrade;          // 축제 등급
@property (nonatomic, strong) NSString *eventplace;             // 행사 장소
@property (nonatomic, strong) NSString *placeinfo;              // 행사장 위치안내
@property (nonatomic, strong) NSString *playtime;               // 공연시간
@property (nonatomic, strong) NSString *program;                // 행사 프로그램
@property (nonatomic, strong) NSString *spendtimefestival;      // 관람 소요시간
@property (nonatomic, strong) NSString *sponsor1;               // 주최자 정보
@property (nonatomic, strong) NSString *sponsor1tel;            // 주최자 연락처
@property (nonatomic, strong) NSString *sponsor2;               // 주관사 정보
@property (nonatomic, strong) NSString *sponsor2tel;            // 주관사 연락처
@property (nonatomic, strong) NSString *subevent;               // 부대행사


-(id)initWithDictionary:(NSDictionary *)jsonDictionary;

@end
