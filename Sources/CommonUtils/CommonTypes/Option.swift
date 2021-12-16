//
// Created by Alexander Lakhonin on 28.09.2021.
// Copyright © 2021 Alexander Lakhonin. All right reserved.
//

import Foundation

/// Analog of OptionSet for enums
public typealias Option = RawRepresentable & Hashable & CaseIterable
