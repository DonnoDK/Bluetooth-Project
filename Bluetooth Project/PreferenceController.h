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
    IOBluetoothDevice *selectedDevice;
    void * contextInfo;
}
@property (nonatomic, assign) NSString *selectedDeviceName;
@property (nonatomic) NSUInteger countdownValue;
@property (nonatomic) BOOL lockScreen;
@property (nonatomic) BOOL dimDisplay;
@property (nonatomic) BOOL dimKeyboard;
@property (nonatomic) NSUInteger thresholdValue;
@property NSUInteger signalStrength; // Not stored as a default
-(IBAction)selectDevice:(id)sender;
-(IBAction)addNewDevice:(id)sender;

+ (NSUInteger)preferenceCountDownValue;
+ (void)setPreferenceCountDownValue:(NSUInteger)value;

+ (BOOL)preferenceLockScreen;
+ (void)setPreferenceLockScreen:(BOOL)value;

+ (BOOL)preferenceDimDisplay;
+ (void)setPreferenceDimDisplay:(BOOL)value;

+ (BOOL)preferenceDimKeyboard;
+ (void)setPreferenceDimKeyboard:(BOOL)value;

+ (NSUInteger)preferenceThresholdValue;
+ (void)setPreferenceThresholdValue:(NSUInteger)value;

- (IBAction)resetToDefaults:(id)sender;

- (void)alertEnded:(NSAlert *)alert
              code:(NSInteger)choise
           context:(void *)v;
-(void)changeSelectedDevice;

@end
