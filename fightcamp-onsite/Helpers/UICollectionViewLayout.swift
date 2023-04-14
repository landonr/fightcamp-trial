//
//  UICollectionView.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import UIKit

extension UICollectionViewLayout {
    static func createBasicListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(1000))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(1000))
//        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: .cardPadding)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = .packageSpacing
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
