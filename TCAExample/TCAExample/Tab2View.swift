//
//  Tab2View.swift
//  TCAExample
//
//  Created by Van Simmons on 8/1/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct Tab2View: View {
    var store: Store<Tab2State, Tab2State.Action>

    init(store: Store<Tab2State, Tab2State.Action>) {
        self.store = store
    }

    var body: some View {
        VStack {
            WithViewStore(store) { viewStore in
                Text(viewStore.title)
            }
        }
        .font(.largeTitle)
    }
}
struct Tab2View_Previews: PreviewProvider {
    static var previews: some View {
        Tab2View(
            store: Store<Tab2State, Tab2State.Action>(
                initialState: Tab2State(title: "Tab 2"),
                reducer: tab2Reducer,
                environment: Tab2Environment()
            )
        )
    }
}
