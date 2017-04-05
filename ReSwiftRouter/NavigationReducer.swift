//
//  NavigationReducer.swift
//  Meet
//
//  Created by Benjamin Encz on 11/11/15.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import ReSwift

/** 
 The Navigation Reducer handles the state slice concerned with storing the current navigation
 information. Note, that this reducer is **not** a *top-level* reducer, you need to use it within
 another reducer and pass in the relevant state slice. Take a look at the specs to see an
 example set up. 
 */
public struct NavigationReducer: Reducer {

    public static func handleAction(action: Action, state: NavigationState?) -> NavigationState {
        var state = state ?? NavigationState()
        
        switch action {
        case let RoutingAction.set(new: route, animated: animated):
            state.route = route
            state.changeRouteAnimated = animated
        case let RoutingAction.setData(data, forRoute: route):
            let routeHash = RouteHash(route: route)
            state.routeSpecificState[routeHash] = data
        case let RoutingAction.show(newElement: element, animated: animated):
            state.route.append(element)
            state.changeRouteAnimated = animated
        case let RoutingAction.replace(with: element, animated: animated):
            state.route[state.route.endIndex - 1] = element
            state.changeRouteAnimated = animated
        case let RoutingAction.back(animated: animated):
            state.route.removeLast()
            state.changeRouteAnimated = animated
        case let RoutingAction.backTo(element, animated: animated):
            guard let indexOfLast: Int = state.route.reversed().index(of: element) else {
                break
            }
            let realIndex = state.route.endIndex - indexOfLast
            state.route = Array(state.route.prefix(upTo: realIndex))
            state.changeRouteAnimated = animated
        default:
            break
        }
        
        return state
    }
    
    public func handleAction(action: Action, state: NavigationState?) -> NavigationState {
        return NavigationReducer.handleAction(action: action, state: state)
    }
}
