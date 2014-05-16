//
//  Network.m
//  HSM
//
//  Created by Felipe Ricieri on 17/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "Network.h"
#import "NetworkCell.h"
#import "NetworkSingle.h"
#import "NetworkSign.h"

@implementation Network

@synthesize table;

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithMenuButton];
    [self setConfigurations];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    tableData   = [tools propertyListRead:PLIST_NETWORK];
    [table reloadData];
    
    // ...
    NSDictionary *dict  = [tools propertyListRead:PLIST_MYCONTACT];
    
    [selfTitle setText:[dict objectForKey:KEY_NAME]];
    [selfSubtitle setText:[dict objectForKey:KEY_COMPANY]];
    
    NSString *strImg    = [NSString stringWithFormat:@"hsm_ball_%@.png", [dict objectForKey:KEY_BARCOLOR]];
    [selfColor setImage:[UIImage imageNamed:strImg]];
    
    [[butCreate titleLabel] setFont:[UIFont fontWithName:FONT_REGULAR size:17.0]];
    [selfTitle setFont:[UIFont fontWithName:FONT_REGULAR size:selfTitle.font.pointSize]];
    
    // ...
    if ([self hasCreatedSelfCard])
    {
        [createView setHidden:YES];
        [table setTableHeaderView:nil];
    }
    else
        [table setTableHeaderView:[self edge]];
}

#pragma mark -
#pragma mark Default Methods

- (void) setConfigurations
{
    [super setConfigurations];
    [self setTitle:@"Network"];
    
    tools   = [[FRTools alloc] initWithTools];
    [self setScanButtonWithSelector:@selector(pressScan:)];
    
    UIView *tempv   = [[UIView alloc] initWithFrame:createView.frame];
    [tempv setBackgroundColor:[UIColor clearColor]];
    [table setTableFooterView:tempv];
    
    CGRect rectv    = createView.frame;
    rectv.origin.y  -= IPHONE5_COEF;
    [createView setFrame:rectv];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressCreate:(id)sender
{
    NetworkSign *vc = [[NetworkSign alloc] initWithNibName:NIB_NETWORK_SIGN bundle:nil];
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:n animated:YES completion:nil];
}
- (IBAction) pressSelf:(id)sender
{
    NSDictionary *selfCard = [tools propertyListRead:PLIST_MYCONTACT];
    NetworkSingle *vc   = [[NetworkSingle alloc] initWithNibName:NIB_NETWORK_SINGLE andDictionary:selfCard];
    [[self navigationController] pushViewController:vc animated:YES];
}
- (void) pressScan:(id)sender
{
    zBarReader = [ZBarReaderViewController new];
    zBarReader.readerDelegate = self;
    zBarReader.supportedOrientationsMask = ZBarOrientationMask(UIInterfaceOrientationPortrait);
    //zBarReader.cameraOverlayView = overlayView;
    
    ZBarImageScanner *scanner = zBarReader.scanner;
    
    //EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    [self presentViewController:zBarReader animated:YES completion:nil];
}

#pragma mark -
#pragma mark UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self hasCreatedSelfCard])
        return selfView;
    else
        return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self hasCreatedSelfCard])
        return selfView.frame.size.height;
    else
        return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict  = [tableData objectAtIndex:indexPath.row];
    NSArray *xib        = [[NSBundle mainBundle] loadNibNamed:XIB_RESOURCES owner:nil options:nil];
    NetworkCell *cell   = (NetworkCell*)[xib objectAtIndex:kCellNetwork];
    
    [[cell labText] setText:[dict objectForKey:KEY_NAME]];
    [[cell labSubtext] setText:[dict objectForKey:KEY_COMPANY]];
    
    [[cell labText] setFont:[UIFont fontWithName:FONT_REGULAR size:cell.labText.font.pointSize]];
    
    NSString *strColor  = [NSString stringWithFormat:@"hsm_ball_%@.png", [dict objectForKey:KEY_BARCOLOR]];
    [[cell imgColor] setImage:[UIImage imageNamed:strColor]];
    
    if ([self hasContactBeenAdd:[dict objectForKey:KEY_EMAIL]])
        [[cell imgOpt] setImage:[UIImage imageNamed:@"hsm_id_tick.png"]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict  = [tableData objectAtIndex:indexPath.row];
    NetworkSingle *vc   = [[NetworkSingle alloc] initWithNibName:NIB_NETWORK_SINGLE andDictionary:dict];
    [[self navigationController] pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark ZBarDelegate Methods

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)
        //EXAMPLE: just grab the first barcode
        break;
    
    // data..
    zBarSymbolData = symbol.data;
    NSLog(@"%@", zBarSymbolData);
    
    if([self isValidQRCode:zBarSymbolData])
    {
        // check if exists
        NSDictionary *contactDict = [self QRCodeDecrypt:zBarSymbolData];
        // ..
        if([self isContactAlreadyAdded:[contactDict objectForKey:KEY_EMAIL]])
        {
            [zBarReader dismissViewControllerAnimated:YES completion:^{
                [tools dialogWithMessage:@"Este contato já está salvo em seu Network."];
            }];
        }
        else {
            // save
            // ..
            [self saveContact:contactDict];
            [zBarReader dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else {
        [zBarReader dismissViewControllerAnimated:YES completion:^{
            [tools dialogWithMessage:@"Este QR Code não é válido para adicionar um contato ao seu Network."];
        }];
    }
}

@end
