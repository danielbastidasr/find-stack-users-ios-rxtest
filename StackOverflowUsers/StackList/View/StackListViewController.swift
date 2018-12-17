//
//  ViewController.swift
//  StackOverflowUsers
//
//  Copyright © 2018 Daniel Bastidas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StackListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak private var tableList: UITableView!
    
    var viewModel:StackUsersViewModeling!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        viewModel.initialise()
        bindViewModelInput()
        bindViewModelOutput()
    }
    
    // MARK: - Bind ViewModel - Input to View
    private func bindViewModelInput(){
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        tableList.rx.itemSelected
            .map{$0.row}
            .bind(to: viewModel.cellDidSelect)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Bind ViewModel - OutPut to View
    private func bindViewModelOutput(){
        viewModel.cellModels.bind(to: tableList.rx.items(
            cellIdentifier: "StackCell" ,
            cellType: StackUserCell.self)){
                i, cellModel, cell in
                cell.viewModel = cellModel
            }.disposed(by: disposeBag)
    }
}
extension StackListViewController: UITableViewDelegate, UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar .resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
