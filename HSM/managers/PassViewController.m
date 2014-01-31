//
//  PassViewController.m
//  HSM
//
//  Created by Felipe Ricieri on 04/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "PassViewController.h"
#import "PassEnd.h"

@interface PassViewController ()
- (void) finishProcess;
@end

@implementation PassViewController
{
    FRTools *tools;
}

@synthesize passColor;
@synthesize vLoading;

#pragma mark -
#pragma mark Init Methods

- (id) initWithNibName:(NSString *)nibName andPassColor:(PassColor)color
{
    self = [super initWithNibName:nibName bundle:nil];
    passColor   = color;
    
    CGRect rect = CGRectMake(ZERO, ZERO, WINDOW_WIDTH, WINDOW_HEIGHT);
    vLoading    = [[UIView alloc] initWithFrame:rect];
    [vLoading setBackgroundColor:[UIColor colorWithRed:184.0/255.0 green:215.0/255.0 blue:236.0/255.0 alpha:1]];
    [vLoading setAlpha:0.7];
    UILabel *lab= [[UILabel alloc] initWithFrame:rect];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [lab setTextColor:[UIColor blackColor]];
    [lab setFont:[UIFont fontWithName:FONT_BOLD size:20]];
    [lab setText:@"Por favor, aguarde..."];
    [lab setBackgroundColor:[UIColor clearColor]];
    [vLoading addSubview:lab];
    
    return self;
}
- (id) initWithNibName:(NSString*) nibName andPassColor:(PassColor) color dictionary:(NSDictionary *)dict
{
    self        = [super initWithNibName:nibName andDictionary:dict];
    passColor   = color;
    
    CGRect rect = CGRectMake(ZERO, ZERO, WINDOW_WIDTH, WINDOW_HEIGHT);
    vLoading    = [[UIView alloc] initWithFrame:rect];
    [vLoading setBackgroundColor:[UIColor colorWithRed:184.0/255.0 green:215.0/255.0 blue:236.0/255.0 alpha:1]];
    [vLoading setAlpha:0.7];
    UILabel *lab= [[UILabel alloc] initWithFrame:rect];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [lab setTextColor:[UIColor blackColor]];
    [lab setFont:[UIFont fontWithName:FONT_BOLD size:20]];
    [lab setText:@"Por favor, aguarde..."];
    [lab setBackgroundColor:[UIColor clearColor]];
    [vLoading addSubview:lab];
    
    return self;
}

#pragma mark -
#pragma mark Record Methods

- (void)recordValue:(NSString *)value forKey:(NSString *)key atIndexPath:(NSIndexPath *)ip
{
    tools = [[FRTools alloc] initWithTools];
    
    NSMutableArray *plist           = [tools propertyListRead:PLIST_PASSES];
    NSMutableDictionary *pass       = [plist objectAtIndex:passColor];
    NSMutableArray *sections        = [pass objectForKey:KEY_SECTIONS];
    NSMutableDictionary *secDict    = [sections objectAtIndex:ip.section];
    NSMutableArray *rows            = [secDict objectForKey:KEY_ROWS];
    NSMutableDictionary *row        = [rows objectAtIndex:ZERO];
    
    [row setObject:value forKey:key];
    
    [rows setObject:row atIndexedSubscript:ZERO];
    [secDict setObject:rows forKey:KEY_ROWS];
    [sections setObject:secDict atIndexedSubscript:ip.section];
    [pass setObject:sections forKey:KEY_SECTIONS];
    [plist setObject:pass atIndexedSubscript:passColor];
    
    [tools propertyListWrite:plist forFileName:PLIST_PASSES];
}
- (void)recordParticipant:(NSMutableDictionary *)dict atIndexPath:(NSIndexPath *)ip
{
    tools = [[FRTools alloc] initWithTools];
    
    NSMutableArray *plist           = [tools propertyListRead:PLIST_PASSES];
    NSMutableDictionary *pass       = [plist objectAtIndex:passColor];
    NSMutableArray *sections        = [pass objectForKey:KEY_SECTIONS];
    NSMutableDictionary *secDict    = [sections objectAtIndex:ip.section];
    NSMutableArray *rows            = [secDict objectForKey:KEY_ROWS];
    
    NSInteger totalOfRows           = [rows count];
    NSInteger indexLastRow          = totalOfRows - 1;
    NSInteger limitOfRows           = [[secDict objectForKey:KEY_LIMIT] intValue];
    
    NSDictionary *addAnother        = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"4", KEY_TYPE,
                                       @"add", KEY_SUBTYPE,
                                       @"Adicionar Participante", KEY_LABEL, nil];
    NSMutableDictionary *row        = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"5", KEY_TYPE,
                                       @"edit", KEY_SUBTYPE,
                                       KEY_YES, KEY_CAN_REMOVE,
                                       [dict objectForKey:KEY_NAME], KEY_LABEL,
                                       dict, @"values", nil];
    
    // ...
    if (limitOfRows == 1)
        [row setObject:KEY_NO forKey:KEY_CAN_REMOVE];
    
    // add or edit?
    NSDictionary *tempDict = [self rowAtIndexPath:ip];
    if ([[tempDict objectForKey:KEY_SUBTYPE] isEqualToString:@"edit"])
    {
        [rows setObject:row atIndexedSubscript:ip.row];
    }
    else {
        [rows setObject:row atIndexedSubscript:indexLastRow];
        if(limitOfRows > [rows count])
            [rows addObject:addAnother];
    }
    
    [secDict setObject:rows forKey:KEY_ROWS];
    [sections setObject:secDict atIndexedSubscript:ip.section];
    [pass setObject:sections forKey:KEY_SECTIONS];
    [plist setObject:pass atIndexedSubscript:passColor];
    
    [tools propertyListWrite:plist forFileName:PLIST_PASSES];
}
- (NSDictionary *) rowAtIndexPath:(NSIndexPath *)ip
{
    tools = [[FRTools alloc] initWithTools];
    
    NSMutableArray *plist           = [tools propertyListRead:PLIST_PASSES];
    NSMutableDictionary *pass       = [plist objectAtIndex:passColor];
    NSMutableArray *sections        = [pass objectForKey:KEY_SECTIONS];
    NSMutableDictionary *secDict    = [sections objectAtIndex:ip.section];
    NSMutableArray *rows            = [secDict objectForKey:KEY_ROWS];
    NSDictionary *row               = [rows objectAtIndex:ip.row];
    
    return row;
}
- (BOOL) removeParticipantAtIndexPath:(NSIndexPath*) ip
{
    tools = [[FRTools alloc] initWithTools];
    
    NSDictionary *addAnother        = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"4", KEY_TYPE,
                                       @"add", KEY_SUBTYPE,
                                       @"Adicionar Participante", KEY_LABEL, nil];
    
    NSMutableArray *plist           = [tools propertyListRead:PLIST_PASSES];
    NSMutableDictionary *pass       = [plist objectAtIndex:passColor];
    NSMutableArray *sections        = [pass objectForKey:KEY_SECTIONS];
    NSMutableDictionary *secDict    = [sections objectAtIndex:ip.section];
    NSMutableArray *rows            = [secDict objectForKey:KEY_ROWS];
    
    if ([rows count] == 5)
        [rows addObject:addAnother];
    [rows removeObjectAtIndex:ip.row];
    
    [secDict setObject:rows forKey:KEY_ROWS];
    [sections setObject:secDict atIndexedSubscript:ip.section];
    [pass setObject:sections forKey:KEY_SECTIONS];
    [plist setObject:pass atIndexedSubscript:passColor];
    
    if([tools propertyListWrite:plist forFileName:PLIST_PASSES])
        return YES;
    else
        return NO;
}
- (void) saveFormDataToPropertyList
{
    tools       = [[FRTools alloc] initWithTools];
    
    NSMutableDictionary *plistInfo  = [NSMutableDictionary dictionary];
    
    NSMutableArray *plist           = [tools propertyListRead:PLIST_PASSES];
    NSMutableDictionary *pass       = [plist objectAtIndex:passColor];
    NSMutableArray *sections        = [pass objectForKey:KEY_SECTIONS];
    
    //
    switch (passColor)
    {
        // green..
        case kPassColorGreen:
        {
            NSMutableDictionary *secDate    = [sections objectAtIndex:0];
            NSMutableArray *rowsDate        = [secDate objectForKey:KEY_ROWS];
            
            NSMutableDictionary *secPart    = [sections objectAtIndex:1];
            NSMutableArray *rowsPart        = [secPart objectForKey:KEY_ROWS];
            
            NSMutableDictionary *secPaym    = [sections objectAtIndex:2];
            NSMutableArray *rowsPaym        = [secPaym objectForKey:KEY_ROWS];
            
            NSString *valueDates            = [[rowsDate objectAtIndex:0] objectForKey:KEY_LABEL];
            NSString *valuePayment          = [[rowsPaym objectAtIndex:0] objectForKey:KEY_LABEL];
            NSDictionary *part              = [[rowsPart objectAtIndex:0] objectForKey:KEY_VALUES];
            
            // ..
            // validate
            if ([valueDates isEqualToString:KEY_EMPTY]
            ||  [valueDates isEqualToString:@"Selecione..."]
            ||  [part count] < 1)
            {
                NSLog(@"part count: %i", [part count]);
                [tools dialogWithMessage:@"Por favor, preencha todos os campos antes de prosseguir."];
                return;
            }
            else
            {
                [plistInfo setObject:valueDates forKey:KEY_FORM_DATE];
                [plistInfo setObject:valuePayment forKey:KEY_FORM_PAYMENT];
                [plistInfo setObject:rowsPart forKey:KEY_FORM_PARTICIPANT];
                
                [tools propertyListWrite:plistInfo forFileName:PLIST_PASS_COMPLETED];
                NSDictionary *passCompleted = [tools propertyListRead:PLIST_PASS_COMPLETED];
                NSLog(@"%@", passCompleted);
                // ...
                [self sendPassEmailToHSM];
            }
        }
            break;
        // gold..
        case kPassColorGold:
        case kPassColorRed:
        {
            NSMutableDictionary *secPart    = [sections objectAtIndex:0];
            NSMutableArray *rowsPart        = [secPart objectForKey:KEY_ROWS];
            
            NSMutableDictionary *secPaym    = [sections objectAtIndex:1];
            NSMutableArray *rowsPaym        = [secPaym objectForKey:KEY_ROWS];
            
            NSString *valuePayment          = [[rowsPaym objectAtIndex:0] objectForKey:KEY_LABEL];
            NSDictionary *part              = [[rowsPart objectAtIndex:0] objectForKey:KEY_VALUES];
            
            // ..
            // validate
            if ([part count] < 1)
            {
                NSLog(@"part count: %i", [part count]);
                [tools dialogWithMessage:@"Por favor, preencha todos os campos antes de prosseguir."];
                return;
            }
            else
            {
                [plistInfo setObject:valuePayment forKey:KEY_FORM_PAYMENT];
                [plistInfo setObject:rowsPart forKey:KEY_FORM_PARTICIPANT];
                
                [tools propertyListWrite:plistInfo forFileName:PLIST_PASS_COMPLETED];
                NSDictionary *passCompleted = [tools propertyListRead:PLIST_PASS_COMPLETED];
                NSLog(@"%@", passCompleted);
                // ...
                [self sendPassEmailToHSM];
            }
        }
            break;
    }
}
- (void) sendPassEmailToHSM
{
    tools       = [[FRTools alloc] initWithTools];
    
    NSDictionary *dict  = [tools propertyListRead:PLIST_PASS_COMPLETED];
    NSDictionary *part;
    NSString *stringToRequest;
    
    // ...
    switch (passColor)
    {
        case kPassColorGreen:
        {
            part = [[[dict objectForKey:KEY_FORM_PARTICIPANT] objectAtIndex:0] objectForKey:KEY_VALUES];
            // proceed..
            stringToRequest = [NSString stringWithFormat:@"%@?os=ios&event_name=%@color=green&day=%@&payment=%@&name=%@&email=%@&cpf=%@&company=%@&role=%@",
                               URL_PASS_ADD,
                               [[[self dictionary] objectForKey:@"event_name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[dict objectForKey:KEY_FORM_DATE] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[dict objectForKey:KEY_FORM_PAYMENT] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[part objectForKey:KEY_NAME] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[part objectForKey:KEY_EMAIL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[part objectForKey:KEY_CPF] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[part objectForKey:KEY_COMPANY] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[part objectForKey:KEY_ROLE] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
            break;
        case kPassColorGold:
        {
            part = [[[dict objectForKey:KEY_FORM_PARTICIPANT] objectAtIndex:0] objectForKey:KEY_VALUES];
            // proceed..
            stringToRequest = [NSString stringWithFormat:@"%@?os=ios&event_name=%@&color=gold&payment=%@&name=%@&email=%@&cpf=%@&company=%@&role=%@",
                               URL_PASS_ADD,
                               [[[self dictionary] objectForKey:@"event_name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[dict objectForKey:KEY_FORM_PAYMENT] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[part objectForKey:KEY_NAME] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[part objectForKey:KEY_EMAIL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[part objectForKey:KEY_CPF] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[part objectForKey:KEY_COMPANY] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[part objectForKey:KEY_ROLE] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
            break;
        case kPassColorRed:
        {
            stringToRequest = [NSString stringWithFormat:@"%@?os=ios&event_name=%@&color=red&payment=%@",
                               URL_PASS_ADD,
                               [[[self dictionary] objectForKey:@"event_name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                               [[dict objectForKey:KEY_FORM_PAYMENT] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            NSArray *parts = [dict objectForKey:KEY_FORM_PARTICIPANT];
            int pointer = 0;
            for (NSDictionary *dict in parts)
            {
                part = [dict objectForKey:KEY_VALUES];
                stringToRequest = [stringToRequest stringByAppendingFormat:@"&people[%i][%@]=%@",
                                   pointer, @"name",
                                   [[part objectForKey:KEY_NAME] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                stringToRequest = [stringToRequest stringByAppendingFormat:@"&people[%i][%@]=%@",
                                   pointer, @"email",
                                   [[part objectForKey:KEY_EMAIL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                stringToRequest = [stringToRequest stringByAppendingFormat:@"&people[%i][%@]=%@",
                                   pointer, @"cpf",
                                   [[part objectForKey:KEY_CPF] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                stringToRequest = [stringToRequest stringByAppendingFormat:@"&people[%i][%@]=%@",
                                   pointer, @"company",
                                   [[part objectForKey:KEY_COMPANY] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                stringToRequest = [stringToRequest stringByAppendingFormat:@"&people[%i][%@]=%@",
                                   pointer, @"role",
                                   [[part objectForKey:KEY_ROLE] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                pointer++;
            }
        }
            break;
    }
    NSLog(@"URL to request: %@", stringToRequest);
    
    // register..
    [[self view] addSubview:vLoading];
    [tools requestUpdateFrom:stringToRequest success:^{
        // finish process..
        [self finishProcess];
        
    } fail:^{
        [vLoading removeFromSuperview];
        [tools dialogWithMessage:@"Ocorreu um erro ao enviar sua pré-compra. Por favor, verifique sua conexão à internet e tente novamente."];
    }];
}
- (void) finishProcess
{
    [vLoading removeFromSuperview];
    
    NSMutableDictionary *userLogs = [tools propertyListRead:PLIST_LOGS];
    [userLogs setObject:KEY_YES forKey:KEY_PASSCODE_SENT];
    [tools propertyListWrite:userLogs forFileName:PLIST_LOGS];
    
    PassEnd *vc = [[PassEnd alloc] initWithNibName:NIB_PASSES_END andPassColor:[self passColor]];
    [[self navigationController] pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark Table Methods

- (NSInteger) heightForCellType:(PassCellType) cellType
{
    NSInteger height = 0;
    switch (cellType)
    {
        case kCellTypeSubtitle:
        {
            height = 63.0;
        }
            break;
        case kCellTypeForm:
        {
            height = 264.0;
        }
            break;
        case kCellTypePicker:
        case kCellTypePickerPayment:
        case kCellTypeAdd:
        case kCellTypeEdit:
        {
            height = 44.0;
        }
            break;
    }
    return height;
}

- (NSString*) stringForPassColor:(PassColor) color
{
    NSString *str;
    switch (color)
    {
        case kPassColorGreen:
        {
            str = KEY_PASS_GREEN;
        }
            break;
        case kPassColorGold:
        {
            str = KEY_PASS_GOLD;
        }
            break;
        case kPassColorRed:
        {
            str = KEY_PASS_RED;
        }
            break;
    }
    return str;
}

#pragma mark -
#pragma mark Picker Methods

- (void) pickerShow:(UIPickerView*) picker
{
    [UIView animateWithDuration:0.3f animations:^{
        [picker setFrame:RECT_PICKER_SHOW];
    }];
}
- (void) pickerHide:(UIPickerView*) picker
{
    [UIView animateWithDuration:0.3f animations:^{
        [picker setFrame:RECT_PICKER_HIDE];
    }];
}

@end
