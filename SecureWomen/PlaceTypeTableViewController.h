//
//  PlaceTypeTableViewController.h
//  SecureWomen
//
//  Created by Supritha H N on 07/03/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlaceTypeTableViewController;

@protocol PlaceTypeTableViewControllerDelegate <NSObject>

-(void)PlaceTypeTableViewController :(PlaceTypeTableViewController*)self completedWithSelectionType:(NSInteger)type;

@end

@interface PlaceTypeTableViewController : UITableViewController

@property (nonatomic, assign) id <PlaceTypeTableViewControllerDelegate> delegate;

@end
