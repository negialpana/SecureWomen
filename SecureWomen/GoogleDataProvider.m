//
//  GoogleDataProvider.m
//  SecureWomen
//
//  Created by Supritha H N on 07/03/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
//

#import "GoogleDataProvider.h"
#import "AppDelegate.h"


@interface GoogleDataProvider ()

@property (nonatomic, retain) NSString *API;

@property (nonatomic, retain)NSURLSessionDataTask *placeTask;
@property (nonatomic, retain)NSURLSession *Urlsession;


@end

@implementation GoogleDataProvider

-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.Urlsession = [NSURLSession sharedSession];
        self.placeTask = [[NSURLSessionDataTask alloc] init];
    }
    return self;
}

-(void)fetchNearByPlace:(CLLocationCoordinate2D)coordinate andRadius:(double) radius andTypes:(NSArray *)types {
    
    //https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=500&types=food&name=cruise&key=AddYourOwnKeyHere

//    NSString *str = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=%@&location=%l,%l&radius=%l&rankby=prominence&sensor=true",GOOGLE_MAPS_APIKEY,coordinate.latitude,coordinate.longitude,radius];
    
}
@end
