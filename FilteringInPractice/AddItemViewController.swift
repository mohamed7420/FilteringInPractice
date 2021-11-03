//
//  AddItemViewController.swift
//  FilteringInPractice
//
//  Created by Mohamed osama on 04/11/2021.
//

import UIKit
import RxSwift

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    private var item = Item()
    private let publishSubject = PublishSubject<Item>()
    var selectedItem: Observable<Item>{
        return publishSubject.asObservable()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        
    }
    

    @IBAction func didSaveAction(_ sender: UIBarButtonItem) {
        addItem()
    }
    
    private func addItem(){
        guard let selectedSize = segmentedControll.titleForSegment(at: segmentedControll.selectedSegmentIndex) , let txt = txtField.text else {return}
        item = Item(txt: txt, sizeType: SizeType(rawValue: selectedSize)!)
        publishSubject.onNext(item)
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
