//
//  Navigation.swift
//  TCAExample
//
//  Created by Van Simmons on 8/2/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ContentNavigationView: View {
    var store: Store<NavigationState, NavigationState.Action>
    @ObservedObject var viewStore: ViewStore<NavigationState, NavigationState.Action>

    init(store: Store<NavigationState, NavigationState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store, removeDuplicates: ==)
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationLink(
                destination: self.linkView
            ) {
                VStack {
                    HStack {
                        Text("\(viewStore.title)")
                            .font(.system(size: 24.0))
                            .padding([.top, .bottom], 8.0)
                            .padding(.leading, 24.0)
                    }
                }
            }
        }
    }

    var linkView: some View {
        VStack {
            Text(viewStore.title)
            Button(action: {
                self.viewStore.send(.setTitle(self.viewStore.title))
            }) {
                Text("Set the Global Value")
            }
        }
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        ContentNavigationView(
            store: Store<NavigationState, NavigationState.Action>(
                initialState: NavigationState(index: 0, title: "Tab 2"),
                reducer: navigationReducer,
                environment: NavigationEnvironment()
            )
        )
    }
}
