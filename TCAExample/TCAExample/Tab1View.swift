//
//  Tab1View.swift
//  TCAExample
//
//  Created by Van Simmons on 8/1/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct Tab1View: View {
    var store: Store<Tab1State, Tab1State.Action>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEachStore(
                        self.store.scope(
                            state: \.tab1Navigations,
                            action: Tab1State.Action.tab1NavigationAction(index:action:)
                        ),
                        content: Tab1Navigation.init(store:)
                    )
                }
                Spacer()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("Tab 1")
            .navigationBarHidden(false)
        }
    }
}

struct Tab1View_Previews: PreviewProvider {
    static var previews: some View {
        Tab1View(
            store: Store(
                initialState: Tab1State(),
                reducer: tab1Reducer,
                environment: Tab1Environment()
            )
        )
    }
}
