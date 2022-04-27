//
//  ViewControllerFive.swift
//  GitHubProject
//
//  Created by Alexander Avdacev on 22.04.22.
//

    import UIKit
    import MobileCoreServices
    import UniformTypeIdentifiers

    class ViewControllerFive: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {

            var scrollView = UIScrollView()

            let button: UIButton = {
                let button = UIButton()
                button.setTitle("Plus", for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.layer.borderWidth = 2
                return button
            }()
        
            var x: Float = 2.0 {
                didSet{
                    
                }
            }
        var names: [UITableView] = [UITableView(),UITableView()]
        var leftTableView = UITableView()
        var rightTableView = UITableView()
        var buttonLeftAnchorConstraint: NSLayoutConstraint?
        var buttonTopAnchorConstraint: NSLayoutConstraint?
        var buttonAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>?
        var buttonxConstraint: NSLayoutConstraint!
        var leftItems = [String](repeating: "Left", count: 10)
        var rightItems = [String](repeating: "Right", count: 10)
        lazy var item = [leftItems,rightItems]
        
        override func viewDidLoad() {
            super.viewDidLoad()

            _ = names.map({ $0.dataSource = self
                $0.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.dragDelegate = self
                $0.dropDelegate = self
                $0.dragInteractionEnabled = true
            })


            scrollView.translatesAutoresizingMaskIntoConstraints = false

            scrollView.isScrollEnabled = true
           scrollView.showsHorizontalScrollIndicator = true
           scrollView.showsVerticalScrollIndicator = true
            scrollView.indicatorStyle = .black
            scrollView.delegate = self
            
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width*CGFloat(x + 1), height: UIScreen.main.bounds.height)
            setupScrollView()
     
                view.backgroundColor = .red
                button.addTarget(self, action: #selector(plus), for: .touchUpInside)
            }

            @objc func plus() {
            //
                names.append(UITableView())
                 
                item.append([String](repeating: "\(x)", count: 10))
                
                names[Int(x)].translatesAutoresizingMaskIntoConstraints = false
                names[Int(x)].dataSource = self
                names[Int(x)].register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                names[Int(x)].translatesAutoresizingMaskIntoConstraints = false
                names[Int(x)].dragDelegate = self
                names[Int(x)].dropDelegate = self
                names[Int(x)].dragInteractionEnabled = true
                names[Int(x)].reloadData()
                print("\(x)")
                scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width*CGFloat(x + 2), height: UIScreen.main.bounds.height)
                scrollView.addSubview(names[Int(x)])
                names[Int(x)].topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
                names[Int(x)].leftAnchor.constraint(equalTo: names[Int(x)-1].rightAnchor).isActive = true
                names[Int(x)].widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
                names[Int(x)].heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1).isActive = true
                buttonxConstraint.isActive = false
                
                buttonxConstraint = button.leftAnchor.constraint(equalTo: names[Int(x)].rightAnchor)
                //scrollView.layoutIfNeeded()
                buttonxConstraint.isActive = true
                print("\(x)")
                x += 1
            }
            
            func setupScrollView() {
                
                view.addSubview(scrollView)
//                scrollView.addSubview(leftTableView)
//                scrollView.addSubview(rightTableView)
                _ = names.map({scrollView.addSubview($0)})
                scrollView.addSubview(button)
                scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
                scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
               // scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true//(equalTo: view.widthAnchor,).isActive = true
                scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                
                //names[1]
                names[0].topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
                names[0].leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
                names[0].widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
                names[0].heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1).isActive = true
                names[1].topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
                names[1].leftAnchor.constraint(equalTo: names[0].rightAnchor).isActive = true
                names[1].widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
                names[1].heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1).isActive = true
                button.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
                buttonxConstraint = button.leftAnchor.constraint(equalTo: names[1].rightAnchor)
                buttonxConstraint.isActive = true
                button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
                button.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
             
            }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
                   // leftTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                   // rightTableView.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }

            

             func scrollViewDidScroll(_ scrollView: UIScrollView){

            }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            if tableView == leftTableView {
//                return leftItems.count
//            } else {
//                return rightItems.count
//            }
            if let index = names.firstIndex(of: tableView) {
                return item[index].count
            }
            return 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

//            if tableView == leftTableView {
//                cell.textLabel?.text = "\(leftItems[indexPath.row]) \(indexPath.row)"
//            } else {
//                cell.textLabel?.text = rightItems[indexPath.row]
//            }
            if let index = names.firstIndex(of: tableView) {
                cell.textLabel?.text = "\(item[index][indexPath.row]) \(indexPath.row)"
                //return item[index].count
            }
            return cell
        }
        
        }
        


    extension ViewControllerFive: UITableViewDragDelegate, UITableViewDropDelegate {
        func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
            //var tableViewT = tableView
            var string = ""
            if let index = names.firstIndex(of: tableView) {
                //tableViewT = names[index]
                //guard let str = names[index].cellForRow(at: indexPath)?.textLabel?.text else { return }
                string = "\(names[index].cellForRow(at: indexPath)?.textLabel?.text ?? "")"
            }
            print("\(String(describing: string))")
            //guard let str = string else {return}
        guard let data = string.data(using: .utf8) else { return [] }
        let itemProvider = NSItemProvider(item: data as NSData, typeIdentifier: UTType.plainText.identifier as String)

        return [UIDragItem(itemProvider: itemProvider)]
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        guard let indexTable = names.firstIndex(of: tableView) else {return}
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = names[indexTable].numberOfSections - 1
            let row = names[indexTable].numberOfRows(inSection: section)
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
//                if tableView == self.leftTableView {
//                    self.leftItems.insert(string, at: indexPath.row)
//                } else {
//                    self.rightItems.insert(string, at: indexPath.row)
//                }
                print(string)
                if let index = self.names.firstIndex(of: tableView) {
                    self.item[index].insert(string, at: indexPath.row)
                    
                }
                
                // keep track of this new row
                indexPaths.append(indexPath)
            }

            // insert them all into the table view at once
            self.names[indexTable].insertRows(at: indexPaths, with: .automatic)
        }
    }


    }
