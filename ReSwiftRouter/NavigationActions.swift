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
    ["RE_SWIFT_ROUTER_SET_ROUTE": SetRouteAction.self]

public struct SetRouteAction: StandardActionConvertible {

    let route: Route
    let animated: Bool
    public static let type = "RE_SWIFT_ROUTER_SET_ROUTE"

    public init (_ route: Route, animated: Bool = true) {
        self.route = route
        self.animated = animated
    }

    public init(_ action: StandardAction) {
        self.route = action.payload!["route"] as! Route
        self.animated = action.payload!["animated"] as! Bool
    }

    public func toStandardAction() -> StandardAction {
        return StandardAction(
            type: SetRouteAction.type,
            payload: ["route": route as AnyObject, "animated": animated as AnyObject],
            isTypedAction: true
        )
    }
}

public struct Show: StandardActionConvertible {
    let routeElement: RouteElementIdentifier
    let animated: Bool
    public static let type = "RE_SWIFT_ROUTER_SHOW"
    
    public init(_ element: RouteElementIdentifier, animated: Bool = true) {
        self.routeElement = element
        self.animated = animated
    }
    
    public init(_ standardAction: StandardAction) {
        self.routeElement = standardAction.payload!["routeElement"] as! RouteElementIdentifier
        self.animated = standardAction.payload!["animated"] as! Bool
    }
    
    public func toStandardAction() -> StandardAction {
        return StandardAction(
            type: Show.type,
            payload: ["routeElement": routeElement as AnyObject, "animated": animated as AnyObject],
            isTypedAction: true
        )
    }
}

public struct Back: StandardActionConvertible {
    let animated: Bool
    public static let type = "RE_SWIFT_ROUTER_BACK"
    
    public init(animated: Bool = true) {
        self.animated = animated
    }
    
    public init(_ standardAction: StandardAction) {
        self.animated = standardAction.payload!["animated"] as! Bool
    }
    
    public func toStandardAction() -> StandardAction {
        return StandardAction(
            type: Back.type,
            payload: ["animated": animated as AnyObject],
            isTypedAction: true
        )
    }
}

public struct Unwind: StandardActionConvertible {
    let targetElement: RouteElementIdentifier
    let animated: Bool
    public static let type = "RE_SWIFT_ROUTER_UNWIND"
    
    public init(to element: RouteElementIdentifier, animated: Bool = true) {
        self.targetElement = element
        self.animated = animated
    }
    
    public init(_ standardAction: StandardAction) {
        self.targetElement = standardAction.payload!["targetElement"] as! RouteElementIdentifier
        self.animated = standardAction.payload!["animated"] as! Bool
    }
    
    public func toStandardAction() -> StandardAction {
        return StandardAction(
            type: Unwind.type,
            payload: ["targetElement": targetElement as AnyObject, "animated": animated as AnyObject],
            isTypedAction: true
        )
    }
}

public struct SetRouteSpecificData: Action {
    let route: Route
    let data: Any

    public init(route: Route, data: Any) {
        self.route = route
        self.data = data
    }
}
