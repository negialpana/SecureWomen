//
//  PlaceTypeTableViewController.h
//  SecureWomen
//
//
//

#import <UIKit/UIKit.h>

@class PlaceTypeTableViewController;

@protocol PlaceTypeTableViewControllerDelegate <NSObject>

-(void)PlaceTypeTableViewController :(PlaceTypeTableViewController*)self completedWithSelectionType:(NSInteger)type;

@end

@interface PlaceTypeTableViewController : UITableViewController

@property (nonatomic, assign) id <PlaceTypeTableViewControllerDelegate> delegate;

@end
