//
//  ViewController.swift
//  InfiniteCollectionView
//
//  Created by Eduard Sinyakov on 07.06.2021.
//

import UIKit

class ViewController: UIViewController {
    var collectionView = InfiniteCollectionView()
    var items = [UIColor.red, UIColor.magenta, UIColor.green]
    var images = [UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!]
    var isInitial = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: view.bounds.width)
        let heightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        collectionView.backgroundColor = .red
        
        collectionView.cellSize = CGSize(width: 200, height: 210)
        collectionView.items = images
        collectionView.reloadData()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView = InfiniteCollectionView(cellSize: CGSize(width: 200, height: 110), dataSource: images)
//        collectionView.contentInsetAdjustmentBehavior = .never
    }
}

//extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let itemToShow = items[indexPath.row]
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CVCell
//        cell.update(image: images[indexPath.row])
//        cell.backgroundColor = itemToShow
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: 200, height: 110)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print(indexPath.row)
//        if indexPath.row == items.count - 1 {
//            items += [UIColor.red, UIColor.magenta, UIColor.green]
//            images += [UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!]
//            self.collectionView.insertItems(at: [IndexPath(row: items.count - 1, section: 0), IndexPath(row: items.count - 2, section: 0), IndexPath(row: items.count - 3, section: 0)])
//        }
//    }
//}


class CVCell: UICollectionViewCell {
    var avatar: UIImageView = UIImageView()
    
    func update(image: UIImage) {
        avatar.clipsToBounds = true
        avatar.image = image
        
        contentView.addSubview(avatar)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: contentView.bounds.width)
        let heightConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        contentView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}


class InfiniteCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var cellSize: CGSize = .zero
    var items: [UIImage] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(CVCell.self, forCellWithReuseIdentifier: "CVCell")
    }
    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CVCell
        cell.update(image: items[indexPath.row])
        cell.backgroundColor = .cyan
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
        guard !items.isEmpty else { return }
        if indexPath.row == items.count - 1 {
            items += [UIImage(named: "0")!, UIImage(named: "1")!, UIImage(named: "2")!]
            self.insertItems(at: [IndexPath(row: items.count - 1, section: 0), IndexPath(row: items.count - 2, section: 0), IndexPath(row: items.count - 3, section: 0)])
        }
    }
}
