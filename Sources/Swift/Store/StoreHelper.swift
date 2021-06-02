//
//  StoreHelper.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 01.06.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import os.log
import StoreKit

public class StoreHelper: NSObject {
    public typealias ProductsRequestCompletion = (Result<[SKProduct], Error>) -> Void

    private let products: [ProductInformation]
    private var purchasedProductIdentifiers: Set<ProductInformation.Identifier> = []
    private var productsRequest: SKProductsRequest?
    private var productsRequestCompletion: ProductsRequestCompletion?
    private let suite: UserDefaults
    private let enableLogging: Bool

    public init(
        products: [ProductInformation],
        suite: UserDefaults = .standard,
        enableLogging: Bool = true
    ) {
        self.products = products
        self.suite = suite
        self.enableLogging = enableLogging
        super.init()
        loadPurchasedProductIdentifiers()
        SKPaymentQueue.default().add(self)
    }

    private func loadPurchasedProductIdentifiers() {
        for identifier in products.map(\.identifier) {
            let purchased = suite.bool(forKey: identifier)
            if purchased {
                purchasedProductIdentifiers.insert(identifier)
                log(message: "Previously purchased: \(identifier)")
            } else {
                log(message: "Not purchased: \(identifier)")
            }
        }
    }
}

// MARK: - StoreKit API

extension StoreHelper {
    public func requestProducts(completion: @escaping ProductsRequestCompletion) {
        productsRequest?.cancel()
        productsRequestCompletion = completion
        productsRequest = SKProductsRequest(productIdentifiers: Set(products.map(\.identifier)))
        productsRequest?.delegate = self
        productsRequest?.start()
    }

    public func buyProduct(_ product: SKProduct) {
        log(message: "Buying \(product.productIdentifier)...")
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    public func isProductPurchased(_ product: ProductInformation) -> Bool {
        purchasedProductIdentifiers.contains(product.identifier)
    }

    public class func canMakePayments() -> Bool {
        SKPaymentQueue.canMakePayments()
    }

    public func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    public func clearRequest() {
        productsRequest = nil
        productsRequestCompletion = nil
    }
}

// MARK: - SKProductsRequestDelegate

extension StoreHelper: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        log(message: "Products request success")
        response.products.forEach {
            log(message: "Found product: \($0)")
        }
        productsRequestCompletion?(.success(response.products))
        clearRequest()
    }

    public func request(_ request: SKRequest, didFailWithError error: Error) {
        log(error: "Products request error - \(error.nsErrorDescription)")
        productsRequestCompletion?(.failure(error))
        clearRequest()
    }
}

// MARK: - SKPaymentTransactionObserver

extension StoreHelper: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        log(message: "Received updated transactions")
        let map = Dictionary(grouping: transactions, by: \.transactionState).mapValues(\.count)
        process(completedTransactions: transactions.filter(where: \.transactionState, equals: .purchased))
        process(failedTransactions: transactions.filter(where: \.transactionState, equals: .failed))
        process(restoredTransactions: transactions.filter(where: \.transactionState, equals: .restored))
        sendDidProcessTransactionsNotification(map: map)
    }

    private func process(completedTransactions: [SKPaymentTransaction]) {
        completedTransactions.forEach {
            log(message: "Transaction completed (\($0.payment.productIdentifier))")
            processPurchasedProduct(identifier: $0.payment.productIdentifier)
            SKPaymentQueue.default().finishTransaction($0)
        }
    }

    private func process(failedTransactions: [SKPaymentTransaction]) {
        failedTransactions.forEach {
            if let error = $0.error as NSError? {
                log(error: "Transaction failed (\($0.payment.productIdentifier)) - \(error.description)")
                if error.code != SKError.paymentCancelled.rawValue {
                    sendDidFailTransactionNotification(with: error)
                }
            }
            SKPaymentQueue.default().finishTransaction($0)
        }
    }

    private func process(restoredTransactions: [SKPaymentTransaction]) {
        restoredTransactions.map(\.payment.productIdentifier).forEach {
            purchasedProductIdentifiers.remove($0)
            suite.removeObject(forKey: $0)
        }
        var validProductIdentifiers: [ProductInformation.Identifier] = []
        restoredTransactions.forEach {
            let identifier = $0.payment.productIdentifier
            log(message: "Transaction restored (\(identifier)) (\(String(describing: $0.transactionDate))")
            if isValid(transaction: $0) {
                log(message: "Transaction valid (\(identifier)) (\(String(describing: $0.transactionDate))")
                validProductIdentifiers.append(identifier)
                processPurchasedProduct(identifier: identifier)
            }
            SKPaymentQueue.default().finishTransaction($0)
        }
        sendDidRestoreValidProductsNotification(for: validProductIdentifiers)
    }

    private func processPurchasedProduct(identifier: String) {
        purchasedProductIdentifiers.insert(identifier)
        suite.set(true, forKey: identifier)
        sendDidPurchaseProductNotification(for: identifier)
    }

    private func isValid(transaction: SKPaymentTransaction) -> Bool {
        guard
            let transactionDate = transaction.transactionDate,
            let period = products
                .first(where: \.identifier, equals: transaction.payment.productIdentifier)?
                .period
        else {
            return true
        }
        return Date().startOf(.day) <= transactionDate.adjusting(period.unit, by: period.value)
    }
}

// MARK: - Notifications

extension StoreHelper {
    public static var didPurchaseProductNotification: Notification.Name { .init(#function) }
    public static var didFailTransactionNotification: Notification.Name { .init(#function) }
    public static var didRestoreValidProductsNotification: Notification.Name { .init(#function) }
    public static var didProcessTransactionsNotification: Notification.Name { .init(#function) }
}

extension StoreHelper {
    private func sendDidPurchaseProductNotification(for identifier: ProductInformation.Identifier) {
        NotificationCenter.default.post(name: Self.didPurchaseProductNotification, object: identifier)
    }

    private func sendDidFailTransactionNotification(with error: Error) {
        NotificationCenter.default.post(name: Self.didFailTransactionNotification, object: error)
    }

    private func sendDidRestoreValidProductsNotification(for identifiers: [ProductInformation.Identifier]) {
        NotificationCenter.default.post(name: Self.didRestoreValidProductsNotification, object: identifiers)
    }

    private func sendDidProcessTransactionsNotification(map: [SKPaymentTransactionState: Int]) {
        NotificationCenter.default.post(name: Self.didProcessTransactionsNotification, object: map)
    }
}

// MARK: - Logger

extension OSLog {
    private static let subsystem = Bundle.phantomKit.identifier
    fileprivate static let store = OSLog(subsystem: subsystem, category: "Store")
}

extension StoreHelper {
    private func log(message: String) {
        guard enableLogging else { return }
        Logger.info(message, category: .store)
    }

    private func log(error: String) {
        guard enableLogging else { return }
        Logger.error(error, category: .store)
    }
}
