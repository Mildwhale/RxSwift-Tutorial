//
//  ViewController.swift
//  The Basics
//
//  Created by Wayne Kim on 19/03/2019.
//  https://www.thedroidsonroids.com/blog/ios/rxswift-by-examples-1-the-basics/

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shownCities = [String]()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        
        searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [unowned self] query in
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        
        return cell
    }
}
