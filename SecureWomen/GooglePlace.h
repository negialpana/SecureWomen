//
//  GooglePlace.h
//  SecureWomen
//
//  Created by Supritha H N on 07/03/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
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
