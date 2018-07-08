//
//  FestivalModel.m
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "FestivalModel.h"

@implementation FestivalModel

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
    if([key isEqualToString:@"agelimit"])
        self.agelimit = key;
    else if([key isEqualToString:@"bookingplace"])
        self.bookingplace = key;
    else if([key isEqualToString:@"discountinfofestival"])
        self.discountinfofestival = key;
    else if([key isEqualToString:@"eventenddate"])
        self.eventenddate = key;
    else if([key isEqualToString:@"eventhomepage"])
        self.eventhomepage = key;
    else if([key isEqualToString:@"eventplace"])
        self.eventplace = key;
    else if([key isEqualToString:@"eventstartdate"])
        self.eventstartdate = key;
    else if([key isEqualToString:@"festivalgrade"])
        self.festivalgrade = key;
    else if([key isEqualToString:@"placeinfo"])
        self.placeinfo = key;
    else if([key isEqualToString:@"playtime"])
        self.playtime = key;
    else if([key isEqualToString:@"program"])
        self.program = key;
    else if([key isEqualToString:@"spendtimefestival"])
        self.spendtimefestival = key;
    else if([key isEqualToString:@"sponsor1"])
        self.sponsor1 = key;
    else if([key isEqualToString:@"sponsor1tel"])
        self.sponsor1tel = key;
    else if([key isEqualToString:@"sponsor2"])
        self.sponsor2 = key;
    else if([key isEqualToString:@"sponsor2tel"])
        self.sponsor2tel = key;
    else if([key isEqualToString:@"subevent"])
        self.subevent = key;
    
}
@end
