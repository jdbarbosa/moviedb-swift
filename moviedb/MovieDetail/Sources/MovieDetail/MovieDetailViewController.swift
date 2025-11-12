//
//  MovieDetailViewController.swift
//  MovieDetail
//
//  Created by Joao Barbosa on 30/05/2025.
//

import UIKit
import Protocols
import SwiftUI

@MainActor
final class MovieDetailViewController: UIViewController, ViewModelBindable {
  typealias ViewModelType = MovieDetailViewModel

  private var viewModel: MovieDetailViewModel?


  func bind(viewModel: MovieDetailViewModel) {
    self.viewModel = viewModel

    let hostingController = UIHostingController(rootView: MovieDetailView(viewModel: viewModel))
    addChild(hostingController)
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(hostingController.view)

    NSLayoutConstraint.activate([
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    hostingController.didMove(toParent: self)
  }
}
