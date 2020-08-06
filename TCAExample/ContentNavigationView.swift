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
    var store: Store<NavState, NavState.Action>
    @ObservedObject var viewStore: ViewStore<NavState, NavState.Action>

    init(store: Store<NavState, NavState.Action>) {
        self.store = store
        viewStore = ViewStore(store, removeDuplicates: ==)
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationLink(destination: self.linkView) {
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
            Spacer()
            Text(viewStore.title)
                .font(.largeTitle)
                .padding(.bottom, 12.0)
            
            HStack {
                Button(action: {
                    self.viewStore.send(.setTitle(self.viewStore.title))
                }) {
                    Text("Set")
                }
                .font(.title)

                Divider()
                    .padding(12.0)

                Button(action: {
                    self.viewStore.send(.setTitle(""))
                }) {
                    Text("Clear")
                }
                .font(.title)
            }
            .frame(height: 30.0)
            
            Spacer()
        }
        .onAppear {
            self.viewStore.send(.setSelectedRow(self.viewStore.index))
        }
    }
}

struct Navigation_Previews: PreviewProvider {
    static let navReducer = Reducer<NavState, NavState.Action, Environment> { state, action, _ in
        switch action {
            case .setTitle:
                return .none
            case .setSelectedRow:
                return .none
        }
    }

    static var previews: some View {
        ContentNavigationView(
            store: Store<NavState, NavState.Action>(
                initialState: NavState(index: 0, title: "Tab 2"),
                reducer: navReducer,
                environment: Environment()
            )
        )
    }
}
