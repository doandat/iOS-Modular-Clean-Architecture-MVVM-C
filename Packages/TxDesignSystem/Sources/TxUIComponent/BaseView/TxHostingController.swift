//
//  TxHostingController.swift
//  TxDesignSystem
//
//  Created by doandat on 10/4/25.
//

import SwiftUI
import TxLogger

open class TxHostingController<Content: View>: UIHostingController<Content> {
    public var identifier: String
    public override init(rootView: Content) {
        self.identifier = (rootView as? (any TxView))?.identifier ?? ""
        super.init(rootView: rootView)
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        TxLogger().debug("deinit \(identifier)")
    }
}
