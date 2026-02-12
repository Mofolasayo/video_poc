#import "FlutterZoomVideoSdkAnnotationHelper.h"
#import "FlutterZoomVideoSdkUser.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkAnnotationHelper

ZoomVideoSDKAnnotationHelper *annotationHelper;

- (ZoomVideoSDKAnnotationHelper *)getAnnotationHelper
{
    @try {
        if (annotationHelper == nil) {
            NSException *e = [NSException exceptionWithName:@"NoAnnotationHelperFound" reason:@"No Annotation Helper Found" userInfo:nil];
            @throw e;
        }
    } @catch (NSException *e) {
        NSLog(@"%@ - %@", e.name, e.reason);
    }
    return annotationHelper;
}

- (void) setAnnotationHelper: (ZoomVideoSDKAnnotationHelper*) helper {
    if (annotationHelper == nil) {
        annotationHelper = helper;
    }
}

- (NSString *) hexStringFromColor:(UIColor *)color {
    if (color == nil) return @"null";

    const CGFloat *components = CGColorGetComponents(color.CGColor);

    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];

    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

- (UIColor *) colorWithHexString: (NSString *) hexString {
    if (hexString == nil | hexString.length < 1) {
        NSException *e = [NSException exceptionWithName:@"Invalid color value" reason:@"Color value is invalid.  It should be a hex value of the form #RGB, #ARGB, #RRGGBB, or #AARRGGBB" userInfo:nil];
        @throw e;
    }
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

-(void) isSenderDisableAnnotation: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getAnnotationHelper] isSenderDisableAnnotation]));
    });
}

-(void) canDoAnnotation: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getAnnotationHelper] canDoAnnotation]));
    });
}

-(void) startAnnotation: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAnnotationHelper] startAnnotation])]);
    });
}

-(void) stopAnnotation: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAnnotationHelper] stopAnnotation])]);
    });
}

-(void) setToolColor:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* toolColor = call.arguments[@"toolColor"];
    if ([toolColor length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"toolColor is empty"
                                   details:nil]);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAnnotationHelper] setToolColor:[self colorWithHexString:toolColor]])]);
    });
}

-(void) getToolColor: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIColor* color = [[self getAnnotationHelper] getToolColor];
        if (color == nil) {
            result(@"null");
        } else {
            result([self hexStringFromColor:[[self getAnnotationHelper] getToolColor]]);
            
        }
    });
}

-(void) setToolType:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* toolType = call.arguments[@"toolType"];
    if ([toolType length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"toolType is empty"
                                   details:nil]);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAnnotationHelper] setToolType:[JSONConvert ZoomVideoSDKAnnotationToolType:toolType]])]);
    });
}

-(void) getToolType: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKAnnotationToolTypeValuesReversed] objectForKey: @([[self getAnnotationHelper] getToolType])]);
    });
}

-(void) setToolWidth:(FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSUInteger width = (NSUInteger)call.arguments[@"width"];
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAnnotationHelper] setToolWidth:width])]);
    });
}

-(void) getToolWidth: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result(@([[self getAnnotationHelper] getToolWidth]));
    });
}

-(void) undo: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAnnotationHelper] undo])]);
    });
}

-(void) redo: (FlutterResult) result {
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAnnotationHelper] redo])]);
    });
}

-(void) clear: (FlutterMethodCall *)call withResult:(FlutterResult) result {
    NSString* clearType = call.arguments[@"clearType"];
    if ([clearType length] == 0) {
        result([FlutterError errorWithCode:[[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @(Errors_Invalid_Parameter)]
                                   message:@"clearType is empty"
                                   details:nil]);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        result([[JSONConvert ZoomVideoSDKErrorValuesReversed] objectForKey: @([[self getAnnotationHelper] clear:[JSONConvert ZoomVideoSDKAnnotationClearType:clearType]])]);
    });
}


@end
