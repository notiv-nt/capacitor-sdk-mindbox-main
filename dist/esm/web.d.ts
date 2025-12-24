import { WebPlugin } from '@capacitor/core';
import type { CapMindboxPlugin, InitializationData, ExecuteSyncOperationPayload, ExecuteAsyncOperationPayload, InAppCallback } from './definitions';
export declare class CapMindboxWeb extends WebPlugin implements CapMindboxPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    initialize(options: InitializationData): Promise<void>;
    getDeviceUUID(): Promise<{
        deviceUUID: string;
    }>;
    getAPNSToken(): Promise<{
        token: string;
    }>;
    updateToken(options: {
        token: string;
    }): Promise<void>;
    registerInAppCallbacks(callbacks: InAppCallback[]): Promise<void>;
    executeAsyncOperation(options: ExecuteAsyncOperationPayload): Promise<void>;
    executeSyncOperation(options: ExecuteSyncOperationPayload): Promise<any>;
    setLogLevel(options: {
        level: number;
    }): Promise<void>;
    getSdkVersion(): Promise<{
        sdkVersion: string;
    }>;
    pushDelivered(options: {
        uniqKey: string;
    }): Promise<void>;
    updateNotificationPermissionStatus(options: {
        granted: boolean;
    }): Promise<void>;
}
