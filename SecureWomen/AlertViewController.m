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

@import Accounts;

#define TWEET_TEXT               @"Test Tweet 4"        //@"Please Help"
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
}

- (void)postToTwitter
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:TWEET_TEXT];
        [tweetSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            [self postToFB];
        }];
        
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

- (void)postToTwitterWithoutUsingTweetSheet
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    //before posting u can allow user to select the account
    NSArray *arrayOfAccons = [account accountsWithAccountType:accountType];
    for(ACAccount *acc in arrayOfAccons)
    {
        NSLog(@"%@",acc.username);
    }
    
    // Request access from the user to access their Twitter account
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (granted == YES)
        {
            NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
            if ([arrayOfAccounts count] > 0)
            {
                ACAccount *acct = [arrayOfAccounts objectAtIndex:0];
                
                SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"]  parameters:[NSDictionary dictionaryWithObject:TWEET_TEXT forKey:@"status"]];
                
                [postRequest setAccount:acct];
                [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                 {
                     if(error)
                     {
                         //error while posting the tweet
                         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter" message:@"Error in posting" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [alert show];
                     }
                     else
                     {
                         // successful posting
                         NSLog(@"Twitter response, HTTP response: %i", [urlResponse statusCode]);
                         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter" message:@"Successfully posted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [alert show];
                         
                     }
                 }];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter" message:@"You have no twitter account" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
        else
        {
            //user not set any of the accounts
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter" message:@"Permission not granted" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

@end
