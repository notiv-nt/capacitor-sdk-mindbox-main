# capacitor-mindbox-sdk

Mindbox SDK

## Install

```bash
npm install capacitor-mindbox-sdk
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`initialize(...)`](#initialize)
* [`getDeviceUUID()`](#getdeviceuuid)
* [`getToken()`](#gettoken)
* [`updateToken(...)`](#updatetoken)
* [`registerInAppCallbacks(...)`](#registerinappcallbacks)
* [`executeAsyncOperation(...)`](#executeasyncoperation)
* [`executeSyncOperation(...)`](#executesyncoperation)
* [`setLogLevel(...)`](#setloglevel)
* [`getSdkVersion()`](#getsdkversion)
* [`pushDelivered(...)`](#pushdelivered)
* [`updateNotificationPermissionStatus(...)`](#updatenotificationpermissionstatus)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### initialize(...)

```typescript
initialize(options: InitializationData) => Promise<void>
```

| Param         | Type                                                              |
| ------------- | ----------------------------------------------------------------- |
| **`options`** | <code><a href="#initializationdata">InitializationData</a></code> |

--------------------


### getDeviceUUID()

```typescript
getDeviceUUID() => Promise<{ deviceUUID: string; }>
```

**Returns:** <code>Promise&lt;{ deviceUUID: string; }&gt;</code>

--------------------


### getToken()

```typescript
getToken() => Promise<{ token: string; }>
```

**Returns:** <code>Promise&lt;{ token: string; }&gt;</code>

--------------------


### updateToken(...)

```typescript
updateToken(options: { token: string; }) => Promise<void>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ token: string; }</code> |

--------------------


### registerInAppCallbacks(...)

```typescript
registerInAppCallbacks(callbacks: InAppCallback[]) => Promise<void>
```

| Param           | Type                         |
| --------------- | ---------------------------- |
| **`callbacks`** | <code>InAppCallback[]</code> |

--------------------


### executeAsyncOperation(...)

```typescript
executeAsyncOperation(options: ExecuteAsyncOperationPayload) => Promise<void>
```

| Param         | Type                                                                                  |
| ------------- | ------------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#executeasyncoperationpayload">ExecuteAsyncOperationPayload</a></code> |

--------------------


### executeSyncOperation(...)

```typescript
executeSyncOperation(options: ExecuteSyncOperationPayload) => Promise<any>
```

| Param         | Type                                                                                |
| ------------- | ----------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#executesyncoperationpayload">ExecuteSyncOperationPayload</a></code> |

**Returns:** <code>Promise&lt;any&gt;</code>

--------------------


### setLogLevel(...)

```typescript
setLogLevel(options: { level: number; }) => Promise<void>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ level: number; }</code> |

--------------------


### getSdkVersion()

```typescript
getSdkVersion() => Promise<{ sdkVersion: string; }>
```

**Returns:** <code>Promise&lt;{ sdkVersion: string; }&gt;</code>

--------------------


### pushDelivered(...)

```typescript
pushDelivered(options: { uniqKey: string; }) => Promise<void>
```

| Param         | Type                              |
| ------------- | --------------------------------- |
| **`options`** | <code>{ uniqKey: string; }</code> |

--------------------


### updateNotificationPermissionStatus(...)

```typescript
updateNotificationPermissionStatus(options: { granted: boolean; }) => Promise<void>
```

| Param         | Type                               |
| ------------- | ---------------------------------- |
| **`options`** | <code>{ granted: boolean; }</code> |

--------------------


### Interfaces


#### InitializationData

| Prop                             | Type                 |
| -------------------------------- | -------------------- |
| **`domain`**                     | <code>string</code>  |
| **`endpointId`**                 | <code>string</code>  |
| **`subscribeCustomerIfCreated`** | <code>boolean</code> |
| **`shouldCreateCustomer`**       | <code>boolean</code> |
| **`previousInstallId`**          | <code>string</code>  |
| **`previousUuid`**               | <code>string</code>  |


#### InAppCallback

| Method               | Signature                                                     |
| -------------------- | ------------------------------------------------------------- |
| **getName**          | () =&gt; string                                               |
| **onInAppClick**     | (id: string, redirectUrl: string, payload: string) =&gt; void |
| **onInAppDismissed** | (id: string) =&gt; void                                       |


#### ExecuteAsyncOperationPayload

| Prop                      | Type                |
| ------------------------- | ------------------- |
| **`operationSystemName`** | <code>string</code> |
| **`operationBody`**       | <code>any</code>    |


#### ExecuteSyncOperationPayload

| Prop                      | Type                                   |
| ------------------------- | -------------------------------------- |
| **`operationSystemName`** | <code>string</code>                    |
| **`operationBody`**       | <code>any</code>                       |
| **`onSuccess`**           | <code>(data: any) =&gt; void</code>    |
| **`onError`**             | <code>((error: any) =&gt; void)</code> |

</docgen-api>
