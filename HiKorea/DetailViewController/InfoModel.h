//
//  InfoModel.h
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 6..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject

-(id)initWithDictionary:(NSDictionary *)jsonDictionary;
/*
 소개정보
 */

//관광지(12)
@property (nonatomic, strong) NSString *accomcount;       // 수용인원
@property (nonatomic, strong) NSString *chkbabycarriage;  // 유모차 대여 여부
@property (nonatomic, strong) NSString *chkcreditcard;    // 신용카드 가능 여부
@property (nonatomic, strong) NSString *chkpet;           // 애완동물 가능 여부
@property (nonatomic, strong) NSString *expagerange;      // 체험가능 연령
@property (nonatomic, strong) NSString *expguide;         // 체험안내
@property (nonatomic, strong) NSString *infocenter;       // 문의 및 안내
@property (nonatomic, strong) NSString *opendate;         // 개장일
@property (nonatomic, strong) NSString *parking;          // 주차시설
@property (nonatomic, strong) NSString *restdate;         // 쉬는날
@property (nonatomic, strong) NSString *useseason;        // 이용시기
@property (nonatomic, strong) NSString *usetime;          // 이용시간
@property (nonatomic) NSInteger heritage1;               // 세계 문화유산 유무
@property (nonatomic) NSInteger heritage2;               // 세계 자연유산 유무
@property (nonatomic) NSInteger heritage3;               // 세계 기록유산 유무

@end


