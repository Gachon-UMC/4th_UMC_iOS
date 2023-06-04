//
//  ImageLoader.swift
//  Practice_2
//
//  Created by YOUJIM on 2023/06/04.
//

import UIKit

class ImageLoader {
    private static let imageCache = NSCache<NSString, UIImage>()
    
    static func loadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        // url이 비어있다면 nil처리
        if url.isEmpty {
            completion(nil)
            return
        }
         
        // URL 형식으로 변환
        let realURL = URL(string: url)!
        
        // 캐시에 있다면 바로 반환
        if let image = imageCache.object(forKey: realURL.lastPathComponent as NSString) {
            print("캐시에 존재")
            // UI는 메인 쓰레드에서 진행
            DispatchQueue.main.async {
                completion(image)
            }
            return
        }
        
        // 캐시에 없다면
        DispatchQueue.global(qos: .background).async {
            print("캐시에 없음")
            // 데이터 타입 변환
            if let data = try? Data(contentsOf: realURL) {
                // 이미지 변환
                let image = UIImage(data: data)!
                // cache에 추가
                self.imageCache.setObject(image, forKey: realURL.lastPathComponent as NSString)
                // UI는 메인 쓰레드에서 진행
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        
    }
}
