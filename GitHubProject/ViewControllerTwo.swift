//
//  ViewControllerTwo.swift
//  GitHubProject
//
//  Created by Alexander Avdacev on 17.04.22.
//

import UIKit

import UIKit
class ViewControllerTwo: UIViewController, UIScrollViewDelegate {

    var scrollView = UIScrollView()
    let contentView = UIView()
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Plus", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var x: Float = 2.0 {
        didSet{
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupViews()
       // scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.backgroundColor = .red
        button.addTarget(self, action: #selector(plus), for: .touchUpInside)
    }

    @objc func plus() {
    x += 1
        print("\(x)")
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width*CGFloat(x), height: UIScreen.main.bounds.height)
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
       scrollView.showsHorizontalScrollIndicator = true
       scrollView.showsVerticalScrollIndicator = true
        scrollView.indicatorStyle = .black
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width*CGFloat(x), height: UIScreen.main.bounds.height)
        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       // scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true//(equalTo: view.widthAnchor,).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

//        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
//        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.numberOfLines = 0
      //  label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
        label.numberOfLines = 0
     //   label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupViews(){
        scrollView.addSubview(titleLabel)
//
//        titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//        //titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 3/4).isActive = true
//
        scrollView.addSubview(subtitleLabel)
//
//        subtitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25).isActive = true
//       // subtitleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 3/4).isActive = true
//        subtitleLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollView.addSubview(button)
        button.leftAnchor.constraint(equalTo: subtitleLabel.leftAnchor).isActive = true
        button.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 25).isActive = true
    }

     func scrollViewDidScroll(_ scrollView: UIScrollView){

    }
}
//class ViewControllerTwo: UIViewController {
/////class ViewController: UIViewController {
//
//  var scrollView: UIScrollView!
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Set the scrollView's frame to be the size of the screen
//    scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//    scrollView.backgroundColor = .systemTeal
//    // Set the contentSize to 100 times the height of the phone's screen so that we can add 100 images in the next step
//      scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width*2, height: UIScreen.main.bounds.height*2)
//    view.addSubview(scrollView)
//  }
//}
