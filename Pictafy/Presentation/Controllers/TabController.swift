//
//  TabController.swift
//  Pictafy
//
//  Created by Seth Climenhaga on 2021-12-15.
//  Group - 2: Shae Simeoni: 991625152, Rita Singh: 991573398, Seth Climenhaga: 991599894

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
