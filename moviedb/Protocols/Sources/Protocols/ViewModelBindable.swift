//
//  Scene.swift
//  moviedb
//
//  Created by Joao Barbosa on 15/04/2025.
//

import UIKit

/// Protocol that subclassers should implement to conform with MVVM design pattern
public protocol ViewModelBindable {

  // This associatedtype defines the class of the view model that the
  // implementer will use.
  associatedtype ViewModelType

  @MainActor
  func bind(viewModel: ViewModelType)
}

public protocol ViewModel {
  // MARK: - types -

  /// The concrete type of View that the receiver corresponds to.
  associatedtype ViewControllerType: UIViewController & ViewModelBindable where ViewControllerType.ViewModelType == Self

}

///// Protocol that view models should implement to enable with Router capabilities
//protocol RouterBindable {
//
//  // This associatedtype defines the type of the router that the
//  // implementer will use.
//  associatedtype RouterType
//
//  // The var that will hold the router implementation
//  var router: RouterType! { get set }
//}

