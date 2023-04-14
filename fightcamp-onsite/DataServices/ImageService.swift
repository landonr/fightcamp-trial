//
//  ImageService.swift
//  FightCamp-Homework-UIKit
//
//  Created by Landon Rohatensky on 2023-03-16.
//  Copyright © 2023 Alexandre Marcotte. All rights reserved.
//

import UIKit

class ImageService {
    private static func saveImage(image: UIImage, url: URL) {
        // https://stackoverflow.com/questions/37344822/saving-image-and-then-loading-it-in-swift-ios
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return
        }
        do {
            try data.write(to: directory.appendingPathComponent(url.lastPathComponent)!)
            print("saved image to cache")
            return
        } catch {
            print(error.localizedDescription)
            return
        }
    }
    
    static func getImageFromCache(url: URL) -> UIImage? {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return nil
        }
        do {
            let data = try Data(contentsOf: directory.appendingPathComponent(url.lastPathComponent)!)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
    
    static func getImage(url: URL) async throws -> UIImage? {
        if let image = getImageFromCache(url: url) {
            print("got image from cache")
            return image
        }
        let data = try Data(contentsOf: url)
        let image = UIImage(data: data)
        if let image = image {
            saveImage(image: image, url: url)
        }
        return image
    }
}
