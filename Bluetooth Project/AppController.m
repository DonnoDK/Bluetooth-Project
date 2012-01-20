//
//  AppController.m
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/20/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"
#import "SetupController.h"
@implementation AppController
-(id)init{
    self = [super init];
    if (self) {
        btInquiry = [[IOBluetoothDeviceInquiry alloc] init];
        preferenceController = [[PreferenceController alloc] init];
    }
    return self;
}


-(IBAction)showPref:(id)sender{
    
    [preferenceController showWindow:self];
}

-(void)awakeFromNib{
    trayStatusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [trayStatusItem setTitle:@"BTLock"]; //set icon instead at later stage
    [trayStatusItem setMenu:trayMenu];
    
    
    // load preferences
    #ifdef DEBUG
    NSLog(@"Loading preferences");
    NSLog(@"Starting device discovery");
    #endif
    [btInquiry start];
    [btInquiry setDelegate:self];
    
    firstTimeLaunched = YES; // Change this to not display the setup screen at startup
    // is this the first time the app is launched?
    if (firstTimeLaunched) {
        // show setup screen and prompt the user to discover/pair a device for use in the app
        if (!setupController) {
            setupController = [[SetupController alloc] init];
        }
        [setupController showWindow:self];
    }
        
    
    // enter loop polling signal strength
        // is the setupscreen and prefwindow NOT visible?
        // what is the signal strength?
        // is it below the threshold?
            // alert the user and lock if timer runs out
}
@end
