//
//  ViewController.swift
//  InfiniteCollectionView
//
//  Created by Eduard Sinyakov on 07.06.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var items = [UIColor.red, UIColor.magenta, UIColor.green]
    var images = [UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!]
    var isInitial = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemToShow = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CVCell
        cell.update(image: images[indexPath.row])
        cell.backgroundColor = itemToShow
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row == items.count - 1 {
            items += [UIColor.red, UIColor.magenta, UIColor.green]
            images += [UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!]
            self.collectionView.insertItems(at: [IndexPath(row: items.count - 1, section: 0), IndexPath(row: items.count - 2, section: 0), IndexPath(row: items.count - 3, section: 0)])
        }
    }
}


class CVCell: UICollectionViewCell {
    @IBOutlet weak var avatar: UIImageView!
    
    func update(image: UIImage) {
        avatar.clipsToBounds = true
        avatar.image = image
    }
}
