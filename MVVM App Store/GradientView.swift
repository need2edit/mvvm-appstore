//
//  GradientView.swift
//  Wallpapers
/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class GradientView: UIView {
  
  lazy fileprivate var gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [UIColor(white: 1.0, alpha: 0.0).cgColor, UIColor(white: 1.0, alpha: 0.75).cgColor]
    layer.locations = [NSNumber(value: 0.0 as Float), NSNumber(value: 1.0 as Float)]
    return layer
    }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.clear
    layer.addSublayer(gradientLayer)
  }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }
  
}
