//
//  ViewController.swift
//  FilteringInPractice
//
//  Created by Mohamed osama on 03/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var items = BehaviorRelay(value: [Item]())
    lazy var values: [Item] = {
        return items.value
    }()

    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filteredSegementedControll: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
        if let navVC = segue.destination as? UINavigationController , let vc = navVC.viewControllers.first as? AddItemViewController{
            vc.selectedItem.subscribe(onNext: {
                self.values.append($0)
                self.items.accept(self.values)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
        }
    }
    
    //MARK:- IBActions
    @IBAction func didSegementedAction(_ sender: UISegmentedControl) {
        guard let selectedSize = sender.titleForSegment(at: filteredSegementedControll.selectedSegmentIndex - 1) else {return}
        applyFiltering(selectedSize, index: sender.selectedSegmentIndex)
    }
    
    
    private func applyFiltering(_ text: String = "All" , index: Int ){
        items.filter { items in
            print(items[index].sizeType?.rawValue)
            return items[index].sizeType?.rawValue == text
        }.subscribe(onNext:{
            print($0)
        }).disposed(by: disposeBag)
    }
    
    
}

//MARK:- TableViewDelegate
extension ViewController: UITableViewDelegate , UITableViewDataSource{
    
    fileprivate func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
            fatalError()
        }
        
        cell.textLabel?.text = values[indexPath.row].txt
        cell.detailTextLabel?.text = values[indexPath.row].sizeType?.rawValue.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }

}

