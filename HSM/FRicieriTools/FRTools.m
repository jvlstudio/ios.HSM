//
//  FRTools.m
//  T-APL
//
//  Created by Felipe Ricieri on 11/09/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "FRTools.h"

#define ERROR_1009_TITLE    @"Sem conexão"
#define ERROR_1009_MESSAGE  @"Não foi possível conectar com a internet."
#define ERROR_1001_TITLE    @"Tempo limite atingido"
#define ERROR_1001_MESSAGE  @"O tempo limite de tentativa para conectar com o servidor esgotou."
#define ERROR_1004_TITLE    @"Erro de conexão"
#define ERROR_1004_MESSAGE  @"Não foi possível conectar ao servidor."
#define ERROR_0000_TITLE    @"Erro"
#define ERROR_0000_MESSAGE  @"Não foi possível conectar com a internet."

#define BUTTON_CANCEL       @"Fechar"
#define BUTTON_YES          @"Sim"
#define BUTTON_NO           @"Não"

/* interface */

@interface FRTools ()
- (void) loadRequestWithURL:(NSString *)urlParam;
- (void) dataToJSON;
- (void) downloadDataToFile:(NSData *)contentData;
@end

/* implementation */

@implementation FRTools
{
    NSDictionary* globalPlist;
    NSString *rootPath;
    NSString* plistWithRootPath;
}

@synthesize frCompYes;
@synthesize frCompNo;

#pragma mark -
#pragma mark Start Methods

- (id) initWithTools
{
    HTTPData          = @"";
    updateLastKey   = @"";
    JSONData        = [NSDictionary dictionary];
    
    return self;
}
- (id) initWithtoolsAndRootViewController:(UIViewController*) parent
{
    HTTPData          = @"";
    updateLastKey   = @"";
    JSONData        = [NSDictionary dictionary];
    parentViewController    = parent;
    
    return self;
}

/*********************
 * FR > plists
 *********************/

#pragma mark -
#pragma mark Methods

- (id)   propertyListRead:(NSString*) plistName
{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                    NSUserDomainMask, YES) objectAtIndex:0];
    
	NSString *path = [[NSString alloc] initWithFormat:@"%@.plist", plistName];
    plistWithRootPath = [rootPath stringByAppendingPathComponent:path];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistWithRootPath]) {
        plistWithRootPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistWithRootPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    return temp;
}
- (BOOL) propertyListWrite:(id) content forFileName:(NSString*) fileName
{
    NSString *errorDesc = nil;
    rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                    NSUserDomainMask, YES) objectAtIndex:0];
	
	NSString *path = [[NSString alloc] initWithFormat:@"%@.plist", fileName];
    plistWithRootPath = [rootPath stringByAppendingPathComponent:path];
    
    if(content) {
        if([content writeToFile:plistWithRootPath atomically:YES]){
			return YES;
		}
		else {
			NSLog(@"Erro ao escrever a PLIST: %@", errorDesc);
			return NO;
		}
    }
    else {
        NSLog(@"Erro ao ler a PLIST: %@", errorDesc);
        return NO;
    }
}

/*********************
 * FR > methods
 *********************/

#pragma mark -
#pragma mark String Methods

- (NSArray*) explode: (NSString*) string bySeparator:(NSString*)separator
{
    NSArray* x = [string componentsSeparatedByString:separator];
    return x;
}
- (BOOL)     compare: (NSString*) string1 with:(NSString*) string2
{
    if([string1 isEqualToString:string2])
        return YES;
    else
        return NO;
}

#pragma mark -
#pragma mark AudioToolbox Methods

- (void) soundWithFileName: (NSString *) fName ofType:(NSString *) ext
{
    AudioServicesDisposeSystemSoundID(audioEffect);
    NSString *path  = [[NSBundle mainBundle] pathForResource : fName ofType :ext];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path])
    {
        NSURL *pathURL = [NSURL fileURLWithPath : path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
    else
    {
        NSLog(@"error, file not found: %@", path);
    }
}

/*********************
 * FR > update
 *********************/

@synthesize canShowErrorAlerts;
@synthesize HTTPData;
@synthesize updateLastKey;
@synthesize POSTData;
@synthesize JSONData;
@synthesize connection;
@synthesize parentViewController;

#pragma mark -
#pragma mark Sync Methods

- (void) sync: (NSString *) message
{
    [self sync:message success:nil];
}
- (void) sync: (NSString *) message success:(void(^)(void))callback
{
    // start..
    [self syncStart:message];
}
- (void) syncStart: (NSString *) message
{
    /*// status...
    statusDisplay                = [MTStatusBarOverlay sharedInstance];
    statusDisplay.animation      = MTStatusBarOverlayAnimationFallDown;
    statusDisplay.detailViewMode = MTDetailViewModeHistory;
    statusDisplay.delegate       = parentViewController;
    statusDisplay.progress       = 1.0;
    [statusDisplay postMessage:message];*/
}
- (void) syncHandle: (NSString *) message
{
    //[statusDisplay postMessage:message animated:YES];
    //statusDisplay.progress       = 2.0;
}
- (void) syncEnd: (NSString *) message
{
    /*
    [statusDisplay postImmediateFinishMessage:message duration:2.0 animated:YES];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // ...
    });*/
}
- (void) syncError: (NSString *) message
{
    /*
    [statusDisplay postErrorMessage:message duration:2.0 animated:YES];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // ...
    });*/
}

#pragma mark -
#pragma mark Request Methods

- (NSString*) URLEncode: (NSString*) string
{
    [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return string;
}
- (NSURLRequest*) URLAsRequest: (NSString*) url
{
    NSString* URLWithParameters = [[NSString alloc] initWithString:url];
    
    NSURL *RealURL = [NSURL URLWithString:[URLWithParameters
                                           stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:RealURL];
    
    return request;
}
- (NSString*) paramsForRequestWithDictionary:(NSDictionary*)dict
{
    NSString *ret = @"";
    NSArray *arrKeys = [dict allKeys];
    for (NSString *key in arrKeys)
    {
        NSString *value = [dict objectForKey:key];
        ret = [ret stringByAppendingFormat:@"&%@=%@", key,
               [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return ret;
}

- (void) requestUpdateFrom:(NSString*) strURL success:(void(^)(void))callback
{
    [self requestUpdateFrom:strURL success:callback fail:nil];
}
- (void) requestUpdateFrom:(NSString*) strURL success:(void(^)(void))callback fail:(void(^)(void))finished
{
    NSLog(@"==> UpdateData: Loading content from URL: %@.", strURL);
    
    frCompYes   = callback;
    frCompNo    = finished;
    
    [self loadRequestWithURL:strURL];
}

#pragma mark -
#pragma mark Download Methods

- (void) downloadDataFrom:(NSString*) strURL success:(void(^)(void))callback
{
    [self downloadDataFrom:strURL success:callback fail:nil];
}
- (void) downloadDataFrom:(NSString*) strURL success:(void(^)(void))callback fail:(void(^)(void))finished
{
    NSLog(@"==> UpdateData: Downloading content from URL: %@.", strURL);
    
    NSURL  *url = [NSURL URLWithString:strURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSLog(@"==> UpdateData: Data downloaded successly!");
        
        HTTPData = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        // set json..
        if(HTTPData) [self dataToJSON];
        // call back..
        if(callback)  callback();
    }
    else {
        NSLog(@"==> UpdateData: Data DID NOT downloaded.");
        
        // call back..
        if(finished) finished();
    }
}

#pragma mark -
#pragma mark In Methods

- (void) loadRequestWithURL:(NSString *)urlParam
{
    NSURL *url              = [NSURL URLWithString:urlParam];
    NSMutableURLRequest *req= [[NSMutableURLRequest alloc] initWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:6.0];
    if (POSTData)
    {
        [req setHTTPMethod:@"POST"];
        [req setHTTPBody:[POSTData dataUsingEncoding:NSUTF8StringEncoding]];
		NSLog(@"- [FRTOOLS]: postData: %@", POSTData);
    }
	[NSURLConnection sendAsynchronousRequest:req
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
							   //NSLog(@"- [FRTOOLS]: NSURLResponse: %@", response);
							   // error..
							   if (connectionError){
								   [self errorWithError:connectionError];
								   if (frCompNo)
									   frCompNo();
							   }
							   // data..
							   if (data) {
								   HTTPData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
								   [self dataToJSON];
							   }
							   if (frCompYes)
								   frCompYes();
                           }];
    
    //connection          = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    //[connection start];
}
- (void) dataToJSON
{
    NSError *error;
	NSData *data = [HTTPData dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *JSON = [NSJSONSerialization
						  JSONObjectWithData: data
						  options: NSJSONReadingMutableContainers
						  error: &error];
    
    if(JSON)
    {
        JSONData    = JSON;
        NSLog(@"==> UpdateData: JSON fetched successly!");
    }
    else {
        NSLog(@"==> UpdateData: The results cannot be fetched as JSON (result is nil).");
    }
}
- (void) downloadDataToFile:(NSData *)contentData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"filename.txt"];
    [contentData writeToFile:filePath atomically:YES];
}

/*********************
 * FR > views
 *********************/

#pragma mark -
#pragma mark Methods

- (void) viewWithDropShadow:(UIView*) view
{
    view.layer.shadowOpacity    = 0.75f;
    view.layer.shadowRadius     = 10.0f;
    view.layer.shadowColor      = [UIColor blackColor].CGColor;
}
- (void) touchViewToHideKeyboard: (id) selfselector forView: (UIView*) view withSelector: (SEL)selector
{
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
												 initWithTarget:selfselector
												 action:selector];
	[view addGestureRecognizer:gestureRecognizer];
	gestureRecognizer.cancelsTouchesInView = NO;  // this prevents the gesture recognizers to 'block' touches
}
- (void) listOfFontsAndFamilies
{
    // List all fonts on iPhone
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}

/*********************
 * FR > dialog
 *********************/

@synthesize frdialog;

#pragma mark -
#pragma mark Methods

- (void) dialogWithMessage:(NSString*) message
{
    [self dialogWithMessage:message cancelButton:nil title:nil];
}
- (void) dialogWithMessage:(NSString*) message cancelButton:(NSString*) cancel
{
    [self dialogWithMessage:message cancelButton:cancel title:nil];
}
- (void) dialogWithMessage:(NSString*) message title:(NSString*) title
{
    [self dialogWithMessage:message cancelButton:nil title:title];
}
- (void) dialogWithMessage:(NSString*) message cancelButton:(NSString*) cancel title:(NSString*) title
{
    NSString *buttonLabel;
    if (!cancel)
        buttonLabel = BUTTON_CANCEL;
    else
        buttonLabel = cancel;
    
    frdialog = [[UIAlertView alloc] initWithTitle:title
                                          message:message
                                         delegate:self
                                cancelButtonTitle:buttonLabel
                                otherButtonTitles:nil, nil];
    [frdialog show];
}
- (void) promptWithMessage:(NSString*) message competitionYes:(void(^)(void)) compYes competitionNo:(void(^)(void)) compNo
{
    frCompNo    = compNo;
    frCompYes   = compYes;
    
    frdialog = [[UIAlertView alloc] initWithTitle:nil
                                          message:message
                                         delegate:self
                                cancelButtonTitle:BUTTON_NO
                                otherButtonTitles:BUTTON_YES, nil];
    [frdialog show];
}

/*********************
 * FR > images
 *********************/

#pragma mark -
#pragma mark Upload Methods

- (void) upload:(UIImage*) image
{
    [self upload:image parameters:nil toURL:nil];
}
- (void) upload:(UIImage*) image parameters:(NSArray*) params
{
    [self upload:image parameters:params toURL:nil];
}
- (void) upload:(UIImage*) image parameters:(NSArray*) params toURL:(NSString*) url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSMutableData *body = [NSMutableData data];
    
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    // file
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: attachment; name=\"userfile\"; filename=\"ios.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // params
    for (NSDictionary *dataValues in params)
    {
        NSString *name  = [dataValues objectForKey:@"name"];
        NSString *value = [dataValues objectForKey:@"value"];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", name] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // set request body
    [request setHTTPBody:body];
    
    //return and test
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"returned string: %@", returnString);
}

#pragma mark -
#pragma mark Upload Methods

- (UIImage *) captureScreen
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[keyWindow layer] renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
- (NSData*)   imageFromURL: (NSString*) URLString
{
    NSString *urlStr    = [NSString stringWithString:URLString];
	NSURL *urlObj		= [NSURL URLWithString:urlStr];
	NSData *imgData 	= [NSData dataWithContentsOfURL:urlObj];
	
	return imgData;
}

/*********************
 * FR > validate
 *********************/

#pragma mark -
#pragma mark Methods

- (BOOL) isValidEmail:(NSString*) str
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:str];
}
- (BOOL) isValidCPF:(NSString*) str
{
    NSUInteger i, firstSum, secondSum, firstDigit, secondDigit, firstDigitCheck, secondDigitCheck;
    if(str == nil) return NO;
    
    if ([str length] != 11) return NO;
    
    if (([str isEqual:@"00000000000"])
        || ([str isEqual:@"11111111111"])
        || ([str isEqual:@"22222222222"])
        || ([str isEqual:@"33333333333"])
        || ([str isEqual:@"44444444444"])
        || ([str isEqual:@"55555555555"])
        || ([str isEqual:@"66666666666"])
        || ([str isEqual:@"77777777777"])
        || ([str isEqual:@"88888888888"])
        || ([str isEqual:@"99999999999"])) return NO;
    
    firstSum = 0;
    for (i = 0; i <= 8; i++) {
        firstSum += [[str substringWithRange:NSMakeRange(i, 1)] intValue] * (10 - i);
    }
    
    if (firstSum % 11 < 2)
        firstDigit = 0;
    else
        firstDigit = 11 - (firstSum % 11);
    
    secondSum = 0;
    for (i = 0; i <= 9; i++) {
        secondSum = secondSum + [[str substringWithRange:NSMakeRange(i, 1)] intValue] * (11 - i);
    }
    
    if (secondSum % 11 < 2)
        secondDigit = 0;
    else
        secondDigit = 11 - (secondSum % 11);
    
    firstDigitCheck = [[str substringWithRange:NSMakeRange(9, 1)] intValue];
    secondDigitCheck = [[str substringWithRange:NSMakeRange(10, 1)] intValue];
    
    if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck))
        return YES;
    return NO;
}
- (BOOL) isValidCNPJ:(NSString*) str
{
    NSUInteger i, tamanho, soma, pos, resultado;
    NSString *numeros, *digitos;
    
    if (str == nil) return NO;
    if ([str length] != 14) return NO;
    
    if (([str isEqual:@"00000000000"])
        || ([str isEqual:@"11111111111"])
        || ([str isEqual:@"22222222222"])
        || ([str isEqual:@"33333333333"])
        || ([str isEqual:@"44444444444"])
        || ([str isEqual:@"55555555555"])
        || ([str isEqual:@"66666666666"])
        || ([str isEqual:@"77777777777"])
        || ([str isEqual:@"88888888888"])
        || ([str isEqual:@"99999999999"])) return NO;
    
    // Valida DVs
    tamanho = str.length - 2;
    numeros = [str substringWithRange:NSMakeRange(0, tamanho)];
    digitos = [str substringWithRange:NSMakeRange(tamanho, 2)];
    soma    = 0;
    pos     = tamanho - 7;
    
    for (i = tamanho; i >= 1; i--)
    {
        soma += [numeros characterAtIndex:(tamanho - i)] * pos--;
        if (pos < 2)
            pos = 9;
    }
    
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != [digitos characterAtIndex:0])
        return false;
    
    tamanho = tamanho + 1;
    numeros = [str substringWithRange:NSMakeRange(0, tamanho)];
    soma    = 0;
    pos     = tamanho - 7;
    
    for (i = tamanho; i >= 1; i--)
    {
        soma += [numeros characterAtIndex:(tamanho - i)] * pos--;
        if (pos < 2)
            pos = 9;
    }
    
    resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
    if (resultado != [digitos characterAtIndex:1])
        return false;
    
    return true;
}

/*********************
 * FR > errors
 *********************/

#pragma mark -
#pragma mark Methods

- (void) errorWithData:(NSData*) data withRecipient:(NSString*) recipt
{
    recipt = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
- (id)   errorWithJSON:(NSString*) retData withSelector:(SEL) finishSelector
{
    NSError *error;
	NSData *data = [retData dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *JSON = [NSJSONSerialization
						  JSONObjectWithData: data
						  options: NSJSONReadingMutableContainers
						  error: &error];
    
    return JSON;
}
- (void) errorWithError:(NSError*) error
{
    /*
    //no connection
    if([error code] == -1009)
        NSLog(@"no connection");//[self dialogWithMessage:ERROR_1009_TITLE title:ERROR_1009_MESSAGE];
    // time out
    else if([error code] == -1001)
        [self dialogWithMessage:ERROR_1001_TITLE title:ERROR_1001_MESSAGE];
    // couldn't connect server
    else if([error code] == -1004)
        [self dialogWithMessage:ERROR_1004_TITLE title:ERROR_1004_MESSAGE];
    // other...
    else
    {
        NSLog(@"error %d: %@", error.code, error.localizedDescription);
        [self dialogWithMessage:ERROR_0000_TITLE title:ERROR_0000_MESSAGE];
    }*/
}

#pragma mark -
#pragma mark UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AlertViewOptions opt = buttonIndex;
    switch (opt)
    {
        case kOptionNo:
        {
            if (frCompNo)
                frCompNo();
        }
            break;
        case kOptionYes:
        {
            if (frCompNo)
                frCompYes();
        }
            break;
    }
}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)dData
{
    HTTPData = [[NSString alloc] initWithData:dData encoding:NSUTF8StringEncoding];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self dataToJSON];
    // call back..
    if (frCompYes)
        frCompYes();
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self errorWithError:error];
    // call back..
    if (frCompNo)
        frCompNo();
}

@end
