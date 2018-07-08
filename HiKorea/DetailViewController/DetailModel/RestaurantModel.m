//
//  RestaurantModel.m
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "RestaurantModel.h"

@implementation RestaurantModel

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
    
    if([key isEqualToString:@"chkcreditcardfood"])
        self.chkcreditcardfood = key;
    else if([key isEqualToString:@"discountinfofood"])
        self.discountinfofood = key;
    else if([key isEqualToString:@"firstmenu"])
        self.firstmenu = key;
    else if([key isEqualToString:@"infocenterfood"])
        self.infocenterfood = key;
    else if([key isEqualToString:@"kidsfacility"])
        self.kidsfacility = key;
    else if([key isEqualToString:@"opendatefood"])
        self.opendatefood = key;
    else if([key isEqualToString:@"opentimefood"])
        self.opentimefood = key;
    else if([key isEqualToString:@"packing"])
        self.packing = key;
    else if([key isEqualToString:@"parkingfood"])
        self.parkingfood = key;
    else if([key isEqualToString:@"reservationfood"])
        self.reservationfood = key;
    else if([key isEqualToString:@"restdatefood"])
        self.restdatefood = key;
    else if([key isEqualToString:@"scalefood"])
        self.scalefood = key;
    else if([key isEqualToString:@"seat"])
        self.seat = key;
    else if([key isEqualToString:@"smoking"])
        self.smoking = key;
    else if([key isEqualToString:@"treatmenu"])
        self.treatmenu = key;
    
}

@end
