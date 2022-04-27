//
//  topCollectionViewCell.swift
//  GitHubProject
//
//  Created by Alexander Avdacev on 19.04.22.
//

import UIKit
private let reuseIdentifiert = "Cell2"
class topCollectionViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
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
    var number: Int? {
        didSet{
            labelText.text = "\(String(describing: number))"
        }
    }
    var labelText: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView!.register(lowCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifiert)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .gray
        collectionView.dragInteractionEnabled = true
        collectionView.reorderingCadence = .fast
        collectionView.dropDelegate = self
        collectionView.dragDelegate = self
//        addSubview(labelText)
//        labelText.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        9
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifiert, for: indexPath) as! lowCollectionViewCell
//    
//        // Configure the cell
//        cell.number = indexPath.row
//        return cell
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width - 50 , height: 50 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right:10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch data[indexPath.section][indexPath.item] {
            case .simple(let text):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifiert, for: indexPath) as! lowCollectionViewCell
                cell.labelText.text = text
                cell.backgroundColor = .gray
                return cell
            case .availableToDrop:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifiert, for: indexPath) as! lowCollectionViewCell
                cell.backgroundColor = UIColor.green.withAlphaComponent(0.3)
                return cell
        }
    }
}
extension topCollectionViewCell: UICollectionViewDragDelegate {

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




extension topCollectionViewCell: UICollectionViewDropDelegate {
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
