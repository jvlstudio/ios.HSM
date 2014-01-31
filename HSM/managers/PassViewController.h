//
//  PassViewController.h
//  HSM
//
//  Created by Felipe Ricieri on 04/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"
#import "PassConstants.h"

@interface PassViewController : KDViewController

@property (nonatomic) PassColor passColor;
@property (nonatomic, strong) UIView *vLoading;

#pragma mark -
#pragma mark Init Methods

- (id) initWithNibName:(NSString*) nibName andPassColor:(PassColor) color;
- (id) initWithNibName:(NSString*) nibName andPassColor:(PassColor) color dictionary:(NSDictionary*) dict;

#pragma mark -
#pragma mark Record Methods

- (void) recordValue: (NSString*) value forKey:(NSString*) key atIndexPath:(NSIndexPath*) ip;
- (void) recordParticipant:(NSMutableDictionary*) dict atIndexPath:(NSIndexPath*) ip;
- (NSDictionary*) rowAtIndexPath:(NSIndexPath*) ip;
- (BOOL) removeParticipantAtIndexPath:(NSIndexPath*) ip;
- (void) saveFormDataToPropertyList;
- (void) sendPassEmailToHSM;

#pragma mark -
#pragma mark Table Methods

- (NSInteger) heightForCellType:(PassCellType) cellType;
- (NSString*) stringForPassColor:(PassColor) color;

#pragma mark -
#pragma mark Picker Methods

- (void) pickerShow:(UIPickerView*) picker;
- (void) pickerHide:(UIPickerView*) picker;

@end