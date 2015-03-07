//
//  PlaceMarker.h
//  SecureWomen
//
//
//

#import <GoogleMaps/GoogleMaps.h>
#import "GooglePlace.h"

@interface PlaceMarker : GMSMarker
@property (nonatomic, retain) GooglePlace *place;
- (instancetype)initWithPlace : (GooglePlace *)place;


@end
