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

public enum Tab: Equatable {
    case one
    case two
}

// MARK: AppState
public struct AppState: Equatable {
    var selectedTab = Tab.one
    var tab1State = Tab1State()
    var tab2State = Tab2State()
}

public extension AppState {
    enum Action: Equatable {
        case setSelectedTab(tab: Tab)
        case tab1Action(action: Tab1State.Action)
        case tab2Action(action: Tab2State.Action)
    }
}

public struct AppEnvironment {
    public init() { }
}

let crossReducer = Reducer<AppState, Tab1State.Action, AppEnvironment> { state, action, _ in
    switch action {
        case .tab1NavigationAction(index: _, action: let action):
            switch action {
                case .setTab2Title(let title):
                    state.tab2State.title = title
            }
            return .none
    }
}

let contentReducer = Reducer<AppState, AppState.Action, AppEnvironment> { state, action, _ in
    switch action {
        case let .setSelectedTab(tab: t):
            state.selectedTab = t
            return .none
        case .tab1Action(action: let action):
            return .none
        case .tab2Action(action: let action):
            return .none
    }
}

public func identity<T>(_ t: T) -> T { t }

let totalReducer = Reducer<AppState, AppState.Action, AppEnvironment>.combine(
    crossReducer.pullback(
        state: \.self,
        action: /AppState.Action.tab1Action(action:),
        environment: identity
    ),
    contentReducer
).debug()

// MARK: Tab1State
public struct Tab1State: Equatable {
    var tab1Navigations: [Tab1NavigationState] = ["Nav 1", "Nav 2", "Nav 3", "Nav 4", "Nav 5"]
        .enumerated()
        .map(Tab1NavigationState.init)
}

public extension Tab1State {
    enum Action: Equatable {
        case tab1NavigationAction(index: Int, action: Tab1NavigationState.Action)
    }
}

public struct Tab1Environment {
    public init() { }
}

public let tab1Reducer = Reducer<Tab1State, Tab1State.Action, Tab1Environment> { state, action, _ in
    switch action {
        case .tab1NavigationAction(index: let index, action: let navAction):
            return .none
    }
}

// MARK: Tab1NavigationState
public struct Tab1NavigationState {
    var index: Int
    var title: String
}

extension Tab1NavigationState: Equatable, Identifiable {
    public var id: Int { index }
}

public extension Tab1NavigationState {
    enum Action: Equatable {
        case setTab2Title(String)
    }
}

public struct Tab1NavigationEnvironment {
    public init() { }
}

public let tab1NavigationReducer = Reducer<Tab1NavigationState, Tab1NavigationState.Action, Tab1NavigationEnvironment> { state, action, _ in
    switch action {
        case .setTab2Title(let string):
            return .none
    }
}

// MARK: Tab2State
public struct Tab2State: Equatable {
    var title: String = ""
}

public extension Tab2State {
    enum Action: Equatable {
        case setTitle(String)
    }
}

public struct Tab2Environment {
    public init() { }
}

public let tab2Reducer = Reducer<Tab2State, Tab2State.Action, Tab2Environment> { state, action, _ in
    switch action {
        case .setTitle(let title):
            state.title = title
            return .none
    }
}
