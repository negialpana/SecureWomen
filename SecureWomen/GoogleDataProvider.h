//
//  GoogleDataProvider.h
//  SecureWomen
//
//  Created by Supritha H N on 07/03/15.
////

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GoogleDataProvider : NSObject

@property (nonatomic, retain) NSString *type;

- (void)fetchNearByPlace:(CLLocationCoordinate2D)coordinate andRadius:(double)radius withCompletionHandler:(void (^)(NSError *error, NSArray *places))completionHandler;



@end
