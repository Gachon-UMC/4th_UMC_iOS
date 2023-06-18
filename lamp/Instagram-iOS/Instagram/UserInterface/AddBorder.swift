//
//  AddBorder.swift
//  Instagram
//
//  Created by 박민서 on 2023/06/17.
//
import UIKit

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat, set: String = "Normal") {
        for edge in arr_edge {
            let border = CALayer()
            border.name = name ?? edge.rawValue.description
            switch edge {
                        case UIRectEdge.top:
                            border.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: width)
                            break
                        case UIRectEdge.bottom:
                            if set == "Normal" {
                                    border.frame = CGRect.init(x: 0, y: frame.height - width, width: self.bounds.width, height: width)
                            } else if set == "textfield" {
                                border.frame = CGRect.init(x: 0, y: frame.height - width + 10, width: self.bounds.width - 20, height: width)
                            } else if set == "StoryCollection" {
                                border.frame = CGRect.init(x: 0, y: frame.height - width - 10, width: self.bounds.width, height: width)
                            }
                            break
                        case UIRectEdge.left:
                            border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                            break
                        case UIRectEdge.right:
                            border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                            break
                        default:
                            break
                        }
            border.backgroundColor = color.cgColor;
                        self.addSublayer(border)
        }
    }
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat, name: String) {
        for edge in arr_edge {
            let border = CALayer()
            border.name = name //?? edge.rawValue.description
            switch edge {
                        case UIRectEdge.top:
                            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                            break
                        case UIRectEdge.bottom:
                            if name == "firstBorder" {
                                    border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width/2, height: width)
                            } else if name == "secondBorder" {
                                border.frame = CGRect.init(x: frame.width/2, y: frame.height - width, width: self.bounds.width - 20, height: width)
                            }
                            break
                        case UIRectEdge.left:
                            border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                            break
                        case UIRectEdge.right:
                            border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                            break
                        default:
                            break
                        }
            border.backgroundColor = color.cgColor;
                        self.addSublayer(border)
        }
    }
}
