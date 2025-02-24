//
//  AddFoodViewController.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import Combine
import UIKit
import SwiftUI

class AddFoodViewController: UIViewController {
    
    var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        let categories = viewModel?.categories.map({ $0.name }) ?? []
        
        let swiftUIView = AddFoodView(onBack: backButtonTapped, category: categories)
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        hostingController.view.pin(to: view)
        
        hostingController.didMove(toParent: self)
    }
    
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
