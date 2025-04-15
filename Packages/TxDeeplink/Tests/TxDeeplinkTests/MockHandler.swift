//
//  MockHandler.swift
//  TxDeeplink
//
//  Created by doandat on 15/4/25.
//
import XCTest
@testable import TxDeeplink

final class MockHandler: TxDeeplinkHandlerProtocol {
    var canOpenURLCalled = false
    var openURLCalled = false

    func canOpenURL(_ url: URL) -> Bool {
        canOpenURLCalled = true
        return true
    }

    func openURL(_ url: URL) {
        openURLCalled = true
    }
}
