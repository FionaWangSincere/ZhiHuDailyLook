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
    var dataTask: URLSessionDataTask?
    var downLoadTask : URLSessionDownloadTask?
    var tableDataSource = [TableCellModel]()
    let dataSource = ["给我一首歌的时间","你说你不懂我，我为了你牵手","是不是说没没有做完的梦最好","仅仅的拥抱变成永远","故事听到最后才说再见","你说我不该在这时候说了我爱你"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableView()
//        HTTPRequest()
        
//        let urlString = "http://news-at.zhihu.com/api/4/news/latest"
//        let url = urlWithSearchText(searchText: urlString)
//        let jsonString = performStoreRequest(with: url as URL)
////        print("JSON IS \(jsonString)")
//        if let jsonDictionary = parse(json: jsonString!) {
//            print("Dictionary \(jsonDictionary)")
//        }
//        
        
 
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
//        
//        let urlAddress = "http://news-at.zhihu.com/api/4/news/latest"
//        let url = urlWithSearchText(searchText: urlAddress)
//        let session = URLSession.shared
//        self.dataTask = session.dataTask(with: url, completionHandler: {data, reponse, error in
//            
////            if let error = error as? NSError, error.code == -999{
////                return
////            }
//            if let httpRespose = respose as? HTTPURLResponse,httpResponse.statusCode == 200{
//                if let data = data, let jsonDictionary = self.parse(json: data) {
//                    self.searchResults = self.parse(dictionary: jsonDictionary)
//                    self.searchResults.sort(by: <)
//                    
//                    DispatchQueue.main.async {
//                        self.isLoading = false
//                        self.tableView.reloadData()
//                    }
//                    return
//                }
//            } else {
//                print("Failure! \(response)")
//            }
//    
////        if error == nil{
////                do{
////
////                    let responseData:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
////                    
////                    print("code:\(responseData["error_code"])" as Any)
////                    print("结果： \(responseData["reason"])" as Any)
////                }catch{
////                    
////                }
////        }else{
////            print("###FAILD lalalallalal")
////            }
//        })
//        print("###FAILD")
//        dataTask?.resume()
//}
    
    func HTTPRequest(){
        let urlAddress = "http://news-at.zhihu.com/api/4/news/latest"
        let url = urlWithSearchText(searchText: urlAddress)
        // 2
        let session = URLSession.shared
        // 3
        let dataTask = session.dataTask(with: url as URL, completionHandler: {
            data, response, error in
            
                if error == nil{
                    if let jsonResult = self.parse(json: data!){
                        self.tableDataSource = self.paraseDictionary(dic: jsonResult)
                    
                        
                        print("ASynchronous\(jsonResult)")
                    }else{
                    print("******FAILD ")
                }
            }
        })
        // 5
        dataTask.resume()
    }

    func urlWithSearchText(searchText: String) -> NSURL {
        let escapedSearchText = searchText.addingPercentEncoding(
            withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format:escapedSearchText)
        let url = NSURL(string: urlString)
        return url!
    }
    
//    func performStoreRequest(with url: URL) -> String? {
//        do {
//            return try String(contentsOf: url, encoding: .utf8)
//        } catch {
//            print("Download Error: \(error)")
//            return nil
//        }
//    }
    
    func parse(json data: Data) -> [String: Any]? {
//        guard let data = json.data(using: .utf8, allowLossyConversion: false)
//            else { return nil }
        do {
            return try JSONSerialization.jsonObject(
                with: data, options: []) as? [String: Any]
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
     }
    
    func paraseDictionary(dic:[String:Any])->[TableCellModel]{
        if let stories = dic["stories"] as? [String:Any]{
            
            for _ in stories{
                let  tableCellModel = TableCellModel()
                if let title = stories["title"] as? String{
                    tableCellModel.title = title
                }
                if let image = stories["image"] as? String{
                    tableCellModel.image = image
                }
                let result = tableCellModel
                tableDataSource.append(result)
            }
        }
        return tableDataSource 
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedIdentifier, for: indexPath) as! TableViewCell
        
        cell.nameLabel.text = dataSource[indexPath.row]
        
//        let indexpathImage = tableDataSource[indexPath.row].image
//        if let url = URL(String:indexpathImage){
//            downLoadTask = cell.photoImage.loadImage(url: url)
//        }
        
//        if let smallURL = URL(string: searchResult.artworkSmallURL) {
//            downloadTask = artworkImageView.loadImage(url: smallURL)
//        }
        
        
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
