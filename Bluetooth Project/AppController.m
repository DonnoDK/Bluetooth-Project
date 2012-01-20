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
    [trayStatusItem setTitle:@"BTLock"];
    [trayStatusItem setMenu:trayMenu];
    
    // load preferences
    
    // is this the first time the app is launched?
        // show setup screen and prompt the user to discover/pair a device for use in the app
}
@end
