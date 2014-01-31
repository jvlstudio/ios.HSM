//
//  Passes.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "Passes.h"
#import "PassForm.h"

@interface Passes ()
- (void) pushWithPassColor:(PassColor) passColor dictionary:(NSDictionary*) dict;
- (void) setConfigurations;
@end

@implementation Passes

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setConfigurations];
}
- (void)setConfigurations
{
    [self setTitle:@"Passes"];
    
    // ...
    NSInteger height = v.frame.size.height;
    for (NSString *key in [self dictionary])
    {
        NSDictionary *dict = [[self dictionary] objectForKey:key];
        // green
        if ([key isEqualToString:KEY_PASS_GREEN])
        {
            [greenName setText:[dict objectForKey:KEY_LABEL]];
            [greenDescription setText:[dict objectForKey:KEY_DESCRIPTION]];
            [greenValue setText:[NSString stringWithFormat:@"Preço Normal: R$%@", [dict objectForKey:@"value_site"]]];
            [greenValueSpecial setText:[NSString stringWithFormat:@"R$%@", [dict objectForKey:@"value_app"]]];
            
            CGRect rect = greenView.frame;
            rect.origin.y = height;
            [greenView setFrame:rect];
            height += greenView.frame.size.height;
            [scr addSubview:greenView];
        }
        // gold
        if ([key isEqualToString:KEY_PASS_GOLD])
        {
            [goldName setText:[dict objectForKey:KEY_LABEL]];
            [goldDescription setText:[dict objectForKey:KEY_DESCRIPTION]];
            [goldValue setText:[NSString stringWithFormat:@"Preço Normal: R$%@", [dict objectForKey:@"value_site"]]];
            [goldValueSpecial setText:[NSString stringWithFormat:@"R$%@", [dict objectForKey:@"value_app"]]];
            
            CGRect rect = goldView.frame;
            rect.origin.y = height;
            [goldView setFrame:rect];
            height += goldView.frame.size.height;
            [scr addSubview:goldView];
        }
        // red
        if ([key isEqualToString:KEY_PASS_RED])
        {
            [redName setText:[dict objectForKey:KEY_LABEL]];
            [redDescription setText:[dict objectForKey:KEY_DESCRIPTION]];
            [redValue setText:[NSString stringWithFormat:@"Preço Normal: R$%@", [dict objectForKey:@"value_site"]]];
            [redValueSpecial setText:[NSString stringWithFormat:@"R$%@", [dict objectForKey:@"value_app"]]];
            
            CGRect rect = redView.frame;
            rect.origin.y = height;
            [redView setFrame:rect];
            height += redView.frame.size.height;
            [scr addSubview:redView];
        }
    }
    
    // ..
    [scr setContentSize:CGSizeMake(v.frame.size.width, height)];
    [scr addSubview:v];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressGreen:(id)sender
{
    [self pushWithPassColor:kPassColorGreen dictionary:[[self dictionary] objectForKey:KEY_PASS_GREEN]];
}
- (IBAction) pressGold:(id)sender
{
    [self pushWithPassColor:kPassColorGold dictionary:[[self dictionary] objectForKey:KEY_PASS_GOLD]];
}
- (IBAction) pressRed:(id)sender
{
    [self pushWithPassColor:kPassColorRed dictionary:[[self dictionary] objectForKey:KEY_PASS_RED]];
}

#pragma mark -
#pragma mark Private Methods

- (void) pushWithPassColor:(PassColor) passColor dictionary:(NSDictionary*) dict
{
    PassForm *vc = [[PassForm alloc] initWithNibName:NIB_PASSES_FORM andPassColor:passColor dictionary:dict];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end