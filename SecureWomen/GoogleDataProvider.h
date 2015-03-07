//
//  GoogleDataProvider.h
//  SecureWomen
//
//  Created by Supritha H N on 07/03/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GoogleDataProvider : NSObject

- (void)fetchNearByPlace:(CLLocationCoordinate2D)coordinate andRadius:(double)radius withCompletionHandler:(void (^)(NSError *error, NSArray *places))completionHandler;

@end
