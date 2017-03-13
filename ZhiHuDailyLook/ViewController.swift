//
//  ViewController.swift
//  ZhiHuDailyLook
//
//  Created by babykang on 2017/3/13.
//  Copyright © 2017年 babykang. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController

{

    let color = [UIColor.yellow, UIColor.red, UIColor.blue, UIColor.green, UIColor.purple, UIColor.brown, UIColor.darkGray]
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let reusedIdentifier = "TableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableView()
//        getHTTPRequest()
        
        
 
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTableView(){
        self.tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: reusedIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 100
        self.tableView.separatorStyle = .none
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
    //    func getHTTPRequest(){
//        let url = URL(string: "http://news-at.zhihu.com/api/4/news/latest")
//        let request = URLRequest(url: url!)
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration)
//    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedIdentifier, for: indexPath) as! TableViewCell
        cell.nameLabel.text = "hahahahahhah"
        cell.photoImage.backgroundColor = UIColor.blue
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return color.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        collectionCell.backgroundColor = color[indexPath.row]
        return collectionCell
    }
    
}
