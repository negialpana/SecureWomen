//
//  ViewController.m
//  SecureWomen
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "PlaceTypeTableViewController.h"
#import "SettingsKeys.h"
#import "GoogleDataProvider.h"
#import "PlaceMarker.h"
#import "GooglePlace.h"
#import "MarkerInfoView.h"

@interface ViewController ()<CLLocationManagerDelegate, GMSMapViewDelegate, PlaceTypeTableViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *pinImage;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pinImageVerticalContraint;
@property (nonatomic, retain) CLLocationManager *locatonManager;
@property (nonatomic, retain) CLLocation *cernterLocation;

@property (nonatomic, assign) NSInteger selectionType;
- (IBAction)segmentTapped:(id)sender;

@property (nonatomic, retain) NSArray *searchTypes;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:DEFAULT_COLOR];
    _searchTypes =  @[@"Hospital",@"bakery", @"bar", @"cafe", @"grocery_or_supermarket", @"restaurant"];
    
    _locatonManager = [[CLLocationManager alloc] init];
    _locatonManager.delegate = self;
    self.mapView.delegate = self;
    
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
        _cernterLocation = currentLocation;
        
        GoogleDataProvider *dataProvder = [[GoogleDataProvider alloc] init];
        if (_selectionType == 0) {
            dataProvder.type = @"police";
        }else{
            dataProvder.type = @"hospital";
        }
        [dataProvder fetchNearByPlace:_cernterLocation.coordinate andRadius:[self mapRadius] withCompletionHandler:^(NSError *error, NSArray *places) {
            [self.mapView clear];
            if (!error) {
                for(GooglePlace *obj in places){
                 
                    PlaceMarker *maker = [[PlaceMarker alloc] initWithPlace:obj];
                   // maker.place = obj;
                    maker.map = self.mapView;
                }
            }
            
        }];

    }
    
}

-(UIView *)mapView:(GMSMapView *)mapView markerInfoContents:(GMSMarker *)marker{
    
    NSArray *arr =[[NSBundle mainBundle] loadNibNamed:@"MarkerInfoView" owner:self options:nil];
    MarkerInfoView *markerInfoView = [arr objectAtIndex:0];
    PlaceMarker *placemaker = (PlaceMarker *)marker;
    
    markerInfoView.namelabel.text = placemaker.place.name;
    
    return markerInfoView;
    
}

-(double)mapRadius{
    GMSVisibleRegion region = [self.mapView.projection visibleRegion];
    float verticalDis = GMSGeometryDistance(region.farLeft, region.nearLeft);
    float horizontalDis = GMSGeometryDistance(region.farLeft, region.farRight);
    
    return MAX(horizontalDis, verticalDis);
    
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
