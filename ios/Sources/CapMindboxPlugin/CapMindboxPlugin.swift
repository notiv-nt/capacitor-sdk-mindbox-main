import Foundation
import Mindbox
import Capacitor

enum CustomError: Error {
    case tokenAPNSisNull
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .tokenAPNSisNull:
            return NSLocalizedString("APNS token cannot be nullable", comment: "APNS token is null")
        }
    }
}



class URLInappDelegate: URLInappMessageDelegate { }

class CopyInappDelegate: CopyInappMessageDelegate { }

class EmptyInappDelegate: InAppMessagesDelegate { }




struct PayloadData: Codable {
    var domain: String
    var endpointId: String
    var subscribeCustomerIfCreated: Bool?
    var shouldCreateCustomer: Bool?
    var previousInstallId: String?
    var previousUuid: String?
}

@objc(CapMindboxPlugin)
public class CapMindboxPlugin: CAPPlugin {

    private var urlInappDelegate: URLInappMessageDelegate?
    private var copyInappDelegate: CopyInappMessageDelegate?
    private var emptyInappDelegate: InAppMessagesDelegate?
    private var customClass: InAppMessagesDelegate?
    private var compositeDelegate: CompositeInappMessageDelegate?

    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "initialize", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getDeviceUUID", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getAPNSToken", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "updateAPNSToken", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "executeAsyncOperation", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "executeSyncOperation", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "registerCallbacks", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setLogLevel", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getSdkVersion", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "pushDelivered", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "updateNotificationPermissionStatus", returnType: CAPPluginReturnPromise),
        
    ]
    private let implementation = CapMindbox()

    /*@objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }*/
    
    
    @objc func initialize(_ call: CAPPluginCall) {
        let domain = call.getString("domain") ?? ""
        let endpointId = call.getString("endpointId") ?? ""
        let previousInstallId = call.getString("previousInstallId") ?? ""
        let previousUuid = call.getString("previousUuid") ?? ""
        let subscribeCustomerIfCreated = call.getBool("subscribeCustomerIfCreated") ?? false
        let shouldCreateCustomer = call.getBool("shouldCreateCustomer") ?? true
        do {
           
            let configuration = try MBConfiguration(
                endpoint: endpointId,
                domain: domain,
                previousInstallationId: previousInstallId,
                previousDeviceUUID: previousUuid,
                subscribeCustomerIfCreated: subscribeCustomerIfCreated,
                shouldCreateCustomer:shouldCreateCustomer
            )

            Mindbox.shared.initialization(configuration: configuration)
            call.resolve()
        } catch {
            call.reject("Error", error.localizedDescription, error)
        }
    }

    @objc func getDeviceUUID(_ call: CAPPluginCall) {
        Mindbox.shared.getDeviceUUID { deviceUUID in
            call.resolve([
                "deviceUUID": deviceUUID
            ])
        }
    }

    @objc func getAPNSToken(_ call: CAPPluginCall) {
        Mindbox.shared.getAPNSToken { Token in
            call.resolve([
                "Token": Token
            ])
        }
    }

    @objc func registerCallbacks(_ call: CAPPluginCall) {
        let callbacks = call.getArray("callbacks", String.self) ?? []
        var cb = [InAppMessagesDelegate]()

        for callback in callbacks {
            switch callback {
            case "urlInAppCallback":
                urlInappDelegate = URLInappDelegate()
                if let urlInappDelegate = urlInappDelegate {
                    cb.append(urlInappDelegate)
                }
            case "copyPayloadInAppCallback":
                copyInappDelegate = CopyInappDelegate()
                if let copyInappDelegate = copyInappDelegate {
                    cb.append(copyInappDelegate)
                }
            case "emptyInAppCallback":
                emptyInappDelegate = EmptyInappDelegate()
                if let emptyInappDelegate = emptyInappDelegate {
                    cb.append(emptyInappDelegate)
                }
            default:
              //  customClass = CustomInappDelegate()
                if let customClass = customClass {
                    cb.append(customClass)
                }
            }
        }

       // compositeDelegate = CompositeInappDelegate()
        compositeDelegate?.delegates = cb
        Mindbox.shared.inAppMessagesDelegate = compositeDelegate
        call.resolve()
    }

    @objc func updateAPNSToken(_ call: CAPPluginCall) {
        let token = call.getString("token") ?? ""
        do {
            guard let tokenData = token.data(using: .utf8) else { throw CustomError.tokenAPNSisNull }

            Mindbox.shared.apnsTokenUpdate(deviceToken: tokenData)
            call.resolve()
        } catch {
            call.reject("Error", error.localizedDescription, error)
        }
    }

    @objc func executeAsyncOperation(_ call: CAPPluginCall) {
        let operationSystemName = call.getString("operationSystemName") ?? ""
        let operationBody = call.getString("operationBody") ?? ""
        Mindbox.shared.executeAsyncOperation(operationSystemName: operationSystemName, json: operationBody)
        call.resolve()
    }

    @objc func executeSyncOperation(_ call: CAPPluginCall) {
        let operationSystemName = call.getString("operationSystemName") ?? ""
        let operationBody = call.getString("operationBody") ?? ""
        Mindbox.shared.executeSyncOperation(operationSystemName: operationSystemName, json: operationBody) { result in
            switch result {
            case .success(let response):
                call.resolve([
                    "response": response.createJSON()
                ])
            case .failure(let error):
                call.resolve([
                    "error": error.createJSON()
                ])
            }
        }
    }

    @objc func setLogLevel(_ call: CAPPluginCall) {
        let level = call.getInt("level") ?? 0
        switch (level) {
        case 0:
            Mindbox.logger.logLevel = .debug
        case 1:
            Mindbox.logger.logLevel = .info
        case 2:
            Mindbox.logger.logLevel = .default
        case 3:
            Mindbox.logger.logLevel = .error
        case 4:
            Mindbox.logger.logLevel = .fault
        default:
            Mindbox.logger.logLevel = .none
        }
        call.resolve()
    }

    @objc func getSdkVersion(_ call: CAPPluginCall) {
        call.resolve([
            "sdkVersion": Mindbox.shared.sdkVersion
        ])
    }

    @objc func pushDelivered(_ call: CAPPluginCall) {
        let uniqKey = call.getString("uniqKey") ?? ""
        Mindbox.shared.pushDelivered(uniqueKey: uniqKey)
        call.resolve()
    }

    @objc func updateNotificationPermissionStatus(_ call: CAPPluginCall) {
        let granted = call.getBool("granted") ?? false
        Mindbox.shared.notificationsRequestAuthorization(granted: granted)
        call.resolve()
    }
}
