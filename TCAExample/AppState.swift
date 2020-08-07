//
//  AppState.swift
//  TCAExample
//
//  Created by Van Simmons on 8/2/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI
import Foundation
import ComposableArchitecture

public struct Environment {
    public init() { }
}


//======================================
// MARK: AppState
//======================================
public struct AppState: Equatable {
    var selectedRow: Int? = .none
    var globalTitle: String = ""
    var navigations: [NavState] = ["Nav 1", "Nav 2", "Nav 3"]
        .enumerated()
        .map(NavState.init)
}

public extension AppState {
    enum Action: Equatable {
        case setSelectedRow(Int?)
        case navigationAction(index: Int, action: NavState.Action)
    }
}

//======================================
// MARK: NavigationState
//======================================
public struct NavState: Equatable {
    var index: Int
    var localTitle: String
}

extension NavState: Identifiable {
    public var id: Int { index }
}

public extension NavState {
    enum Action: Equatable {
        case setGlobalTitle(String)
        case setSelectedRow(Int?)
    }
}

//======================================
// MARK: Reducers
//======================================

let appReducer = Reducer<AppState, AppState.Action, Environment> { state, action, _ in
    switch action {
        case .navigationAction(index: _, action: let action):
            switch action {
                case .setGlobalTitle(let title):
                    state.globalTitle = title
                case .setSelectedRow(let row):
                    state.selectedRow = row
            }
            return .none
        case .setSelectedRow:
            state.selectedRow = .none
            return .none
    }
}.debug()

// How do I pullback this reducer?
public let navReducer = Reducer<AppState, NavState.Action, Environment> { state, action, _ in
    switch action {
        case .setGlobalTitle(let title):
            state.globalTitle = title
            return .none
        case .setSelectedRow(let row):
            state.selectedRow = row
            return .none
    }
}

//public func identity<T>(_ t: T) -> T { t }
//let reducerToCombine = Reducer<AppState, NavState.Action, AppEnvironment>.combine(
//    topNavReducer.pullback(
//        state: \.self,
//        action: /AppState.Action.curriedNavigation(self.selectedRow),
//        environment: identity
//    )
//)
