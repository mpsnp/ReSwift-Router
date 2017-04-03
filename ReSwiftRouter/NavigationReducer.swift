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
        let state = state ?? NavigationState()
        
        switch action {
        case let action as SetRouteAction:
            return setRoute(state, action: action)
        case let action as SetRouteSpecificData:
            return setRouteSpecificData(state, route: action.route, data: action.data)
        case let action as Show:
            return show(state, action: action)
        case let action as Back:
            return back(state, action: action)
        case let action as Unwind:
            return unwind(state, action: action)
        default:
            break
        }
        
        return state
    }
    
    public func handleAction(action: Action, state: NavigationState?) -> NavigationState {
        return NavigationReducer.handleAction(action: action, state: state)
    }

    static func setRoute(_ state: NavigationState, action: SetRouteAction) -> NavigationState {
        var state = state

        state.route = action.route
        state.changeRouteAnimated = action.animated

        return state
    }
    
    static func show(_ state: NavigationState, action: Show) -> NavigationState {
        var state = state
        
        state.route.append(action.routeElement)
        state.changeRouteAnimated = action.animated
        
        return state
    }
    
    static func back(_ state: NavigationState, action: Back) -> NavigationState {
        var state = state

        state.route.removeLast()
        state.changeRouteAnimated = action.animated
        
        return state
    }
    
    static func unwind(_ state: NavigationState, action: Unwind) -> NavigationState {
        var state = state
        
        if let indexOfLast: Int = state.route.reversed().index(of: action.targetElement) {
            state.route = Array(state.route.prefix(through: indexOfLast))
        }
        state.changeRouteAnimated = action.animated
        
        return state
    }

    static func setRouteSpecificData(
        _ state: NavigationState,
        route: Route,
        data: Any) -> NavigationState {
            let routeHash = RouteHash(route: route)

            var state = state

            state.routeSpecificState[routeHash] = data

            return state
    }

}
