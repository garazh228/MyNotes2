//
//  OnBoardingView.swift
//  MyNotes2
//
//  Created by adyl CEO on 14/03/2024.
//

import UIKit

class OnBoardingView: UIViewController {
    
    var currentPage = 0
    
    private lazy var onBoardingCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.currentPage = 0
        view.numberOfPages = 3
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next".localized(), for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip".localized(), for: .normal)
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.tintColor = .systemPink
        view.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        view.addSubview(onBoardingCollectionView)
        NSLayoutConstraint.activate([
            onBoardingCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            onBoardingCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            onBoardingCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            onBoardingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 590),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            nextButton.widthAnchor.constraint(equalToConstant: 160),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(skipButton)
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133),
            skipButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            skipButton.widthAnchor.constraint(equalToConstant: 160),
            skipButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func nextButtonTapped() {
        
        if currentPage == 2 {
            navigationController?.pushViewController(HomeView(), animated: true)
        } else {
            onBoardingCollectionView.isPagingEnabled = false
            onBoardingCollectionView.scrollToItem(at: IndexPath(row: currentPage + 1, section: 0), at: .centeredHorizontally, animated: true)
            onBoardingCollectionView.isPagingEnabled = true
        }
    }
    
    @objc private func skipButtonTapped() {
        navigationController?.pushViewController(HomeView(), animated: true)
    }
    
    private func updatePageControl() {
        pageControl.currentPage = currentPage
    }
}




extension OnBoardingView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reuseId, for: indexPath) as! OnBoardingCell
        cell.imageView.image = UIImage(named: "onboard\(indexPath.item + 1)")
        return cell
    }
    
}

extension OnBoardingView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.x
        
        let page = (contentOffset / view.frame.width)
        
        currentPage = Int(page)
        updatePageControl()
        
        switch page {
        case 0.0:
            pageControl.currentPage = 0
            currentPage = 0
        case 1.0:
            pageControl.currentPage = 1
            currentPage = 1
        case 2.0:
            UserDefaults.standard.set(true, forKey: "isOnBoardShown")
            pageControl.currentPage = 2
            currentPage = 2
        default:
            ()
        }
    }
}
