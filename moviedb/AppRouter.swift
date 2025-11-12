//
//  AppRouter.swift
//  moviedb
//
//  Created by Joao Barbosa on 15/04/2025.
//

import UIKit
import MovieList
import APIClient
import Locator
import MovieDetail

/// Class that will hold the main window, and from which the SceneRouters will be built from.
/// A new transition will be performed on top of the `currentViewController`provided by this class
final class AppRouter {

    private let window: UIWindow

    /// Creates an AppRouter. By passing it the app's window, typically from AppDelegate
    required init(window: UIWindow) {
        self.window = window
    }

    var currentViewController: UIViewController! {
        return self.window.rootViewController?.topmostViewController
    }

    func setInitialScreen(viewController: UIViewController) {
        self.window.rootViewController = viewController
    }

  @MainActor
  func start() {
    // Let's try to get the factories and apiclient from the Locator later on
    let locator = setupLocator()

    let movieListProvider = locator.resolve(.movieListProvider) as MovieListProvider
    guard let movieListViewController = movieListProvider.movieListViewController() else {
      fatalError("Failed to setup initial screen")
    }
    
    setInitialScreen(viewController: UINavigationController(rootViewController: movieListViewController))
  }

  func setupLocator() -> Locator {
    let locator = Locator()

    APIClientModule.registerServices(in: locator)
    MovieDetailModule.registerServices(in: locator)
    MovieListModule.registerServices(in: locator)

    return locator
  }
}

extension UIViewController {

    /// Returns the very topmost view controller from the reciever
    ///
    /// It applies these rules in this order:
    /// - If the reciever is presenting anything modally, it returns that modally presented controller's topmostViewController
    /// - If the reciever is a tab bar, it returns the selected controler's topmostViewController
    /// - If the reciever is a nav bar, it returns the top view controller's topmostViewController
    /// - If none of the above match, the reciever _is_ the topmost view controller
    var topmostViewController: UIViewController {
        switch self {

        case _ where self.presentedViewController != nil:
            return self.presentedViewController!.topmostViewController

        case let tabController as UITabBarController where tabController.selectedViewController != nil:
            return tabController.selectedViewController!.topmostViewController

        case let navController as UINavigationController where navController.topViewController != nil:
            return navController.topViewController!.topmostViewController

        default:
            return self
        }
    }
}
