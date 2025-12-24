#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

CAP_PLUGIN(CapMindboxPlugin, "CapMindbox",

           CAP_PLUGIN_METHOD(initialize, CAPPluginReturnPromise);
               CAP_PLUGIN_METHOD(getDeviceUUID, CAPPluginReturnPromise);
               CAP_PLUGIN_METHOD(getAPNSToken, CAPPluginReturnPromise);
               CAP_PLUGIN_METHOD(updateAPNSToken, CAPPluginReturnPromise);
               CAP_PLUGIN_METHOD(executeAsyncOperation, CAPPluginReturnPromise);
               CAP_PLUGIN_METHOD(executeSyncOperation, CAPPluginReturnPromise);
               CAP_PLUGIN_METHOD(registerCallbacks, CAPPluginReturnPromise);
               CAP_PLUGIN_METHOD(setLogLevel, CAPPluginReturnPromise);
               CAP_PLUGIN_METHOD(getSdkVersion, CAPPluginReturnPromise);
               CAP_PLUGIN_METHOD(pushDelivered, CAPPluginReturnPromise);
               CAP_PLUGIN_METHOD(updateNotificationPermissionStatus, CAPPluginReturnPromise);
           
)
