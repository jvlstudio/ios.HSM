//
//  PassAdd.m
//  HSM
//
//  Created by Felipe Ricieri on 07/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "PassAdd.h"
#import "PassTextField.h"

@interface PassAdd ()
- (void) fillIfHasParticipant;
- (void) textFieldDidEndOnExit:(id) sender;
- (BOOL) isFormValidToSubmit;
@end

@implementation PassAdd
{
    FRTools *tools;
    CGPoint currentOffset;
}

#pragma mark -
#pragma mark Init Methods

- (id)initWithPassColor:(PassColor)color andIndexPath:(NSIndexPath *)ip
{
    self = [super initWithNibName:NIB_PASSES_ADD andPassColor:color];
    indexPath = ip;
    return self;
}

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setTitle:@"Adicionar Participante"];
    
    tools = [[FRTools alloc] initWithTools];
    
    [scr setContentSize:CGSizeMake(v.frame.size.width, v.frame.size.height)];
    [scr addSubview:v];
    
    // set delegate ..
    NSArray *subviews = [v subviews];
    for (UIView *vs in subviews)
    {
        if ([vs isKindOfClass:[PassTextField class]])
        {
            PassTextField *tf = (PassTextField*)vs;
            [tf setDelegate:self];
            [tf addTarget:self action:@selector(textFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEnd];
            [tf addTarget:self action:@selector(textFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
        }
    }
    
    // ...
    // check if participant was touched
    [self fillIfHasParticipant];
}


#pragma mark -
#pragma mark IBActions

- (IBAction) pressConfirm:(id)sender
{
    if ([self isFormValidToSubmit])
    {
        NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
        [mutDict setObject:[tfName text] forKey:KEY_NAME];
        [mutDict setObject:[tfCompany text] forKey:KEY_COMPANY];
        [mutDict setObject:[tfEmail text] forKey:KEY_EMAIL];
        [mutDict setObject:[tfRole text] forKey:KEY_ROLE];
        [mutDict setObject:[tfCPF text] forKey:KEY_CPF];
        // ...
        [self recordParticipant:mutDict atIndexPath:indexPath];
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark Methods

- (void) fillIfHasParticipant
{
    NSDictionary *dict = [self rowAtIndexPath:indexPath];
    if ([[dict objectForKey:KEY_SUBTYPE] isEqualToString:@"edit"])
    {
        NSDictionary *values = [dict objectForKey:KEY_VALUES];
        [tfName setText:[values objectForKey:KEY_NAME]];
        [tfEmail setText:[values objectForKey:KEY_EMAIL]];
        [tfCompany setText:[values objectForKey:KEY_COMPANY]];
        [tfRole setText:[values objectForKey:KEY_ROLE]];
        [tfCPF setText:[values objectForKey:KEY_CPF]];
    }
}
- (BOOL) isFormValidToSubmit
{
    // check name..
    if ([[tfName text] length] < 3) {
        [tools dialogWithMessage:@"Por favor, digite o nome do participante."];
        return NO;
    }
    // check email..
    if (![tools isValidEmail:[tfEmail text]]){
        [tools dialogWithMessage:@"Por favor, digite um e-mail válido."];
        return NO;
    }
    // check role..
    if ([[tfRole text] length] < 3) {
        [tools dialogWithMessage:@"Por favor, digite o cargo do participante."];
        return NO;
    }
    // check company..
    if ([[tfCompany text] length] < 3) {
        [tools dialogWithMessage:@"Por favor, digite a empresa onde o participante trabalha."];
        return NO;
    }
    // check cpf..
    if (![tools isValidCPF:[tfCPF text]]) {
        [tools dialogWithMessage:@"Por favor, digite um CPF válido."];
        return NO;
    }
    
    return YES;
}

#pragma mark -
#pragma mark UITextFieldDelegate Methods

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    CGSize rect  = scr.contentSize;
    rect.height += PICKER_HEIGHT;
    
    [scr setContentSize:rect];
    [scr setContentOffset:currentOffset];
}
- (void) textFieldDidEndEditing:(UITextField *)textField
{
    CGSize rect  = scr.contentSize;
    rect.height -= PICKER_HEIGHT;
    [scr setContentSize:rect];
}
- (void) textFieldDidEndOnExit:(id) sender
{
    PassTextField *tf = (PassTextField*)sender;
    [tf endEditing:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    currentOffset = scrollView.contentOffset;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    currentOffset = scrollView.contentOffset;
}

@end
