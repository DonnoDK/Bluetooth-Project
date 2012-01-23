//
//  AppController.h
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/20/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IOBluetooth/IOBluetooth.h>
#import <IOBluetoothUI/IOBluetoothUI.h>
@class PreferenceController;
@class SetupController;
@interface AppController : NSObject{
    NSStatusItem *trayStatusItem;
    NSMenuItem *pref;
    IBOutlet NSMenu *trayMenu;
    PreferenceController *preferenceController; // for the preference window controller
    SetupController *setupController; // for the setup window controller
    BOOL firstTimeLaunched; //This is purely for testing
    NSArray *pairedDevices;
}
-(IBAction)showPref:(id)sender;
@end
