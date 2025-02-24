//
//  CustomOptionView.swift
//  VoyatekFoodApp
//
//  Created by Oko-Osi Korede on 24/02/2025.
//

import Combine
import UIKit

class CustomOptionView: UIView {
    
    @Published var selectedIndex: Int = 0
    var viewModel: CustomOptionViewViewModel?
    
    var cancellables = Set<AnyCancellable>()
    
    var collecctionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var isScrollEnabled: Bool = true {
        didSet {
            collecctionView.isScrollEnabled = isScrollEnabled
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
    }
    
    func configureSubViews() {
        addSubview(collecctionView)
        collecctionView.pin(to: self)
        
    }
    
    func setupBindings() {
        
        collecctionView.dataSource = viewModel
        collecctionView.delegate = viewModel
        
        collecctionView.register(OptionCell.self, forCellWithReuseIdentifier: OptionCell.identifier)
        
        viewModel?.$selectedIndex.sink(receiveValue: { [weak self] index in
            guard let self else { return }
            selectedIndex = index
            collecctionView.reloadData()
        })
        .store(in: &cancellables)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(with options: [String]) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        viewModel = .init(options: options)
        setupBindings()
    }
}

extension CustomOptionViewViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleSelection(at: indexPath.row)
    }
}
extension CustomOptionViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let customLabel = UILabel.textLabel(fontSize: 14)
        customLabel.text = options[indexPath.row].title
        customLabel.sizeToFit() // Forces the label to calculate its actual size
        let estimatedWidth = customLabel.intrinsicContentSize.width + 30 // Add padding
        return CGSize(width: estimatedWidth, height: 42)
    }
}
extension CustomOptionViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCell.identifier, for: indexPath) as? OptionCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: options[indexPath.row])
        return cell
    }
}
