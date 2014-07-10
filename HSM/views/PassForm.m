//
//  PassForm.m
//  HSM
//
//  Created by Felipe Ricieri on 04/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "PassForm.h"
#import "PassAdd.h"

#import "PassTitleCell.h"
#import "PassSubTitleCell.h"
#import "PassFormCell.h"
#import "PassPickerCell.h"
#import "PassPickerPaymentCell.h"
#import "PassAddCell.h"
#import "PassEditCell.h"

#import "PassButton.h"
#import "PassTextField.h"

@interface PassForm ()
- (void) reloadTableData;
@end

@implementation PassForm
{
    NSIndexPath *touchedIndexPath;
}

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setConfigurations];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadTableData];
}

#pragma mark -
#pragma mark Default Methods

- (void) setConfigurations
{
    [super setConfigurations];
    [self setTitle:@"Pré-Compra"];
    
    dates = [[self dictionary] objectForKey:@"dates"];
    
    // ...
    [self reloadTableData];
    
    NSString *strImg    = [NSString stringWithFormat:TITLE_BG, [self stringForPassColor:[self passColor]]];
    [imgHeader setImage:[UIImage imageNamed:strImg]];
	[tableHeaderTitle setText:[[self dictionary] objectForKey:@"name"]];
	//tableHeaderTitle.font = [UIFont fontWithName:FONT_REGULAR size:tableHeaderTitle.font.pointSize];
    
    [table setTableHeaderView:tableHeader];
    [table setTableFooterView:tableFooter];
    touchedIndexPath = [[NSIndexPath alloc] init];
    
    // ...
    [pvDates setFrame:RECT_PICKER_HIDE];
    [pvPayment setFrame:RECT_PICKER_HIDE];
    [[self view] addSubview:pvDates];
    [[self view] addSubview:pvPayment];
}

#pragma mark -
#pragma mark Methods

- (void) reloadTableData
{
    plist       = [tools propertyListRead:PLIST_PASSES];
    passData    = [plist objectAtIndex:[self passColor]];
    passSections= [passData objectForKey:KEY_SECTIONS];
    [table reloadData];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)pressConfirm:(id)sender
{
    [self saveFormDataToPropertyList];
}
- (void) pressDelete:(id)sender
{
    PassButton *bt = (PassButton*)sender;
    touchedIndexPath = bt.cellIndexPath;
    
    [tools promptWithMessage:@"Tem certeza que deseja excluir este participante?" competitionYes:^{
        [self removeParticipantAtIndexPath:touchedIndexPath];
        [self reloadTableData];
    } competitionNo:^{
        // ...
        // nothing happens
    }];
}

#pragma mark -
#pragma mark UITableViewDelegate & UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [passSections count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self heightForCellType:kCellTypeSubtitle];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *xib                = [[NSBundle mainBundle] loadNibNamed:XIB_PASSES owner:nil options:nil];
    PassSubTitleCell *subTitle  = (PassSubTitleCell*)[xib objectAtIndex:kCellTypeSubtitle];
    NSDictionary *obj           = [passSections objectAtIndex:section];
    NSInteger numSection        = section+1;
    NSString *strBg             = [NSString stringWithFormat:CELL_SUBTITLE_BG, [self stringForPassColor:[self passColor]]];
    UIImage *imgBg              = [UIImage imageNamed:strBg];
    
    [[subTitle labNum] setText:[NSString stringWithFormat:@"%i", numSection]];
    [[subTitle labText] setText:[obj objectForKey:KEY_LABEL]];
    [[subTitle imgBg] setImage:imgBg];
    
    return subTitle;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[passSections objectAtIndex:section] objectForKey:KEY_ROWS] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rows = [[passSections objectAtIndex:indexPath.section] objectForKey:KEY_ROWS];
    PassCellType type = (PassCellType)[[[rows objectAtIndex:indexPath.row] objectForKey:KEY_TYPE] intValue];
    return [self heightForCellType:type];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // dict..
    NSInteger section   = indexPath.section;
    NSInteger row       = indexPath.row;
    NSDictionary *dict  = [[[passSections objectAtIndex:section] objectForKey:KEY_ROWS] objectAtIndex:row];
    // xib..
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_PASSES owner:nil options:nil];
    UIImageView *imgBg;
    // cell..
    id cell             = nil;
    
    PassCellType type   = [[dict objectForKey:KEY_TYPE] intValue];
    switch (type)
    {
        // ...
        case kCellTypePicker:
        {
            // picker
            cell = (PassPickerCell *)[tableView dequeueReusableCellWithIdentifier:CELL_PICKER];
            if(!cell)
                cell = (PassPickerCell*)[xib objectAtIndex:kCellTypePicker];
            
            [[cell labText] setText:@"Selecione..."];
            
            // background..
            imgBg   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:CELL_PICKER_BG]];
            [cell setBackgroundView:imgBg];
        }
            break;
        // ...
        case kCellTypePickerPayment:
        {
            // picker (payment)
            cell = (PassPickerPaymentCell *)[tableView dequeueReusableCellWithIdentifier:CELL_PICKER_PAYMENT];
            if(!cell)
                cell = (PassPickerPaymentCell*)[xib objectAtIndex:kCellTypePickerPayment];
            
            [[cell labText] setText:[dict objectForKey:KEY_LABEL]];
            
            // background..
            imgBg   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:CELL_PICKER_PAYMENT_BG]];
            [cell setBackgroundView:imgBg];
        }
            break;
        // ...
        case kCellTypeForm:
        {
            // form
            cell = (PassFormCell *)[tableView dequeueReusableCellWithIdentifier:CELL_FORM];
            if(!cell)
                cell = (PassFormCell*)[xib objectAtIndex:kCellTypeForm];
            
            [[cell labText] setText:[dict objectForKey:KEY_LABEL]];
            
            // background..
            imgBg   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:CELL_FORM_BG]];
            [cell setBackgroundView:imgBg];
        }
            break;
        // ...
        case kCellTypeAdd:
        {
            // add..
            cell = (PassAddCell *)[tableView dequeueReusableCellWithIdentifier:CELL_ADD];
            if(!cell)
                cell = (PassAddCell*)[xib objectAtIndex:kCellTypeAdd];
            
            [[cell labText] setText:[dict objectForKey:KEY_LABEL]];
            
            // background..
            imgBg   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:CELL_ADD_BG]];
            [cell setBackgroundView:imgBg];
        }
            break;
        // ...
        case kCellTypeEdit:
        {
            // add..
            cell = (PassEditCell *)[tableView dequeueReusableCellWithIdentifier:CELL_EDIT];
            if(!cell)
                cell = (PassEditCell*)[xib objectAtIndex:kCellTypeEdit];
            
            [[cell labText] setText:[dict objectForKey:KEY_LABEL]];
            
            if(![[dict objectForKey:KEY_CAN_REMOVE] isEqualToString:KEY_YES])
                [[cell but] setHidden:YES];
            
            PassButton *bt = (PassButton*)[cell but];
            [bt setCellIndexPath:indexPath];
            [bt addTarget:self action:@selector(pressDelete:) forControlEvents:UIControlEventTouchUpInside];
            
            // background..
            imgBg   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:CELL_EDIT_BG]];
            [cell setBackgroundView:imgBg];
        }
            break;
        // ...
        case kCellTypeSubtitle:
        default:
            // nothing for subtitle and default...
            break;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // dict..
    NSInteger section   = indexPath.section;
    NSInteger row       = indexPath.row;
    NSDictionary *dict  = [[[passSections objectAtIndex:section] objectForKey:KEY_ROWS] objectAtIndex:row];
    
    PassCellType type   = [[dict objectForKey:KEY_TYPE] intValue];
    switch (type) {
        // ...
        case kCellTypePicker:
        {
            // picker
            [table setUserInteractionEnabled:NO];
            touchedIndexPath = indexPath;
            [self pickerShow:pvDates];
        }
            break;
        // ...
        case kCellTypePickerPayment:
        {
            // picker (payment)
            //[table setUserInteractionEnabled:NO];
            //touchedIndexPath = indexPath;
            //[self pickerShow:pvPayment];
        }
            break;
        // ...
        case kCellTypeForm:
        {
            // form
        }
            break;
        // ...
        case kCellTypeAdd:
        case kCellTypeEdit:
        {
            // edit..
            PassAdd *vc = [[PassAdd alloc] initWithPassColor:[self passColor] andIndexPath:indexPath];
            [[self navigationController] pushViewController:vc animated:YES];
        }
            break;
        // ...
        case kCellTypeSubtitle:
        default:
            // nothing for subtitle and default...
            break;
    }
}

#pragma mark -
#pragma mark UIPickerViewDelegate & UIPickerViewDeataSource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == pvDates)
        return [dates count];
    else
        return [VALUES_PAYMENT count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == pvDates)
        return [dates objectAtIndex:row];
    else
        return [VALUES_PAYMENT objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // dates..
    if (pickerView == pvDates)
    {
        PassPickerCell *cell = (PassPickerCell*)[table cellForRowAtIndexPath:touchedIndexPath];
        [[cell labText] setText:[dates objectAtIndex:row]];
        [self recordValue:[dates objectAtIndex:row] forKey:KEY_LABEL atIndexPath:touchedIndexPath];
    }
    // payment..
    else {
        PassPickerPaymentCell *cell = (PassPickerPaymentCell*)[table cellForRowAtIndexPath:touchedIndexPath];
        [[cell labText] setText:[VALUES_PAYMENT objectAtIndex:row]];
        [self recordValue:[VALUES_PAYMENT objectAtIndex:row] forKey:KEY_LABEL atIndexPath:touchedIndexPath];
    }
    
    [table setUserInteractionEnabled:YES];
    [self pickerHide:pickerView];
}

@end
