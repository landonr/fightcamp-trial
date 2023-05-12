//
//  ViewController.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let viewModel: IViewModel = ViewModel()
    private var collectionViewCancellable: AnyCancellable?
    private var dataSource: UICollectionViewDiffableDataSource<Int, FullWorkout>?
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: .createBasicListLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.register(
            WorkoutCell.self,
            forCellWithReuseIdentifier: WorkoutCell.identifier
        )
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Fightcamp"
        view.backgroundColor = .dynamicColor(light: .brandGray1, dark: .brandGray6)
        view.addSubview(collectionView)
        collectionView.pin(superView: view)
        
        collectionView.delegate = self
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WorkoutCell.identifier,
                for: indexPath
            ) as? WorkoutCell else {
                return UICollectionViewCell()
            }
            cell.configure(itemIdentifier)
            return cell
        })
        
        collectionViewCancellable = viewModel.items
            .receive(on: RunLoop.main)
            .sink { [weak self] package in
                var snapshot = NSDiffableDataSourceSnapshot<Int, FullWorkout>()
                snapshot.appendSections([0])
                snapshot.appendItems(package)
                self?.dataSource?.apply(snapshot)
            }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > 0 &&
            scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) &&
            viewModel.count > 0) {
            Task { [weak viewModel] in
                do {
                    try await viewModel?.loadNextPage()
                } catch {
                    print(error)
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let fullWorkout = viewModel.getWorkoutAtIndex(index: indexPath.row) {
            print(fullWorkout)
            let view = WorkoutViewController()
            view.configure(workout: fullWorkout)
            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.pushViewController(view, animated: true)
            }
        }
    }
}
