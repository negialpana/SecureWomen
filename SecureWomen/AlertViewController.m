//
//  AlertViewController.m
//  SecureWomen
//
//  Created by Alpana Negi on 07/03/15.
//  Copyright (c) 2015 Airwatch. All rights reserved.
//

#import "AlertViewController.h"
#import "SettingsKeys.h"
#import <Social/Social.h>

#define TWEET_TEXT               @"Test Tweet"        //@"Please Help"
#define POST_TEXT_TO_FB          @"Test Post"

@interface AlertViewController ()

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor : DEFAULT_COLOR];
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

- (IBAction)cautionButtonPressed:(id)sender
{
    NSLog(@"cautionButtonPressed");
}

- (IBAction)alertButtonPressed:(id)sender
{
    NSLog(@"alertButtonPressed");
    [self postToTwitter];
    [self postToFB];
}

- (void)postToTwitter
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:TWEET_TEXT];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)postToFB
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSheet setInitialText:POST_TEXT_TO_FB];
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a post to fb right now, make sure your device has an internet connection and you have at least one fb account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)sendMessageForHelp
{
    
}


@end
