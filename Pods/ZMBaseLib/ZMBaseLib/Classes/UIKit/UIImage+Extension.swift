//
//  UIImage+Extension.swift
//  KeychainSwift
//
//  Created by zhoumin on 2019/8/16.
//

import Foundation

public extension UIImage {
    
    /// 初始化颜色背景图片
    ///
    /// - Parameters:
    ///   - color: 图片验收
    ///   - size: 图片大小
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)) {
        UIGraphicsBeginImageContext(size)

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: CGPoint.zero, size: size))
        context?.setShouldAntialias(true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let cgImage = image?.cgImage

        if cgImage == nil {
            self.init()
        }
        else {
            self.init(cgImage: cgImage!)
        }
    }
    
    /// 图片相互添加
    ///
    /// - Parameters:
    ///   - smallImage: 子图片
    ///   - origin: 位置
    /// - Returns: 新图片
    func add(smallImage: UIImage, origin:CGPoint) -> UIImage {
        let scale = UIScreen.main.scale
        
        let size = CGSize(width: self.size.width*scale, height: self.size.height*scale)
        UIGraphicsBeginImageContext(size)
        
        // Draw image
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        smallImage.draw(in: CGRect(x: origin.x*scale, y: origin.y*scale, width: smallImage.size.width*scale, height: smallImage.size.height*scale))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        let cgImage = image?.cgImage
        if cgImage == nil {
            return self
        }
        
        return UIImage(cgImage: cgImage!, scale: scale, orientation: self.imageOrientation)
    }
}


// MARK: 图片缩放
public extension UIImage {
    
    func scaleTo(size targetSize: CGSize) -> UIImage {
        let srcSize = self.size
        if __CGSizeEqualToSize(srcSize, targetSize) {
            return self
        }
        
        let scaleRatio = targetSize.width / srcSize.width
        var dstSize = CGSize(width: targetSize.width, height: targetSize.height)
        let orientation = self.imageOrientation
        var transform = CGAffineTransform.identity
        switch orientation {
            case .up:
                transform = CGAffineTransform.identity
            case .upMirrored:
                transform = CGAffineTransform(translationX: srcSize.width, y: 0.0)
                transform = transform.scaledBy(x: -1.0, y: 1.0)
            case .down:
                transform = CGAffineTransform(translationX: srcSize.width, y: srcSize.height)
                transform = transform.scaledBy(x: 1.0, y: CGFloat(Double.pi))
            case .downMirrored:
                transform = CGAffineTransform(translationX: 0.0, y: srcSize.height)
                transform = transform.scaledBy(x: 1.0, y: -1.0)
            case .leftMirrored:
                dstSize = CGSize(width: dstSize.height, height: dstSize.width)
                transform = CGAffineTransform(translationX: srcSize.height, y: srcSize.width)
                transform = transform.scaledBy(x: -1.0, y: 1.0)
                transform = transform.rotated(by: CGFloat(3.0) * CGFloat(Double.pi/2.0))
            case .left:
                dstSize = CGSize(width: dstSize.height, height: dstSize.width)
                transform = CGAffineTransform(translationX: 0.0, y: srcSize.width)
                transform = transform.rotated(by: CGFloat(3.0) * CGFloat(Double.pi/2.0))
            case .rightMirrored:
                dstSize = CGSize(width: dstSize.height, height: dstSize.width)
                transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                transform = transform.rotated(by:  CGFloat(Double.pi/2.0))
            default:
                dstSize = CGSize(width: dstSize.height, height: dstSize.width)
                transform = CGAffineTransform(translationX: srcSize.height, y: 0.0)
                transform = transform.rotated(by:  CGFloat(Double.pi/2.0))
        }
        
        guard let cgImage = self.cgImage else {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(dstSize, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setShouldAntialias(true)
        if orientation == UIImage.Orientation.right || orientation == UIImage.Orientation.left {
            context?.scaleBy(x: -scaleRatio, y: scaleRatio)
            context?.translateBy(x: -srcSize.height, y: 0)
        }
        else {
            context?.scaleBy(x: scaleRatio, y: -scaleRatio)
            context?.translateBy(x: 0, y: -srcSize.height)
        }
        context?.concatenate(transform)
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: srcSize.width, height: srcSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image == nil {
            return self
        }
        else {
            return image!
        }
    }
    
    func scaleTo(fitSize targetSize: CGSize, scaleIfSmaller: Bool = false) -> UIImage? {
        let srcSize = self.size
        if __CGSizeEqualToSize(srcSize, targetSize) {
            return self
        }
        
        let orientation = self.imageOrientation
        var dstSize = targetSize
        switch orientation {
            case .left, .right, .leftMirrored, .rightMirrored:
                dstSize = CGSize(width: dstSize.height, height: dstSize.width)
            default:
                break
        }
        
        if !scaleIfSmaller && (srcSize.width < dstSize.width) && (srcSize.height < dstSize.height) {
            dstSize = srcSize
        }
        else {
            let wRatio = dstSize.width / srcSize.width
            let hRatio = dstSize.height / srcSize.height
            dstSize = wRatio < hRatio ?
                CGSize(width: dstSize.width, height: srcSize.height * wRatio) :
                CGSize(width: srcSize.width * wRatio, height: dstSize.height)
        }
        
        return self.scaleTo(size: dstSize)
    }
    
    
    func fixOrientation() -> UIImage {
        
        guard imageOrientation != .up else {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch imageOrientation {
            
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2)
            break
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -(CGFloat.pi / 2))
            break
            
        default:
            break
        }
        
        switch imageOrientation {
            
        case .upMirrored, .downMirrored:
            transform.translatedBy(x: size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
            
        case .leftMirrored, .rightMirrored:
            transform.translatedBy(x: size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
            
        default:
            break
        }
        
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
            break
            
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        let cgImage: CGImage = ctx.makeImage()!
        
        return UIImage(cgImage: cgImage)
    }
}
