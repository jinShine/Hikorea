//
//  CulturalFacilityModel.m
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "CulturalFacilityModel.h"

@implementation CulturalFacilityModel


-(id)initWithDictionary:(NSDictionary *)jsonDictionary
{
    self = [super init];
    if(self)
    {
        [self setValuesForKeysWithDictionary:jsonDictionary];
    }
    
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"accomcountculture"])
        self.accomcountculture = key;
    else if([key isEqualToString:@"chkcreditcardculture"])
        self.chkcreditcardculture = key;
    else if([key isEqualToString:@"chkpetculture"])
        self.chkpetculture = key;
    else if([key isEqualToString:@"discountinfo"])
        self.discountinfo = key;
    else if([key isEqualToString:@"infocenterculture"])
        self.infocenterculture = key;
    else if([key isEqualToString:@"parkingculture"])
        self.parkingculture = key;
    else if([key isEqualToString:@"parkingfee"])
        self.parkingfee = key;
    else if([key isEqualToString:@"restdateculture"])
        self.restdateculture = key;
    else if([key isEqualToString:@"usefee"])
        self.usefee = key;
    else if([key isEqualToString:@"usetimeculture"])
        self.usetimeculture = key;
    else if([key isEqualToString:@"scale"])
        self.scale = key;
    else if([key isEqualToString:@"spendtime"])
        self.spendtime = key;
    
}
@end
