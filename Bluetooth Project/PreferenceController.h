//
//  PreferenceController.h
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/20/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <IOBluetoothUI/IOBluetoothUI.h>
#import <IOBluetooth/IOBluetooth.h>

extern NSString * const BBACountDownValueKey;
extern NSString * const BBALockScreenKey;
extern NSString * const BBADimDisplayKey;
extern NSString * const BBADimKeyboardKey;
extern NSString * const BBAThresholdValueKey;

@interface PreferenceController : NSWindowController <NSWindowDelegate> {
    IOBluetoothDeviceSelectorController *bluetoothSelectorController;
    void * contextInfo;
    BOOL shouldLock;
    //__weak NSPopUpButton *deviceSelector;
    NSTask *task;
    BOOL tryingToConnect;
    NSThread *conThread;
    int counter;
}

- (IBAction)refreshDeviceList:(id)sender;
- (void)lockdown;

@property (nonatomic) BOOL screenIsLocked;
@property (nonatomic) BOOL screenIsUnlocked;
@property (nonatomic, strong) NSArray * pairedDevices;
@property (nonatomic) BOOL isRunning;
@property (nonatomic, assign) NSString *selectedDeviceName;
@property (nonatomic, assign) IOBluetoothDevice *selectedDevice;
@property (nonatomic) NSUInteger countdownValue;
@property (nonatomic) BOOL lockScreen;
@property (nonatomic) BOOL dimDisplay;
@property (nonatomic) BOOL dimKeyboard;
@property (nonatomic) NSInteger thresholdValue;
@property (nonatomic) NSInteger signalStrength; // Not stored as a default
@property (nonatomic) BOOL firstTimeLaunch;
-(IBAction)selectDevice:(id)sender;
-(IBAction)addNewDevice:(id)sender;


- (IBAction)help:(id)sender;
- (void)helpEnded:(NSAlert *)alert
             code:(NSInteger)choise
          context:(void *)v;

+ (NSInteger)preferenceCountDownValue;
+ (void)setPreferenceCountDownValue:(NSUInteger)value;

+ (BOOL)preferenceLockScreen;
+ (void)setPreferenceLockScreen:(BOOL)value;

+ (BOOL)preferenceDimDisplay;
+ (void)setPreferenceDimDisplay:(BOOL)value;

+ (BOOL)preferenceDimKeyboard;
+ (void)setPreferenceDimKeyboard:(BOOL)value;

+ (NSUInteger)preferenceThresholdValue;
+ (void)setPreferenceThresholdValue:(NSInteger)value;

- (IBAction)resetToDefaults:(id)sender;

- (void)alertEnded:(NSAlert *)alert
              code:(NSInteger)choise
           context:(void *)v;
-(void)changeSelectedDevice;
-(void)updateIndicator;
@property (strong) IBOutlet NSPopUpButton *deviceSelector;
@end
