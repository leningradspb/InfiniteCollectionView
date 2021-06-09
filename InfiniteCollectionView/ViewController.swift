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
        let heightConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 250)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        collectionView.backgroundColor = .red
        
        collectionView.cellSize = CGSize(width: 200, height: 210)
        collectionView.items = images
//        collectionView.reloadData()
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
    let label = UILabel()
    
    func update(image: UIImage, index: Int) {
        avatar.clipsToBounds = true
        avatar.image = image
        
        contentView.addSubview(avatar)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: contentView.bounds.width - 40)
        let heightConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 160)
        contentView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.text = "\(index)"
        setupLabelConstaraints()
    }
    
    private func setupLabelConstaraints() {
        contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: contentView.bounds.width - 40)
        let heightConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 160)
        contentView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}


class InfiniteCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var didEndDisplayingIndex: Int = 0
    private var willDisplayIndex: Int = 0
    
    private var isScrollingFromLeftTopRight: Bool {
        didEndDisplayingIndex < willDisplayIndex
    }
    
    var cellSize: CGSize = .zero
    
    private var count: Int = 0
    
    var items: [UIImage] = [] {
        didSet {
            count = items.count
            reloadData()
        }
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(CVCell.self, forCellWithReuseIdentifier: "CVCell")
        contentInsetAdjustmentBehavior = .never
    }
    
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(items.count)
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print(indexPath.row % items.count)
        let itemToShow = items[indexPath.row % items.count]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! CVCell
        cell.update(image: itemToShow, index: indexPath.row)
        cell.backgroundColor = .cyan
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("didend = \(indexPath.row)")
        didEndDisplayingIndex = indexPath.row
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
        guard !items.isEmpty else { return }
        willDisplayIndex = indexPath.row
        
       /* let index = isScrollingFromLeftTopRight ? willDisplayIndex : didEndDisplayingIndex
        if count - 1 == index {
            count += items.count
            var indexPaths: [IndexPath] = []
            for i in count - items.count...count - 1 {
                print("i = \(i)")
                indexPaths.append(IndexPath(row: i, section: 0))
            }
            collectionView.performBatchUpdates {
                // [IndexPath(row: 3, section: 0), IndexPath(row: 4, section: 0), IndexPath(row: 5, section: 0)]
                collectionView.insertItems(at: indexPaths)
            }
        }*/
      
//        if indexPath.row == count - 1 {
//            count += items.count
//            collectionView.reloadData()
//        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // visibleCells.first
//        print("scrollViewDidEndDecelerating", indexPathsForVisibleItems.first?.row)
        
//        print("didEndDisplayingIndex = \(didEndDisplayingIndex) willDisplayIndex = \(willDisplayIndex), isScrollingFromLeftTopRight = \(isScrollingFromLeftTopRight)")
        guard count > items.count else { return }
        var indexPaths: [IndexPath] = []
        for i in 3...count - 1 {
            print("i = \(i)")
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        count = items.count
        performBatchUpdates {
            // [IndexPath(row: 3, section: 0), IndexPath(row: 4, section: 0), IndexPath(row: 5, section: 0)]
            deleteItems(at: indexPaths)
        }
    }
    
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print("scrollViewWillEndDragging")
//    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("didEndDisplayingIndex = \(didEndDisplayingIndex) willDisplayIndex = \(willDisplayIndex), isScrollingFromLeftTopRight = \(isScrollingFromLeftTopRight), \(count)")
//        let index = isScrollingFromLeftTopRight ? willDisplayIndex : didEndDisplayingIndex
//        if index % items.count == 0 {
//            count += items.count
//            reloadData()
//        }
//        if index == items.count - 1 {
//           count += items.count
//            reloadData()
//        }
        
        print("index = \(willDisplayIndex)")
        if count - 1 == willDisplayIndex {
            count += items.count
            var indexPaths: [IndexPath] = []
            for i in count - items.count...count - 1 {
                print("i = \(i)")
                indexPaths.append(IndexPath(row: i, section: 0))
            }
            performBatchUpdates {
                // [IndexPath(row: 3, section: 0), IndexPath(row: 4, section: 0), IndexPath(row: 5, section: 0)]
                insertItems(at: indexPaths)
            }
        }
    }
}
