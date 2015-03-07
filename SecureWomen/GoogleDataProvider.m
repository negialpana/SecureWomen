//
//  GoogleDataProvider.m
//  SecureWomen
//
//  Created by Supritha H N on 07/03/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
//

#import "GoogleDataProvider.h"
#import "AppDelegate.h"
typedef void (^completionblock)(NSError *error, NSArray *array);


@interface GoogleDataProvider ()

@property (nonatomic, retain) NSString *API;

@property (nonatomic, retain)NSURLSessionDataTask *placeTask;
@property (nonatomic, retain)NSURLSession *Urlsession;
@property (nonatomic, retain) completionblock finalCompletionblock;


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

- (void)fetchNearByPlace:(CLLocationCoordinate2D)coordinate andRadius:(double)radius withCompletionHandler:(void (^)(NSError *error, NSArray *places))completionHandler {

    NSString *str = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%f&types=hospital&key=%@",coordinate.latitude,coordinate.longitude,radius,@"AIzaSyBdE1SJEe4JJ_wND0gCkOtNFyblnLZiFG4"];
    
    if (self.placeTask.taskIdentifier>0 && self.placeTask.state == NSURLSessionTaskStateRunning) {
        [self.placeTask cancel];
    }
    
//    self.placeTask = [self.Urlsession dataTaskWithURL:[NSURL URLWithString:str] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//    }];
    
    NSURL *googleRequestURL=[NSURL URLWithString:str];
    _finalCompletionblock = [completionHandler copy];
    
    // Retrieve the results of the URL.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
    
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    NSArray* places = [json objectForKey:@"results"];
    
    //Write out the data to the console.
    NSLog(@"Google Data: %@", places);
    if (!error) {
        _finalCompletionblock(nil,places);
    }else {
        _finalCompletionblock (error, nil);
    }
    //Plot the data in the places array onto the map with the plotPostions method.
  //  [self plotPositions:places];
    
    
}
@end
