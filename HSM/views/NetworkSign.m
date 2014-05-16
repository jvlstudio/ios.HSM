//
//  NetworkSign.m
//  HSM
//
//  Created by Felipe Ricieri on 17/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "NetworkSign.h"

@implementation NetworkSign
{
    CGPoint currentOffset;
}

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithCloseButton];
    [self setConfigurations];
}

#pragma mark -
#pragma mark Default Methods

- (void) setConfigurations
{
    [super setConfigurations];
    [self setTitle:@"Criar meu cartão"];
    
    for (UIView *vv in [v subviews]) {
        if ([vv isKindOfClass:[UITextField class]]) {
            UITextField *tf = (UITextField*)vv;
            [tf setValue:COLOR_DESCRIPTION forKeyPath:@"_placeholderLabel.textColor"];
        }
    }
    
    [[butCreate titleLabel] setFont:[UIFont fontWithName:FONT_REGULAR size:18.0]];
    
    [scr setContentSize:CGSizeMake(v.frame.size.width, v.frame.size.height)];
    [scr addSubview:v];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) doneEditing:(id)sender
{
    UITextField *tf = (UITextField*) sender;
    [tf endEditing:YES];
}
- (IBAction) pressCreate:(id)sender
{
    // ...
    if (![tools isValidEmail:[tfEmail text]])
        [tools dialogWithMessage:@"Por favor, insira um e-mail válido."];
    // ...
    else if ([[tfName text] length] < 3)
        [tools dialogWithMessage:@"Por favor, insira seu nome."];
    // ...
    else
    {
        actsheet = [[UIActionSheet alloc] initWithTitle:@"Qual é a cor do seu passe?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Verde", @"Dourado", @"Vermelho", nil];
        [actsheet showInView:[self view]];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    currentOffset = scr.contentOffset;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    currentOffset = scr.contentOffset;
}

#pragma mark -
#pragma mark UITextFieldDelegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scr setContentOffset:currentOffset];
    [scr setContentSize:CGSizeMake(scr.contentSize.width, scr.contentSize.height+KEYBOARD_HEIGHT)];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [scr setContentSize:CGSizeMake(scr.contentSize.width, scr.contentSize.height-KEYBOARD_HEIGHT)];
}

#pragma mark -
#pragma mark UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    PassColor colorPass = buttonIndex;
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    
    [mdict setObject:[tfName text] forKey:KEY_NAME];
    [mdict setObject:[tfEmail text] forKey:KEY_EMAIL];
    [mdict setObject:[tfPhone text] forKey:KEY_PHONE];
    [mdict setObject:[tfMobile text] forKey:KEY_MOBILE];
    [mdict setObject:[tfCompany text] forKey:KEY_COMPANY];
    [mdict setObject:[tfRole text] forKey:KEY_ROLE];
    [mdict setObject:[tfWebsite text] forKey:KEY_WEBSITE];
    
    // ..
    switch (colorPass)
    {
        case kPassColorGreen:
        {
            [mdict setObject:KEY_PASS_GREEN forKey:KEY_BARCOLOR];
        }
            break;
        case kPassColorGold:
        {
            [mdict setObject:KEY_PASS_GOLD forKey:KEY_BARCOLOR];
        }
            break;
        case kPassColorRed:
        {
            [mdict setObject:KEY_PASS_RED forKey:KEY_BARCOLOR];
        }
            break;
    }
    
    // ..
    [self setSelfCard:[mdict copy]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
