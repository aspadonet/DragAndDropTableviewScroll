//
//  CollectionViewController.swift
//  GitHubProject
//
//  Created by Alexander Avdacev on 19.04.22.
//

import UIKit
enum CellModel {
    case simple(text: String)
    case availableToDrop
}

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    private lazy var cellIdentifier = "cellIdentifier"
    private lazy var supplementaryViewIdentifier = "supplementaryViewIdentifier"
    private lazy var sections = 1
    private lazy var itemsInSection = 2
    private lazy var numberOfElementsInRow = 3

    private lazy var data: [[CellModel]] = {
        var count = 0
        return (0 ..< sections).map { _ in
            return (0 ..< itemsInSection).map { _ -> CellModel in
                count += 1
                return .simple(text: "cell \(count)")
            }
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(topCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .red
        collectionView.dragInteractionEnabled = true
        collectionView.reorderingCadence = .fast
        collectionView.dropDelegate = self
        collectionView.dragDelegate = self
    }
    init() {
                  let layout = UICollectionViewFlowLayout()
                  layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
//    override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//
//            let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = .horizontal
//            self.collectionView.collectionViewLayout = layout
//            self.collectionView!.contentInset = UIEdgeInsets(top: -10, left: 0, bottom:0, right: 0)
//
//            if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                layout.minimumInteritemSpacing = 10
//                layout.minimumLineSpacing = 10
//                layout.itemSize = CGSize(width: self.view.frame.size.width-40, height: self.collectionView.frame.size.height-10)
//                layout.invalidateLayout()
//            }
//
//        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width - 40 , height:self.view.frame.size.height - 40 )
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        
//        return 1
//    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data[indexPath.section][indexPath.item] {
            case .simple(let text):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! topCollectionViewCell
                cell.labelText.text = text
                cell.backgroundColor = .gray
                return cell
            case .availableToDrop:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! topCollectionViewCell
                cell.backgroundColor = UIColor.green.withAlphaComponent(0.3)
                return cell
        }
    }

//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return 5
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! topCollectionViewCell
//
//        // Configure the cell
//        cell.number = indexPath.row
//        return cell
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension CollectionViewController: UICollectionViewDragDelegate {

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = data[indexPath.section][indexPath.row]
        return [dragItem]
    }

    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let itemProvider = NSItemProvider(object: "\(indexPath)" as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = data[indexPath.section][indexPath.row]
        return [dragItem]
    }


    func collectionView(_ collectionView: UICollectionView, dragSessionWillBegin session: UIDragSession) {
        var itemsToInsert = [IndexPath]()
        (0 ..< data.count).forEach {
            itemsToInsert.append(IndexPath(item: data[$0].count, section: $0))
            data[$0].append(.availableToDrop)
        }
        collectionView.insertItems(at: itemsToInsert)
    }

    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        var removeItems = [IndexPath]()
        for section in 0..<data.count {
            for item in  0..<data[section].count {
                switch data[section][item] {
                    case .availableToDrop:
                        removeItems.append(IndexPath(item: item, section: section))
                    case .simple:
                        break
                }
            }
        }
        removeItems.forEach { data[$0.section].remove(at: $0.item) }
        collectionView.deleteItems(at: removeItems)
    }
    
    
}




extension CollectionViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections - 1
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }

        switch coordinator.proposal.operation {
            case .move:
                reorderItems(coordinator: coordinator, destinationIndexPath:destinationIndexPath, collectionView: collectionView)
            case .copy:
                copyItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
            default: return
        }
    }

    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool { return true }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag, let destinationIndexPath = destinationIndexPath {
            switch data[destinationIndexPath.section][destinationIndexPath.row] {
                case .simple:
                    return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
                case .availableToDrop:
                    return UICollectionViewDropProposal(operation: .move, intent: .insertIntoDestinationIndexPath)
            }
        }
        else {
            return UICollectionViewDropProposal(operation: .forbidden)
            
        }
    }

    
    
    private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        let items = coordinator.items
        if items.count == 1, let item = items.first,
            let sourceIndexPath = item.sourceIndexPath,
            let localObject = item.dragItem.localObject as? CellModel {

            collectionView.performBatchUpdates ({
                data[sourceIndexPath.section].remove(at: sourceIndexPath.item)
                data[destinationIndexPath.section].insert(localObject, at: destinationIndexPath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            })
        }
    }

    private func copyItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        collectionView.performBatchUpdates({
            var indexPaths = [IndexPath]()
            for (index, item) in coordinator.items.enumerated() {
                if let localObject = item.dragItem.localObject as? CellModel {
                    let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                    data[indexPath.section].insert(localObject, at: indexPath.row)
                    indexPaths.append(indexPath)
                }
            }
            collectionView.insertItems(at: indexPaths)
        })
    }
}
