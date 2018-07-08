//
//  CulturalFacilityModel.h
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CulturalFacilityModel : NSObject

//문화시설(14)
@property (nonatomic, strong) NSString *accomcountculture;      // 수용인원
@property (nonatomic, strong) NSString *chkcreditcardculture;   // 신용카드 가능 여부
@property (nonatomic, strong) NSString *chkpetculture;          // 애완동물 가능 여부
@property (nonatomic, strong) NSString *chkbabycarriageculture; // 유모차 대여 여부
@property (nonatomic, strong) NSString *discountinfo;           // 할인정보
@property (nonatomic, strong) NSString *infocenterculture;      // 문의 및 안내
@property (nonatomic, strong) NSString *parkingculture;         // 주차 시설
@property (nonatomic, strong) NSString *parkingfee;             // 주차 요금
@property (nonatomic, strong) NSString *restdateculture;        // 쉬는날
@property (nonatomic, strong) NSString *usefee;                 // 이용 요금
@property (nonatomic, strong) NSString *usetimeculture;         // 이용 시간
@property (nonatomic, strong) NSString *scale;                  // 규모
@property (nonatomic, strong) NSString *spendtime;              // 관람 소요시간

-(id)initWithDictionary:(NSDictionary *)jsonDictionary;

@end
