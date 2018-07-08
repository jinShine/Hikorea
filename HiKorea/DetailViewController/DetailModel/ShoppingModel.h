//
//  ShoppingModel.h
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingModel : NSObject

//쇼핑(38)
@property (nonatomic, strong) NSString *infocentershopping;       // 문의 및 안내
@property (nonatomic, strong) NSString *culturecenter;            // 문화센터 바로가기
@property (nonatomic, strong) NSString *opendateshopping;         // 개장일
@property (nonatomic, strong) NSString *fairday;                  // 장서는날
@property (nonatomic, strong) NSString *opentime;                 // 영업시간
@property (nonatomic, strong) NSString *restdateshopping;         // 쉬는날
@property (nonatomic, strong) NSString *saleitem;                 // 판매 품목
@property (nonatomic, strong) NSString *saleitemcost;             // 판매 품목별 가격
@property (nonatomic, strong) NSString *scaleshopping;            // 규모
@property (nonatomic, strong) NSString *shopguide;                // 매장 안내
@property (nonatomic, strong) NSString *parkingshopping;          // 주차시설
@property (nonatomic, strong) NSString *restroom;                 // 화장실
@property (nonatomic, strong) NSString *chkbabycarriageshopping;  // 유모차 대여 여부
@property (nonatomic, strong) NSString *chkcreditcardshopping;    // 신용카드 가능 여부
@property (nonatomic, strong) NSString *chkpetshopping;           // 애완동물 가능 여부














-(id)initWithDictionary:(NSDictionary *)jsonDictionary;

@end
