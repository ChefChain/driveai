//
//  CarListView.swift
//  XCAChatGPT
//
//  Created by BotBaller on 2023-05-01.
//

import Foundation
import SwiftUI
import Combine

struct CarListView: View {
    @ObservedObject private var viewModel = CarListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.cars) { car in
                VStack(alignment: .leading) {
                    Text("\(car.year) \(car.make) \(car.model)")
                        .font(.headline)
                    Text("Price: $\(car.price, specifier: "%.2f")")
                        .font(.subheadline)
                }
                .padding()
                .background(
                    AsyncImage(
                        url: URL(string: car.imageUrl),
                        placeholder: { AnyView(RoundedRectangle(cornerRadius: 10).fill(Color.gray)) }
                    )
                    .aspectRatio(contentMode: .fit)
                )
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .navigationBarTitle("Cars")
            .onAppear {
                viewModel.fetchCars()
            }
        }
    }
}

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: () -> AnyView

    init(url: URL?, @ViewBuilder placeholder: @escaping () -> AnyView) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }

    var body: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder()
            }
        }
        .onAppear(perform: loader.load)
        .onDisappear(perform: loader.cancel)
    }
}
