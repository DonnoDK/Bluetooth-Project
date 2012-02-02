//
//  SetupController.h
//  Bluetooth Project
//
//  Created by Brian Pedersen on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*
 SetupController guides the user through setup the first time the app launches
 This ensures that the user connects/pairs his/her desired devices with the mac
 After that, present a button which launches the Security panel in system prefences where
 the user can check the box which prompts for password after screensaver or sleep
 */


#import <Foundation/Foundation.h>

@interface SetupController : NSWindowController <NSWindowDelegate>{
    
}

@end
