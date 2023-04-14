//
//  ViewController.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let viewModel = ViewModel()
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

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.count - 1 &&
            viewModel.count > 0 &&
            collectionView.contentOffset.y > 0 {
            Task {
                do {
                    try await viewModel.loadNextPage()
                } catch {
                    print(error)
                }
            }
        }
    }
}
