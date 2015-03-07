//
//  GooglePlace.m
//  SecureWomen
//
//  Created by Supritha H N on 07/03/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
//

#import "GooglePlace.h"

@implementation GooglePlace

- (instancetype)initWithDictionary : (NSDictionary *)dictionary andAcceptedTypes : (NSArray *) acceptedTypes
{
    self = [super init];
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        self.addr = [dictionary objectForKey:@"vicinity"];
        
//        NSDictionary *location = [[NSDictionary alloc]init];
//        [location setValue:@"location" forKey:@"geometry"];
//        CLLocationDegrees lat = [location objectForKey:@"lat"];
//        CLLocationDegrees lng = [location objectForKey:@"lng"];
//        
//        self.cordi = CLLocationCoordinate2DMake(lat, lng);
//        
//        
//        NSString *foundType = @"restaurant";
//        
//        NSArray *possibleTypes = ([acceptedTypes count] > 0) ? acceptedTypes : @[@"bakery", @"bar", @"cafe", @"grocery_or_supermarket", @"restaurant"];
//        
//        for (NSString *type in dictionary) {
//            if([possibleTypes containsObject:type])
//            {
//                foundType = type;
//                break;
//            }
//        }
//        self.palceType = foundType;
    }
    return self;
}

@end