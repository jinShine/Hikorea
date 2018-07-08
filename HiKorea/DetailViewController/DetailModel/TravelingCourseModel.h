//
//  TravelingCourseModel.h
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelingCourseModel : NSObject

//여행코스(25)
@property (nonatomic, strong) NSString *infocentertourcourse;    // 문의 및 안내
@property (nonatomic, strong) NSString *theme;                   // 코스 테마
@property (nonatomic, strong) NSString *schedule;                // 코스 일정
@property (nonatomic, strong) NSString *distance;                // 코스 총 거리
@property (nonatomic, strong) NSString *taketime;                // 코스 총 소요시간



-(id)initWithDictionary:(NSDictionary *)jsonDictionary;

@end
