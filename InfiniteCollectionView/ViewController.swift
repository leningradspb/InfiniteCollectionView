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
//    var images = [UIImage(named: "0"), UIImage(named: "1"), UIImage(named: "2")]
    var images = [UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!]
    var isInitial = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.items += self.items
//            self.images += self.images
//            self.collectionView.reloadData()
            self.isInitial = false
        }
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemToShow = items[indexPath.row % items.count]
//        let itemToShow = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CVCell
        cell.update(image: images[indexPath.row])
        cell.backgroundColor = itemToShow
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard !isInitial else { return }
//        print(indexPath.row)
        print(indexPath.row)
//        if indexPath.row == items.count - 1 {
//            items += [UIColor.red, UIColor.magenta, UIColor.green]
//            images += [UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!]
//            self.collectionView.insertItems(at: [IndexPath(row: items.count - 1, section: 0), IndexPath(row: items.count - 2, section: 0), IndexPath(row: items.count - 3, section: 0)])
//        }
//        guard !isInitial else {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.isInitial = false
//            }
//
//            return
//        }
//        print(indexPath.row)
//        if indexPath.row == items.count - 1 {
//
//            items += items
//            images += images
//            collectionView.reloadData()
//            print(indexPath.row, "reloadData", items.count, items)
//        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x, scrollView.contentSize.width, scrollView.contentInset.right)
//        if scrollView.bounds.width == scrollView.contentSize.width {
//            print("here")
//        }
//    }
    
    
    
}


class CVCell: UICollectionViewCell {
    @IBOutlet weak var avatar: UIImageView!
    
    func update(image: UIImage) {
        avatar.clipsToBounds = true
        avatar.image = image
    }
}
