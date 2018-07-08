//
//  LeportsModel.h
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeportsModel : NSObject

//레포츠(28)
@property (nonatomic, strong) NSString *infocenterleports;         // 문의 및 안내
@property (nonatomic, strong) NSString *openperiod;             // 개장기간
@property (nonatomic, strong) NSString *restdateleports;              // 쉬는날
@property (nonatomic, strong) NSString *accomcountleports;      // 수용인원
@property (nonatomic, strong) NSString *scaleleports;              // 규모
@property (nonatomic, strong) NSString *usefeeleports;              // 입장료
@property (nonatomic, strong) NSString *usetimeleports;              // 이용시간
@property (nonatomic, strong) NSString *reservation;              // 예약안내
@property (nonatomic, strong) NSString *expagerangeleports;      // 체험 가능연령
@property (nonatomic, strong) NSString *parkingleports;            // 주차시설
@property (nonatomic, strong) NSString *parkingfeeleports;         // 주차요금
@property (nonatomic, strong) NSString *chkbabycarriageleports;   // 유모차 대여 여부
@property (nonatomic, strong) NSString *chkcreditcardleports;    // 신용카드 가능 여부
@property (nonatomic, strong) NSString *chkpetleports;            // 애완동물 가능 여부











-(id)initWithDictionary:(NSDictionary *)jsonDictionary;

@end
