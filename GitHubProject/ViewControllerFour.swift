//
//  ViewControllerFour.swift
//  GitHubProject
//
//  Created by Alexander Avdacev on 22.04.22.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ViewControllerFour: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {

        var scrollView = UIScrollView()

        let button: UIButton = {
            let button = UIButton()
            button.setTitle("Plus", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.borderWidth = 2
            return button
        }()
    
        var x: Float = 3.0 {
            didSet{
                
            }
        }
    
    var leftTableView = UITableView()
    var rightTableView = UITableView()

    var leftItems = [String](repeating: "Left", count: 10)
    var rightItems = [String](repeating: "Right", count: 10)

    override func viewDidLoad() {
        super.viewDidLoad()

        leftTableView.dataSource = self
        rightTableView.dataSource = self

    //        leftTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    //        rightTableView.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        rightTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        leftTableView.translatesAutoresizingMaskIntoConstraints = false
        rightTableView.translatesAutoresizingMaskIntoConstraints = false

        
        
        leftTableView.dragDelegate = self
        leftTableView.dropDelegate = self
        rightTableView.dragDelegate = self
        rightTableView.dropDelegate = self

        leftTableView.dragInteractionEnabled = true
        rightTableView.dragInteractionEnabled = true

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.isScrollEnabled = true
       scrollView.showsHorizontalScrollIndicator = true
       scrollView.showsVerticalScrollIndicator = true
        scrollView.indicatorStyle = .black
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width*CGFloat(x), height: UIScreen.main.bounds.height)
        setupScrollView()
 
            view.backgroundColor = .red
            button.addTarget(self, action: #selector(plus), for: .touchUpInside)
        }

        @objc func plus() {
        x += 1
            print("\(x)")
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width*CGFloat(x), height: UIScreen.main.bounds.height)
        }
        
        func setupScrollView() {
            
            view.addSubview(scrollView)
            scrollView.addSubview(leftTableView)
            scrollView.addSubview(rightTableView)
            scrollView.addSubview(button)
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
           // scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true//(equalTo: view.widthAnchor,).isActive = true
            scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            leftTableView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            leftTableView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
            leftTableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
            leftTableView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1).isActive = true
            rightTableView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            rightTableView.leftAnchor.constraint(equalTo: leftTableView.rightAnchor).isActive = true
            rightTableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
            rightTableView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1).isActive = true
            button.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
           // scrollView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
            button.leftAnchor.constraint(equalTo: rightTableView.rightAnchor).isActive = true
            button.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1/3).isActive = true
            button.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1/3).isActive = true



   
            //rightTableView.topAnchor.constraint(equalTo: leftTableView.bottomAnchor, constant: 0).isActive = true
  
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
               // leftTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
               // rightTableView.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

        

         func scrollViewDidScroll(_ scrollView: UIScrollView){

        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftItems.count
        } else {
            return rightItems.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if tableView == leftTableView {
            cell.textLabel?.text = "\(leftItems[indexPath.row]) \(indexPath.row)"
        } else {
            cell.textLabel?.text = rightItems[indexPath.row]
        }

        return cell
    }
    
    }
    


extension ViewControllerFour: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let string = tableView == leftTableView ? "\(String(describing: leftTableView.cellForRow(at: indexPath)?.textLabel?.text))" : rightItems[indexPath.row]//leftItems[indexPath.row] : rightItems[indexPath.row]
    guard let data = string.data(using: .utf8) else { return [] }
    let itemProvider = NSItemProvider(item: data as NSData, typeIdentifier: UTType.plainText.identifier as String)

    return [UIDragItem(itemProvider: itemProvider)]
}

func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    let destinationIndexPath: IndexPath

    if let indexPath = coordinator.destinationIndexPath {
        destinationIndexPath = indexPath
    } else {
        let section = tableView.numberOfSections - 1
        let row = tableView.numberOfRows(inSection: section)
        destinationIndexPath = IndexPath(row: row, section: section)
    }
    
    // attempt to load strings from the drop coordinator
    coordinator.session.loadObjects(ofClass: NSString.self) { items in
        // convert the item provider array to a string array or bail out
        guard let strings = items as? [String] else { return }

        // create an empty array to track rows we've copied
        var indexPaths = [IndexPath]()

        // loop over all the strings we received
        for (index, string) in strings.enumerated() {
            // create an index path for this new row, moving it down depending on how many we've already inserted
            let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)

            // insert the copy into the correct array
            if tableView == self.leftTableView {
                self.leftItems.insert(string, at: indexPath.row)
            } else {
                self.rightItems.insert(string, at: indexPath.row)
            }

            // keep track of this new row
            indexPaths.append(indexPath)
        }

        // insert them all into the table view at once
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
}


}

