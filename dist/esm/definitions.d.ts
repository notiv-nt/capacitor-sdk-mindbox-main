export interface InitializationData {
    domain: string;
    endpointId: string;
    subscribeCustomerIfCreated?: boolean;
    shouldCreateCustomer?: boolean;
    previousInstallId?: string;
    previousUuid?: string;
}
export interface ExecuteAsyncOperationPayload {
    operationSystemName: string;
    operationBody: any;
}
export interface ExecuteSyncOperationPayload {
    operationSystemName: string;
    operationBody: any;
    onSuccess: (data: any) => void;
    onError?: (error: any) => void;
}
export interface InAppCallback {
    getName(): string;
    onInAppClick(id: string, redirectUrl: string, payload: string): void;
    onInAppDismissed(id: string): void;
}
export interface CapMindboxPlugin {
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
export declare enum LogLevel {
    VERBOSE = 0,
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4,
    NONE = 5
}
