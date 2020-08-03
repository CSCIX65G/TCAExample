//
//  Tab1Navigation.swift
//  TCAExample
//
//  Created by Van Simmons on 8/2/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct Tab1Navigation: View {
    var store: Store<Tab1NavigationState, Tab1NavigationState.Action>
    @ObservedObject var viewStore: ViewStore<Tab1NavigationState, Tab1NavigationState.Action>

    init(store: Store<Tab1NavigationState, Tab1NavigationState.Action>) {
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
                self.viewStore.send(.setTab2Title(self.viewStore.title))
            }) {
                Text("Set the Global Value")
            }
        }
    }
}

struct Tab1Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Tab1Navigation(
            store: Store<Tab1NavigationState, Tab1NavigationState.Action>(
                initialState: Tab1NavigationState(index: 0, title: "Tab 2"),
                reducer: tab1NavigationReducer,
                environment: Tab1NavigationEnvironment()
            )
        )
    }
}
