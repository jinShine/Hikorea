//
//  AccommodationModel.m
//  HiKorea
//
//  Created by 김승진 on 2018. 3. 10..
//  Copyright © 2018년 김승진. All rights reserved.
//

#import "AccommodationModel.h"

@implementation AccommodationModel

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
    
    if([key isEqualToString:@"accomcountlodging"])
        self.accomcountlodging = key;
//    else if([key isEqualToString:@"benikia"])
//        self.benikia = key;
    else if([key isEqualToString:@"checkintime"])
        self.checkintime = key;
    else if([key isEqualToString:@"checkouttime"])
        self.checkouttime = key;
    else if([key isEqualToString:@"chkcooking"])
        self.chkcooking = key;
    else if([key isEqualToString:@"foodplace"])
        self.foodplace = key;
//    else if([key isEqualToString:@"goodstay"])
//        self.goodstay = key;
//    else if([key isEqualToString:@"hanok"])
//        self.hanok = key;
    else if([key isEqualToString:@"infocenterlodging"])
        self.infocenterlodging = key;
    else if([key isEqualToString:@"parkinglodging"])
        self.parkinglodging = key;
    else if([key isEqualToString:@"pickup"])
        self.pickup = key;
    else if([key isEqualToString:@"roomcount"])
        self.roomcount = key;
//    else if([key isEqualToString:@"reservationlodging"])
//        self.reservationlodging = key;
    else if([key isEqualToString:@"reservationurl"])
        self.reservationurl = key;
    else if([key isEqualToString:@"roomtype"])
        self.roomtype = key;
    else if([key isEqualToString:@"scalelodging"])
        self.scalelodging = key;
    else if([key isEqualToString:@"subfacility"])
        self.subfacility = key;
    else if([key isEqualToString:@"barbecue"])
        self.barbecue = key;
    else if([key isEqualToString:@"beauty"])
        self.beauty = key;
    else if([key isEqualToString:@"campfire"])
        self.campfire = key;
    else if([key isEqualToString:@"fitness"])
        self.fitness = key;
    else if([key isEqualToString:@"karaoke"])
        self.karaoke = key;
    else if([key isEqualToString:@"publicpc"])
        self.publicpc = key;
    else if([key isEqualToString:@"sauna"])
        self.sauna = key;
    else if([key isEqualToString:@"seminar"])
        self.seminar = key;
    else if([key isEqualToString:@"sports"])
        self.sports = key;
    
}
@end
