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
        NavigationView {
            VStack {
                List {
                    ForEachStore(
                        self.store.scope(
                            state: \.navigations,
                            action: AppState.Action.navigationAction(index:action:)
                        ),
                        content: ContentNavigationView.init(store:)
                    )
                }
                .onAppear {
                    self.viewStore.send(.setSelectedRow(.none))
                }
                Spacer()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("Nav State \(viewStore.globalTitle == "" ? "" : "- " + viewStore.globalTitle)")
            .navigationBarHidden(false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialState: AppState(),
                reducer: appReducer,
                environment: Environment()
            )
        )
    }
}
