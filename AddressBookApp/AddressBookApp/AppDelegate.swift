//
//  AppDelegate.swift
//  AddressBookApp
//
//  Created by Eunjin Kim on 2018. 4. 5..
//  Copyright © 2018년 Eunjin Kim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

// KVO, 옵저빙
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let vc = window?.rootViewController as? HolidayViewController {
            vc.holidayData = HolidayDataLoader.sharedInstance()
        }
        if let vc = window?.rootViewController as? AddressBookViewController {
            vc.contactsData = ContactsDataLoader.sharedInstance()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
     }


}

