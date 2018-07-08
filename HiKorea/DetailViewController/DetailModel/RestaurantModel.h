//
//  RestaurantModel.h
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantModel : NSObject

//음식점(39)
@property (nonatomic, strong) NSString *infocenterfood;         // 문의 및 안내
@property (nonatomic, strong) NSString *opentimefood;           // 영업시간
@property (nonatomic, strong) NSString *opendatefood;           // 개업일
@property (nonatomic, strong) NSString *restdatefood;           // 쉬는날
@property (nonatomic, strong) NSString *firstmenu;              // 대표 메뉴
@property (nonatomic, strong) NSString *treatmenu;              // 취급 메뉴
@property (nonatomic, strong) NSString *discountinfofood;       // 할인 정보
@property (nonatomic, strong) NSString *packing;                // 포장 가능
@property (nonatomic, strong) NSString *scalefood;              // 규모
@property (nonatomic, strong) NSString *seat;                   // 좌석수
@property (nonatomic, strong) NSString *parkingfood;            // 주차 시설
@property (nonatomic, strong) NSString *reservationfood;        // 예약안내
@property (nonatomic, strong) NSString *chkcreditcardfood;      // 신용카드 가능 여부
@property (nonatomic, strong) NSString *kidsfacility;           // 어린이 놀이방 여부
@property (nonatomic, strong) NSString *smoking;                // 금연/흡연 여부


-(id)initWithDictionary:(NSDictionary *)jsonDictionary;

@end
