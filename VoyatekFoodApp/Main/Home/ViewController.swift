//
//  ViewController.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 23/02/2025.
//

import Combine
import UIKit

class ViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    private let profileHeaderView = ProfileHeaderView()
    private let searchBar = CustomSearchView(frame: .zero)
    
    private let foodCategory = CustomOptionView(with: [])
    
    private var foodContentView: UITableView = UITableView(frame: .zero)
    
    private let addButton = UIButton(frame: .zero)
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        
        viewModel.fetchFood()
        viewModel.fetchFoodCategories()
        setupUI()
        setNavigationAndTabBar(hidden: true)
        addButton.isEnabled = false
    }
    
    func setupUI() {
        view.addSubview(profileHeaderView)
        view.addSubview(searchBar)
        view.addSubview(foodCategory)
        view.addSubview(foodContentView)
        
        view.addSubview(addButton)
        
        setupBinding()
        dismissKeyboardTapGesture()
        layoutUI()
    }
    
    func dismissKeyboardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Ensures other touch events still work
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true) // Dismisses the keyboard
    }
    
    func layoutUI() {
        layoutProfileHeaderView()
        layoutSearchBar()
        layoutFoodCategory()
        layoutFoodContentView()
        layoutAddButton()
    }
    
    func layoutProfileHeaderView() {
        profileHeaderView.anchor(
            top: view.topAnchor,
            trailing: view.trailingAnchor,
            leading: view.leadingAnchor,
            paddingLeft: 16,
            paddingRight: 16,
            height: 150
        )
        profileHeaderView.userName = "Lucy"
        profileHeaderView.profileImage = UIImage(named: "profile_avatar")
    }
    
    func setupBinding() {
        profileHeaderView.buttonTapped
            .sink { [weak self] in
                self?.handleButtonTap()
            }
            .store(in: &cancellables) // Store the subscription
        
        viewModel.$filteredFoods
            .receive(on: RunLoop.main).sink { [weak self] foodItem in
                guard let self else { return }
                foodContentView.reloadData()
            }.store(in: &cancellables)
        
        viewModel.$categories.sink { [weak self] cat in
            guard let self else { return }
            var option: [OptionData] = [
                Option(title: "All")
            ]
            option.append(contentsOf: cat.map({Option(title: $0.name)}))
            foodCategory.viewModel?.options = option
            foodCategory.viewModel?.handleSelection(at: 0)
            addButton.isEnabled = true
        }.store(in: &cancellables)
        
        foodCategory.$selectedIndex.receive(on: RunLoop.main).sink { [weak self] selectedIndex in
            guard let self else { return }
            viewModel.filterTableView(categoryIndex: selectedIndex)
            foodContentView.reloadData()
        }.store(in: &cancellables)
    }
    
    func layoutSearchBar() {
        searchBar.anchor(
            top: profileHeaderView.bottomAnchor,
            trailing: view.trailingAnchor,
            leading: view.leadingAnchor,
            paddingTop: 10,
            paddingLeft: 5,
            paddingRight: 5,
            height: 58
        )
    }
    
    func layoutFoodCategory() {
        foodCategory.anchor(
            top: searchBar.bottomAnchor,
            trailing: profileHeaderView.trailingAnchor,
            leading: profileHeaderView.leadingAnchor,
            paddingTop: 10,
            height: 42
        )
    }
    
    func layoutFoodContentView() {
        foodContentView.anchor(
            top: foodCategory.bottomAnchor,
            trailing: foodCategory.trailingAnchor,
            bottom: view.safeBottomAnchor,
            leading: foodCategory.leadingAnchor,
            paddingTop: 16
        )
        
        foodContentView.delegate = self
        foodContentView.dataSource = self
        
        foodContentView.register(FoodItemCell.self, forCellReuseIdentifier: FoodItemCell.reseuseIdentifier)
    }
    
    func layoutAddButton() {
        addButton.anchor(
            trailing: view.safeRightAnchor,
            bottom: view.safeBottomAnchor,
            paddingBottom: 40,
            paddingRight: 40,
            width: 50,
            height: 50
        )
        addButton.cornerRadius = 25
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.backgroundColor = .unSelected
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func handleButtonTap() {
        print("Button clicked in custom view!")
        _ = showAlert(title: "Notification", message: "This is not available at the moment", positive: "Ok")
    }
    
    @objc private func addButtonTapped(_ button: UIButton) {
        let vc = AddFoodViewController()
        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Helper to toggle visibility of navigation and tab bars
    func setNavigationAndTabBar(hidden: Bool) {
        //        self.navigationController?.navigationBar.isHidden = hidden
        self.navigationController?.setNavigationBarHidden(hidden, animated: true)
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodItemCell.reseuseIdentifier) as? FoodItemCell else {
            return UITableViewCell()
        }
        cell.confire(with: viewModel.filteredFoods[indexPath.row])
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getFoodTitle()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 277

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

