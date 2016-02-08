//
//  ViewController.m
//  VK API Test
//
//  Created by Nikolay on 18.01.16.
//  Copyright © 2016 Nikolay. All rights reserved.
//

#import "ViewController.h"
#import <VKSdk.h>
#import <VKApiFriends.h>

@interface ViewController ()

@end

@implementation ViewController

static NSArray  * SCOPE = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    VKSdk *sdkInstance = [VKSdk initializeWithAppId:@"5225917"];
    
//    [VKSdk initializeWithDelegate:delegate andAppId:YOUR_APP_ID];
//    if ([VKSdk wakeUpSession])
//    {
//        //Start working
//    }
 
    SCOPE = @[VK_PER_FRIENDS, VK_PER_WALL, VK_PER_AUDIO, VK_PER_PHOTOS, VK_PER_NOHTTPS, VK_PER_EMAIL, VK_PER_MESSAGES];
    
    NSLog(@"SKD = %@", sdkInstance);
    NSLog(@"api = %@", sdkInstance.apiVersion);
    
//    [VKSdk wakeUpSessio mpleteBlock:^(VKAuthorizationState state, NSError *error) {
//        if (state == VKAuthorizationAuthorized) {
//            // Authorized and ready to go
//        } else if (error) {
//            // Some error happend, but you may try later
//        }
//    }];
    
    [VKSdk authorize:SCOPE];
    NSLog(@"api = %@", sdkInstance.apiVersion);
    
    VKRequest * getWall = [VKRequest requestWithMethod:@"wall.get" andParameters:@{VK_API_OWNER_ID : @"170968205", @"count": @1}];
    NSLog(@"getWall = %@", getWall);
    
    
    VKRequest *request = [[VKApi users] get:@{ VK_API_FIELDS : @"uid,first_name,last_name,sex,bdate,city,country,photo_50,photo_100,photo_200_orig,photo_200, photo_400_orig,photo_max,photo_max_orig,online,online_mobile,lists,domain,has_mobile,contacts, connections,site,education,universities,schools,can_post,can_see_all_posts,can_see_audio, can_write_private_message,status,last_seen,common_count,relation,relatives,counters" }];
    NSLog(@"request = %@", request);
    
    VKRequest * request1 = [[VKApi users] get];
    VKBatchRequest *batch = [[VKBatchRequest alloc]initWithRequests:getWall, nil];
    [batch executeWithResultBlock:^(NSArray *responses) {
        VKResponse* rs = responses[0];
        NSLog(@"Responses: %@", rs);
        NSLog(@"json: %@", rs.json[@"count"]);
        
    } errorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
