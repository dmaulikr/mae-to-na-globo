//
//  AppDelegate.swift
//  MaeToNaGlobo
//
//  Created by Daniel Carlos on 5/13/17.
//  Copyright © 2017 Daniel Carlos. All rights reserved.
//

import UIKit
import VisaCheckoutSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        VisaCheckoutSDK.configure(environment: .sandbox, apiKey: "XU2ESDGNXWEYUV1KOEGY21SmpAAFDRAkjFoXqa0RK-hU2KjDA")

        return true
    }

}

