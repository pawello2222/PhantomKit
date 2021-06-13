//
//  NetworkImage.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 13.06.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Combine
import SwiftUI

public struct NetworkImage<
    SuccessContent: View,
    LoadingContent: View,
    ErrorContent: View
>: View {
    @StateObject private var viewModel = ViewModel()

    private let url: URL?
    private let successContent: (Image) -> SuccessContent
    private let loadingContent: () -> LoadingContent
    private let errorContent: () -> ErrorContent

    public init(
        url: URL?,
        successContent: @escaping (Image) -> SuccessContent,
        loadingContent: @escaping () -> LoadingContent,
        errorContent: @escaping () -> ErrorContent
    ) {
        self.url = url
        self.successContent = successContent
        self.loadingContent = loadingContent
        self.errorContent = errorContent
    }

    public var body: some View {
        VStack {
            if let data = viewModel.imageData, let uiImage = UIImage(data: data) {
                successContent(
                    Image(uiImage: uiImage)
                        .resizable()
                )
            } else if viewModel.isLoading {
                loadingContent()
            } else {
                errorContent()
            }
        }
        .onAppear {
            viewModel.loadImage(from: url)
        }
    }
}

// MARK: - Convenience

extension NetworkImage {
    public init(
        url: URL?,
        successContent: @escaping (Image) -> SuccessContent,
        errorContent: @escaping () -> ErrorContent
    ) where LoadingContent == ProgressView<EmptyView, EmptyView> {
        self.init(
            url: url,
            successContent: successContent,
            loadingContent: {
                ProgressView()
            },
            errorContent: errorContent
        )
    }

    public init(
        url: URL?,
        successContent: @escaping (Image) -> SuccessContent,
        loadingContent: @escaping () -> LoadingContent
    ) where ErrorContent == Image {
        self.init(
            url: url,
            successContent: successContent,
            loadingContent: loadingContent,
            errorContent: {
                Image(system: .photo)
            }
        )
    }
}

// MARK: - ViewModel

private let cache = NSCache<NSURL, NSData>()

extension NetworkImage {
    public class ViewModel: ObservableObject {
        @Published public var imageData: Data?
        @Published public var isLoading = false

        private var cancellables = Set<AnyCancellable>()

        public init() {}

        public func loadImage(from url: URL?) {
            isLoading = true
            guard let url = url else {
                isLoading = false
                return
            }
            if let data = cache.object(forKey: url as NSURL) {
                imageData = data as Data
                isLoading = false
                return
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .replaceError(with: nil)
                .receiveOnMain()
                .sink { [weak self] in
                    if let data = $0 {
                        cache.setObject(data as NSData, forKey: url as NSURL)
                        self?.imageData = data
                    }
                    self?.isLoading = false
                }
                .store(in: &cancellables)
        }
    }
}
