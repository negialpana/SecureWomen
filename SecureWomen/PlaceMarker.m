//
//  PlaceMarker.m
//  SecureWomen
//
//
//

#import "PlaceMarker.h"

@interface PlaceMarker ()


@end

@implementation PlaceMarker

- (instancetype)initWithPlace : (GooglePlace *)place
{
    self = [super init];
    if (self) {
        self.place = place;
        self.position = place.cordi;
        self.icon = [UIImage imageNamed:@"MapIcon.png"];
        self.groundAnchor = CGPointMake(0.5, 1);
        self.appearAnimation = kGMSMarkerAnimationPop;
    }
    return self;
}
@end
