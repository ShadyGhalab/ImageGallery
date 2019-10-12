//
//  OSLog+Loggers.swift
//
//  Created by Shady Mustafa on 16.07.19.
//  Copyright © 2019 Babylon Health. All rights reserved.
//

import Foundation
import os.log

internal extension OSLog {
    private static let subsystem = Bundle.main.bundleIdentifier! // swiftlint:disable:this force_unwrapping
    
    static let modelsLogger = OSLog(subsystem: OSLog.subsystem, category: "Models")
    static let requestsLogger = OSLog(subsystem: OSLog.subsystem, category: "Requests")
}
