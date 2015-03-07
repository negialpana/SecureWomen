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

@property (nonatomic, unsafe_unretained) id<PlaceTypeTableViewControllerDelegate> delegate;

@end
