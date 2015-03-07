//
//  GooglePlace.m
//  SecureWomen
//
//
//

#import "GooglePlace.h"

@implementation GooglePlace

- (instancetype)initWithDictionary : (NSDictionary *)dictionary andAcceptedTypes : (NSArray *) acceptedTypes
{
    self = [super init];
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        self.addr = [dictionary objectForKey:@"vicinity"];
        
        
        
        NSDictionary *location = [[dictionary objectForKey:@"geometry"] objectForKey:@"location"];
        CLLocationDegrees lat = [[location objectForKey:@"lat"] doubleValue];
        CLLocationDegrees lng = [[location objectForKey:@"lng"] doubleValue];
        
        self.cordi = CLLocationCoordinate2DMake(lat, lng);
        
        NSDictionary *photos = [[dictionary objectForKey:@"photos"] firstObject];
        
        self.photoref = [photos objectForKey:@"photo_reference"];
        
        NSString *foundType = @"restaurant";
        
        NSArray *possibleTypes = ([acceptedTypes count] > 0) ? acceptedTypes : @[@"bakery", @"bar", @"cafe", @"grocery_or_supermarket", @"restaurant"];
        
        for (NSString *type in dictionary) {
            if([possibleTypes containsObject:type])
            {
                foundType = type;
                break;
            }
        }
        self.placeType = foundType;
    }
    return self;
}

@end