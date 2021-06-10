//
//  ViewController.swift
//  InfiniteCollectionView
//
//  Created by Eduard Sinyakov on 07.06.2021.
//

import UIKit

class ViewController: UIViewController {
    var collectionView = InfiniteCollectionView(cell: CVCell())
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
        collectionView.startAutoScroll()
        
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                    self.collectionView.stopAutoScroll(withRemoveToInitialItems: true)
//                }
    }
}


class CVCell: PagingCell {
    var avatar: UIImageView = UIImageView()
    
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
    }
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
            
            if itemsConst.isEmpty {
                itemsConst = items
            }
            
            reloadData()
        }
    }
    
    private var pagingView: PagingView!
    private var didEndDisplayingIndex: Int = 0
    private var willDisplayIndex: Int = 0
    private var timer: Timer?
    private var itemsConst: [AnyObject] = [] {
        didSet {
            if let anchor = anchors.first {
                currentAnchor = anchor
            }
        }
    }
    private var currentAnchor: CGPoint = .zero
    
    private var isScrollingFromLeftTopRight: Bool {
        didEndDisplayingIndex < willDisplayIndex
    }
    
    private var count: Int = 0 {
        didSet {
            var cellInfos: [CGSize] = []
            anchors.removeAll()
            // без helper съезжает ячейка при каждом скролле
            let helper: CGFloat = 10
            for _ in 0...count - 1 {
                
                cellInfos.append(CGSize(width: cellSize.width + helper, height: cellSize.height))
            }
            
            for value in 0...count - 1 {
                let offsetX = cellInfos.prefix(value).reduce(0, { $0 + $1.width})
                anchors.append(CGPoint(x: offsetX - cellOffset, y: 0))
            }
            
            pagingView.anchors = anchors
        }
    }
    /// точки, куда нужно скроллить
    private var anchors: [CGPoint] = []
    
    init(cell: PagingCell) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(cell.classForCoder, forCellWithReuseIdentifier: "PagingCell")
        pagingView = PagingView(contentView: self)
        pagingView.delegate = self
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
        stopAutoScroll(withRemoveToInitialItems: false)
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
    
    func startAutoScroll() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
    }
    
    func stopAutoScroll(withRemoveToInitialItems: Bool) {
        timer?.invalidate()
        timer = nil
        
        if withRemoveToInitialItems {
            removeItemsToInitial()
        }
    }
    
    private func removeItemsToInitial() {
        guard count != itemsConst.count else { return }
        var indexPaths: [IndexPath] = []
        for index in itemsConst.count..<count {
            indexPaths.append(IndexPath(row: index, section: 0))
        }
        count = itemsConst.count
        
        performBatchUpdates { [weak self] in
            self?.deleteItems(at: indexPaths)
        } completion: { [weak self] isComplete in
            if isComplete {
                self?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
            }
        }
    }
    
    @objc func fireTimer() {
//        print("Fire timer")
        
        if let index = anchors.firstIndex(of: currentAnchor) {
            let nextIndex = index + 1
            guard nextIndex < count else { return }
            
            setContentOffset(anchors[nextIndex], animated: true)
            currentAnchor = anchors[nextIndex]
        }
    }
}

extension InfiniteCollectionView: CurrentAnchorDelegate {
    func captured(anchor: CGPoint) {
        currentAnchor = anchor
    }
}

class PagingCell: UICollectionViewCell {
    /// override me
    func update(model: AnyObject) {}
}
