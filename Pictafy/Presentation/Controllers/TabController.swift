//
//  TabController.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-12-15.
//

import Foundation

enum Tab {
    case home
    case map
    case camera
}

class TabController: ObservableObject {
    @Published var activeTab = Tab.home

    func open(_ tab: Tab) {
        activeTab = tab
    }
}
