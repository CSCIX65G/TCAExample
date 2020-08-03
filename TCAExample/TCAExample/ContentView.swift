//
//  ContentView.swift
//  TCAExample
//
//  Created by Van Simmons on 7/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI
import Foundation
import ComposableArchitecture

struct ContentView: View {
    var store: Store<AppState, AppState.Action>
    @ObservedObject var viewStore: ViewStore<AppState, AppState.Action>

    init(store: Store<AppState, AppState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }

    var body: some View {
        TabView(selection: viewStore.binding(
            get: \.selectedTab,
            send: AppState.Action.setSelectedTab(tab:)
        )) {
            Tab1View(
                store: self.store.scope(
                    state: \.tab1State,
                    action: AppState.Action.tab1Action(action:)
                )
            )
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
            }
            .tag(AppState.Tab.one)

            Tab2View(
                store: self.store.scope(
                    state: \.tab2State,
                    action: AppState.Action.tab2Action(action:)
                )
            )
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
                    }
            }
            .tag(AppState.Tab.two)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: AppState(),
                reducer: contentReducer,
                environment: AppEnvironment()
            )
        )
    }
}
