//
//  AppController.m
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/20/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"
@implementation AppController
-(id)init{
    self = [super init];
    return self;
}


-(IBAction)showPref:(id)sender{
    if (!preferenceController) {
        preferenceController = [[PreferenceController alloc] init];
    }
    [preferenceController showWindow:self];
}

-(void)awakeFromNib{
    trayStatusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [trayStatusItem setTitle:@"BTLock"]; //set icon instead at later stage
    [trayStatusItem setMenu:trayMenu];
    
    
    // load preferences
    
    // is this the first time the app is launched?
        // show setup screen and prompt the user to discover/pair a device for use in the app
    
    // enter loop polling signal strength
        // is the setupscreen and prefwindow NOT visible?
        // what is the signal strength?
        // is it below the threshold?
            // alert the user and lock if timer runs out
}
@end
