//
//  NavigationAction.swift
//  Meet
//
//  Created by Benjamin Encz on 11/27/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import ReSwift

/// Exports the type map needed for using ReSwiftRouter with a Recording Store
public let typeMap: [String: StandardActionConvertible.Type] =
    ["RE_SWIFT_ROUTER_ACTION": RoutingAction.self]

public enum RoutingAction {
    case set(new: Route, animated: Bool)
    case setData(Data, forRoute: Route)
    
    case show(newElement: RouteElementIdentifier, animated: Bool)
    case replace(with: RouteElementIdentifier, animated: Bool)
    
    case back(animated: Bool)
    case backTo(RouteElementIdentifier, animated: Bool)
}

extension RoutingAction: StandardActionConvertible {
    public static let type = "RE_SWIFT_ROUTER_ACTION"
    
    public init(_ action: StandardAction) {
        guard let payload = action.payload, let type = payload["type"] as? String else {
            fatalError()
        }
        
        let route = payload["route"] as? Route ?? []
        let animated = payload["animated"] as? Bool ?? true
        let data = payload["data"] as? Data ?? Data()
        let element = payload["element"] as? RouteElementIdentifier ?? "UNKNOWN"
        
        switch type {
        case "set":
            self = .set(new: route, animated: animated)
        case "setData":
            self = .setData(data, forRoute: route)
        case "show":
            self = .show(newElement: element, animated: animated)
        case "replace":
            self = .replace(with: element, animated: animated)
        case "back":
            self = .back(animated: animated)
        case "backTo":
            self = .backTo(element, animated: animated)
        default:
            fatalError("Unknown type of \(RoutingAction.type)")
        }
    }
    
    public func toStandardAction() -> StandardAction {
        let payload: [String: AnyObject]
        switch self {
        case let .set(new: route, animated: animated):
            payload = ["type": "set" as AnyObject, "route": route as AnyObject, "animated": animated as AnyObject]
        case let .setData(data, route):
            payload = ["type": "setData" as AnyObject, "route": route as AnyObject, "data": data as AnyObject]
        case let .show(newElement: element, animated: animated):
            payload = ["type": "show" as AnyObject, "element": element as AnyObject, "animated": animated as AnyObject]
        case let .replace(with: element, animated: animated):
            payload = ["type": "replace" as AnyObject, "element": element as AnyObject, "animated": animated as AnyObject]
        case let .back(animated: animated):
            payload = ["type": "back" as AnyObject, "animated": animated as AnyObject]
        case let .backTo(element, animated: animated):
            payload = ["type": "backTo" as AnyObject, "element": element as AnyObject, "animated": animated as AnyObject]
        }
        return StandardAction(type: RoutingAction.type, payload: payload, isTypedAction: true)
    }
}
