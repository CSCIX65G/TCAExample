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

// MARK: AppState
public struct AppState: Equatable {
    var title: String = ""
    var navigations: [NavigationState] = ["Nav 1", "Nav 2", "Nav 3", "Nav 4", "Nav 5"]
        .enumerated()
        .map(NavigationState.init)
}

public extension AppState {
    enum Action: Equatable {
        case navigationAction(index: Int, action: NavigationState.Action)
    }
}

public struct AppEnvironment {
    public init() { }
}

// MARK: NavigationState
public struct NavigationState {
    var index: Int
    var title: String
}

extension NavigationState: Equatable, Identifiable {
    public var id: Int { index }
}

public extension NavigationState {
    enum Action: Equatable {
        case setTitle(String)
    }
}

public struct NavigationEnvironment {
    public init() { }
}

// How do I pullback the navigation reducer?
public let navigationReducer = Reducer<NavigationState, NavigationState.Action, NavigationEnvironment> { state, action, _ in
    switch action {
        case .setTitle(let string):
            return .none
    }
}

let reducer = Reducer<AppState, AppState.Action, AppEnvironment> { state, action, _ in
    switch action {
        case .navigationAction(index: _, action: let action):
            switch action {
                case .setTitle(let title):
                    state.title = title
            }
            return .none
    }
}.debug()


