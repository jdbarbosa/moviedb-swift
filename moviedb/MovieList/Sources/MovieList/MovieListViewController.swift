//
//  MovieListViewController.swift
//  moviedb
//
//  Created by Joao Barbosa on 15/04/2025.
//
import UIKit
import Protocols
import SwiftUI

@MainActor
final class MovieListViewController: UIViewController, ViewModelBindable {

  func bind(viewModel: MovieListViewModel) {
    self.bindOnMain(viewModel: viewModel)
  }


  typealias ViewModelType = MovieListViewModel
  private var viewModel: MovieListViewModel?

  @MainActor
  init(/*No deps for now */) {
    super.init(nibName: nil, bundle: nil)
  }

  private func bindOnMain(viewModel: MovieListViewModel) {
    self.viewModel = viewModel
    let hostingController = UIHostingController(rootView: MovieListView(viewModel: viewModel))
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

  @objc required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel?.fetchMovies(page: 1)
  }
}

