import { WebPlugin } from '@capacitor/core';
export class CapMindboxWeb extends WebPlugin {
    async echo(options) {
        console.log('ECHO', options);
        return options;
    }
    async initialize(options) {
        console.log('Initialize', options);
    }
    async getDeviceUUID() {
        console.log('getDeviceUUID');
        return { deviceUUID: 'mock-device-uuid' };
    }
    async getAPNSToken() {
        console.log('getAPNSToken');
        return { token: 'mock-token' };
    }
    async updateToken(options) {
        console.log('updateToken', options);
    }
    async registerInAppCallbacks(callbacks) {
        console.log('registerInAppCallbacks', callbacks);
    }
    async executeAsyncOperation(options) {
        console.log('executeAsyncOperation', options);
    }
    async executeSyncOperation(options) {
        console.log('executeSyncOperation', options);
        return { data: 'mock-data' };
    }
    async setLogLevel(options) {
        console.log('setLogLevel', options);
    }
    async getSdkVersion() {
        console.log('getSdkVersion');
        return { sdkVersion: 'mock-sdk-version' };
    }
    async pushDelivered(options) {
        console.log('pushDelivered', options);
    }
    async updateNotificationPermissionStatus(options) {
        console.log('updateNotificationPermissionStatus', options);
    }
}
//# sourceMappingURL=web.js.map