//
//  AppController.m
//  Bluetooth Project
//
//  Created by Brian Pedersen on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

@implementation AppController
-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib{
    // launch trayIcon
    trayIcon = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [trayIcon setTitle:@"BTLock"];
    [trayIcon setMenu:trayIconMenu];
    // is this the first time the app has been launched?
        NSLog(@"Showing discover/pair devices screen");
    
}
@end
