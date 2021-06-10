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
        collectionView.backgroundColor = .clear
        
        collectionView.cellSize = CGSize(width: 200, height: 210)
        collectionView.items = images
    }
}


class CVCell: PagingCell {
    var avatar: UIImageView = UIImageView()
//    let label = UILabel()
    
    override func update(model: AnyObject) {
        guard let image = model as? UIImage else {return}
        avatar.clipsToBounds = true
        avatar.image = image
        
        contentView.addSubview(avatar)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: contentView.bounds.width - 40)
        let heightConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 160)
        contentView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
//        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        label.textColor = .white
//        label.text = "\(index)"
//        setupLabelConstaraints()
    }
    
//    func update(image: UIImage, index: Int) {
//        avatar.clipsToBounds = true
//        avatar.image = image
//
//        contentView.addSubview(avatar)
//
//        avatar.translatesAutoresizingMaskIntoConstraints = false
//
//        let horizontalConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
//        let verticalConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
//        let widthConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: contentView.bounds.width - 40)
//        let heightConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 160)
//        contentView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
//        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        label.textColor = .white
//        label.text = "\(index)"
//        setupLabelConstaraints()
//    }
    
//    private func setupLabelConstaraints() {
//        contentView.addSubview(label)
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        let horizontalConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
//        let verticalConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
//        let widthConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: contentView.bounds.width - 40)
//        let heightConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 160)
//        contentView.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
//    }
}


class InfiniteCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    /// насколько поинтов видна скрытая (левая) ячейка. Её правая часть. Задавать значение до items!
    var cellOffset: CGFloat = 30
    
    var cellSize: CGSize = .zero {
        didSet {
            pagingView.heightAnchor.constraint(equalToConstant: cellSize.height).isActive = true
        }
    }
    
    var items: [AnyObject] = [] {
        didSet {
            count = items.count
            reloadData()
        }
    }
    
    private var pagingView: PagingView!
    private var didEndDisplayingIndex: Int = 0
    private var willDisplayIndex: Int = 0
    
    private var isScrollingFromLeftTopRight: Bool {
        didEndDisplayingIndex < willDisplayIndex
    }
    
    private var count: Int = 0 {
        didSet {
            var cellInfos: [CGSize] = []
            // без helper съезжает ячейка при каждом скролле
            let helper: CGFloat = 10
            for _ in 0...count - 1 {
                
                cellInfos.append(CGSize(width: cellSize.width + helper, height: cellSize.height))
            }
            
            for value in 0...count - 1 {
                let offsetX = cellInfos.prefix(value).reduce(0, { $0 + $1.width})
                print(offsetX)
                anchors.append(CGPoint(x: offsetX - cellOffset, y: 0))
            }

            pagingView.anchors = anchors
        }
    }
    
    private var anchors: [CGPoint] = []
  
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(CVCell.self, forCellWithReuseIdentifier: "PagingCell")
        pagingView = PagingView(contentView: self)
        setupLayout()
//        contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        pagingView.backgroundColor = .green
        pagingView.translatesAutoresizingMaskIntoConstraints = false
//        pagingView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        pagingView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pagingView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pagingView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pagingView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pagingView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pagingView.anchors = anchors
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemToShow = items[indexPath.row % items.count]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagingCell", for: indexPath) as! PagingCell
        cell.update(model: itemToShow)
//        cell.update(image: itemToShow, index: indexPath.row)
        cell.backgroundColor = .cyan
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        didEndDisplayingIndex = indexPath.row
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !items.isEmpty else { return }
        willDisplayIndex = indexPath.row
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pagingView.contentViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pagingView.contentViewWillBeginDragging(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if count - 1 == willDisplayIndex {
            count += items.count
            var indexPaths: [IndexPath] = []
            for i in count - items.count...count - 1 {
                indexPaths.append(IndexPath(row: i, section: 0))
            }
            
            performBatchUpdates { [weak self] in
                self?.insertItems(at: indexPaths)
            }
        }
    }
}

class PagingCell: UICollectionViewCell {
    /// override me
    func update(model: AnyObject) {
        
    }
}
