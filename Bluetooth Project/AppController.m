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
    if (self) {
        preferenceController = [[PreferenceController alloc] init];
        [preferenceController showWindow:self];
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
#endif
    // enter loop polling signal strength
    // is the setupscreen and prefwindow NOT visible?
    // what is the signal strength?
    // is it below the threshold?
    // alert the user and lock if timer runs out
    
}
@end
