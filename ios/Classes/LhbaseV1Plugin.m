#import "LhbaseV1Plugin.h"
#if __has_include(<lhbase_v1/lhbase_v1-Swift.h>)
#import <lhbase_v1/lhbase_v1-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lhbase_v1-Swift.h"
#endif

@implementation LhbaseV1Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLhbaseV1Plugin registerWithRegistrar:registrar];
}
@end
