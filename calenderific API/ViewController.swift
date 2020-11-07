//
//  ViewController.swift
//  calenderific API
//
//  Created by MAC on 06/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var listofholiday = [HolidayDetail](){
      didSet {
          DispatchQueue.main.async {
              self.tableView.reloadData()
              self.navigationController?.title = "\(self.listofholiday.count) holidayFiels"
          }
      }
  }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSetup()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    func tblSetup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil ), forCellReuseIdentifier: "TableViewCell")
    }
    
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listofholiday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let holiDay = listofholiday[indexPath.row]
        
        cell.lblTitle.text = holiDay.name
        cell.lblSubTitle.text = holiDay.date.iso
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


extension ViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let Searchtext = searchBar.text else {
            return
        }
        let holidayrequest = HolidayRequest(countryCode: Searchtext)
        holidayrequest.getholidays { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let holiday):
                self?.listofholiday = holiday
            }
        }
        searchBar.returnKeyType = .search
        searchBar.text = ""
    }
    
}
