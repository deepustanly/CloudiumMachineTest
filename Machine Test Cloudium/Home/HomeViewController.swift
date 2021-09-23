//
//  ViewController.swift
//  Machine Test Cloudium
//
//  Created by Deepu Stanly on 21/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var newsListingTableView: UITableView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
        
    var homeViewModel: HomeViewModel! {
        didSet {
            homeViewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel()
        setUpViews()
    }
    
    func setUpViews() {
        title = homeViewModel.title
        newsListingTableView.register(UINib(nibName: homeViewModel.cellName, bundle: nil), forCellReuseIdentifier: homeViewModel.reuseIdentifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == homeViewModel.segue, let row = sender as? Int {
            let newsDetailsVC = segue.destination as? NewsDetailsViewController
            newsDetailsVC?.news = self.homeViewModel.newsAt(index: row)
        }
    }

}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeViewModel.reuseIdentifier, for: indexPath) as! NewsTableViewCell
        cell.fillData(newsData: self.homeViewModel.newsAt(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: homeViewModel.segue, sender: indexPath.row)
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    
    func didFailFetch(message: String) {
        print(message)
    }
    
    func didFetchResults() {
        newsListingTableView.reloadData()
    }
    
}
