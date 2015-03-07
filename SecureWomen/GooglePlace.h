//
//  GooglePlace.h
//  SecureWomen
//
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@interface GooglePlace : NSObject

@property(nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *addr;
@property (nonatomic, assign) CLLocationCoordinate2D cordi;
@property (nonatomic, retain) NSString *placeType;
@property (nonatomic, retain) NSString *photoref;
@property (nonatomic, retain) UIImage *photo;


@end
