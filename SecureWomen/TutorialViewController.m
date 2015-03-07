//
//  TutorialViewController.m
//  SecureWomen
//
//  Created by Alpana Negi on 07/03/15.
////

#import "TutorialViewController.h"
#import "SettingsKeys.h"

#define TUTORIAL_TEXT @"This app is build to provide secuity to women using two features.\n\n\n - First one is posting help message along with her current location and date-time values to her social media account on Twitter and facebook just by clicking one button. \n\n - Other one is listing out nearby police stations to find help and reach in case of emergency."

@interface TutorialViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tutorialTextView;

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:DEFAULT_COLOR];
    self.tutorialTextView.textColor = [UIColor yellowColor];
    self.tutorialTextView.text = TUTORIAL_TEXT;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
