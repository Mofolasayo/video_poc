#import "FlutterZoomVideoSdkVirtualBackgroundItem.h"
#import "JSONConvert.h"

@implementation FlutterZoomVideoSdkVirtualBackgroundItem

+ (NSString *)mapVBItem: (ZoomVideoSDKVirtualBackgroundItem *)item {
    @try {
        NSMutableDictionary *mappedVBItem = [[NSMutableDictionary alloc] init];
        if (item == nil) {
            return [JSONConvert NSDictionaryToNSString: mappedVBItem];
        }
        NSDictionary *itemData = @{
                @"filePath": [item imageFilePath],
                @"imageName": [item imageName],
                @"type": [[JSONConvert ZoomVideoSDKVirtualBackgroundDataTypeValuesReversed] objectForKey: @([item type])],
                @"canBeDeleted": @([item canVirtualBackgroundBeDeleted]),
        };
        [mappedVBItem setDictionary:itemData];
        return [JSONConvert NSDictionaryToNSString: mappedVBItem];
    }
    @catch (NSException *e) {
        return @{};
    }
}

+ (NSString *)mapItemArray: (NSArray <ZoomVideoSDKVirtualBackgroundItem*> *)itemArray {
    NSMutableArray *mappedItemArray = [NSMutableArray array];
    if (itemArray == nil) {
        return [JSONConvert NSMutableArrayToNSString: mappedItemArray];
    }
    @try {
        [itemArray enumerateObjectsUsingBlock:^(ZoomVideoSDKVirtualBackgroundItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
            [mappedItemArray addObject: [self mapVBItem: item]];
        }];
    }
    @finally {
        return [JSONConvert NSMutableArrayToNSString: mappedItemArray];
    }
}

@end
