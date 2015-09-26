//
//  AppDelegate.swift
//  SwiftHTTP
//
//  Created by Erik Aigner on 08/03/15.
//  Copyright (c) 2015 bytieful. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!

	var server : SwiftHTTP?

	func applicationDidFinishLaunching(aNotification: NSNotification) {

		server = SwiftHTTP()
		server?.headersReceivedHandler = { req in
			print("headers: \(req.headers)")
		}
		server?.dataAvailableHandler = { req, data in
			print("received \(data.length) bytes")
		}
		server?.responseHandler = { req, resp in
			resp.body = "hello from SwiftHTTP".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
		}

		if let err = server?.listen(3000) {
			print("could not listen on port 3000: \(err)")
		} else {
			print("listening on port \(server!.port)")
		}
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}


}

