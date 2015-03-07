//
//  PlaceMarker.m
//  SecureWomen
//
//  Created by Supritha H N on 07/03/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
//

#import "PlaceMarker.h"
#import "GooglePlace.h"

@interface PlaceMarker ()

@property (nonatomic, retain) GooglePlace *place;

@end

@implementation PlaceMarker

- (instancetype)initWithPlace : (GooglePlace *)place
{
    self = [super init];
    if (self) {
        self.place = place;
        self.position = place.cordi;
        self.icon = [UIImage imageNamed:@"TODO"];
        self.groundAnchor = CGPointMake(0.5, 1);
        self.appearAnimation = kGMSMarkerAnimationPop;
    }
    return self;
}
@end