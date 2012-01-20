//
//  AppController.h
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/20/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PreferenceController;
@interface AppController : NSObject{
    NSStatusItem *trayStatusItem;
    NSMenuItem *pref;
    IBOutlet NSMenu *trayMenu;
    PreferenceController *preferenceController;
}
-(IBAction)showPref:(id)sender;
@end
