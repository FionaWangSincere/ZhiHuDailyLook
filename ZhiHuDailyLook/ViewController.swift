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
//       httpRequest()
        
        let urlString = "http://news-at.zhihu.com/api/4/news/latest"
        let url = urlWithSearchText(searchText: urlString)
        let jsonString = performStoreRequest(with: url as URL)
//        print("JSON IS \(jsonString)")
        if let jsonDictionary = parse(json: jsonString!) {
            print("Dictionary \(jsonDictionary)")
        }
        
        
 
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
    
    // http
//    func httpRequest(){
//        let url: NSURL = NSURL(string: "http://news-at.zhihu.com/api/4/news/latest")!
//        let request = URLRequest(url: url as URL)
//        let configeration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configeration)
//        
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: {
//            data, response, error in
//    
//        if error == nil{
//                do{
//                    
//                    let responseData:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
//                    
//                    print("code:\(responseData["error_code"])" as Any)
//                    print("结果： \(responseData["reason"])" as Any)
//                }catch{
//                    
//                }
//        }else{
//            print("###FAILD lalalallalal")
//            }
//        })
//        print("###FAILD")
//        dataTask.resume()
//}

    func urlWithSearchText(searchText: String) -> NSURL {
        let escapedSearchText = searchText.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format:escapedSearchText)
        let url = NSURL(string: urlString)
        return url!
    }
    
    func performStoreRequest(with url: URL) -> String? {
        do {
            return try String(contentsOf: url, encoding: .utf8)
        } catch {
            print("Download Error: \(error)")
            return nil
        }
    }
    
    func parse(json: String) -> [String: Any]? {
        guard let data = json.data(using: .utf8, allowLossyConversion: false)
            else { return nil }
        do {
            return try JSONSerialization.jsonObject(
                with: data, options: []) as? [String: Any]
        } catch {
            print("JSON Error: \(error)")
            return nil
        } }
    
    
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
