//
//  ImageLoader.swift
//  XCAChatGPT
//
//  Created by BotBaller on 2023-05-01.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private var url: URL?
    private var cancellable: AnyCancellable?

    init(url: URL?) {
        self.url = url
    }

    func load() {
        guard let url = url else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.image = image
            }
    }

    func cancel() {
        cancellable?.cancel()
    }
}
