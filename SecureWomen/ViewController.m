//
//  ViewController.m
//  SecureWomen
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "PlaceTypeTableViewController.h"
#import "SettingsKeys.h"

@interface ViewController ()<CLLocationManagerDelegate, GMSMapViewDelegate, PlaceTypeTableViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *pinImage;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pinImageVerticalContraint;
@property (nonatomic, retain) CLLocationManager *locatonManager;

@property (nonatomic, assign) NSInteger selectionType;
- (IBAction)segmentTapped:(id)sender;

@property (nonatomic, retain) NSArray *searchTypes;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:DEFAULT_COLOR];
    _searchTypes =  @[@"bakery", @"bar", @"cafe", @"grocery_or_supermarket", @"restaurant"];
    
    _locatonManager = [[CLLocationManager alloc] init];
    _locatonManager.delegate = self;
    _mapView.delegate = self;
    
    if([[[UIDevice currentDevice] systemVersion] integerValue] >= 8.0)
        [_locatonManager requestWhenInUseAuthorization];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture{
}
-(void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    
    [self reverseGeoCode:position.target];
    //update the map view
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [_locatonManager startUpdatingLocation];
        _mapView.myLocationEnabled = YES;
        _mapView.settings.myLocationButton  = YES;
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *currentLocation = [locations firstObject];
    
    if (currentLocation) {
        _mapView.camera = [GMSCameraPosition cameraWithTarget:currentLocation.coordinate zoom:15 bearing:0 viewingAngle:0];
        [_locatonManager stopUpdatingLocation];
    }
    
}

-(void)reverseGeoCode:(CLLocationCoordinate2D)coordinate{
    
    GMSGeocoder *geocode = [[GMSGeocoder alloc] init];
    
    [geocode reverseGeocodeCoordinate:coordinate completionHandler:^(GMSReverseGeocodeResponse * response, NSError * error) {
        
        if (response) {
            GMSAddress *address =    [response firstResult];
            self.addressLabel.text= @"";
            NSArray *addressArray =  [address lines];
            for(id obj  in addressArray){
                self.addressLabel.text = [self.addressLabel.text stringByAppendingString:obj];
                
            }
            [UIView animateWithDuration:.25 animations:^{
                [self.view layoutIfNeeded];
            }];
            
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    PlaceTypeTableViewController *vc =segue.destinationViewController;
    vc.delegate = self;
}


-(void)PlaceTypeTableViewController:(PlaceTypeTableViewController *)self completedWithSelectionType:(NSInteger )type{
    
    _selectionType = type;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentTapped:(id)sender {
    
    UISegmentedControl *segControle = (UISegmentedControl *)sender;
    switch (segControle.selectedSegmentIndex) {
        case 0:
            _mapView.mapType = kGMSTypeNormal;
            break;
        case 1:
            _mapView.mapType = kGMSTypeSatellite;
            
            break;
            
        default:
            break;
    }
}
@end
