'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

exports.LogLevel = void 0;
(function (LogLevel) {
    LogLevel[LogLevel["VERBOSE"] = 0] = "VERBOSE";
    LogLevel[LogLevel["DEBUG"] = 1] = "DEBUG";
    LogLevel[LogLevel["INFO"] = 2] = "INFO";
    LogLevel[LogLevel["WARN"] = 3] = "WARN";
    LogLevel[LogLevel["ERROR"] = 4] = "ERROR";
    LogLevel[LogLevel["NONE"] = 5] = "NONE";
})(exports.LogLevel || (exports.LogLevel = {}));

const CapMindbox = core.registerPlugin('CapMindbox', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.CapMindboxWeb()),
});

class CapMindboxWeb extends core.WebPlugin {
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

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    CapMindboxWeb: CapMindboxWeb
});

exports.CapMindbox = CapMindbox;
//# sourceMappingURL=plugin.cjs.js.map
