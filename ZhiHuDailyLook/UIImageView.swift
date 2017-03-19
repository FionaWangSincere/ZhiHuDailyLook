//
//  UIImageView.swift
//  ZhiHuDailyLook
//
//  Created by babykang on 2017/3/18.
//  Copyright © 2017年 babykang. All rights reserved.
//

import UIKit

//class UIImageView: UIImageView {
//
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//}

extension UIImageView{
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        // 1
        let downloadTask = session.downloadTask(with: url,
                                                // 2
            completionHandler: { [weak self] url, response, error in
                if error == nil, let url = url,
                    let data = try? Data(contentsOf: url),
                    // 3
                    // 4
                    let image = UIImage(data: data) {
                }
            })
        // 5
        downloadTask.resume()
        return downloadTask
    }
}
