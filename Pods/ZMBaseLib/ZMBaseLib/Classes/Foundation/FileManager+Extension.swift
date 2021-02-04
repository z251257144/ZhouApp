//
//  FileManager+Extension.swift
//  ZMBaseLib
//
//  Created by ZhouMin on 2019/8/21.
//

import Foundation

/// App documents directory
public let appDocumentsFolder: String? = {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
    return paths.first
}()

/// app library directory
public let appLibraryFolder: String? = {
    let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) as [String]
    return paths.first
}()

/// app caches directory
public let appCachesFolder: String? = {
    let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
    return paths.first
}()

public let sFileManager = FileManager.default

public extension FileManager {
    
    /// 将文件名称转换为document目录下完整路径
    /// e.g. "mycache/user/icon.png" -> "/Users/zmsouljun/Library/Application Support/iPhone Simulator/7.1/Applications/ABCE2119-E864-4492-A3A9-A238ADA74BE5/Documents/mycache/user/icon.png".
    /// - Parameter string: 文件名称
    /// - Returns: 完整路径
    func documentFullDirectory(_ string: String) -> String? {
        guard let documentDirectory = appDocumentsFolder else { return nil }
        return URL(fileURLWithPath: documentDirectory).appendingPathComponent(string).path
    }
    
    /// 判断文件是否存在
    /// e.g. "mycache/user/icon.png"
    /// - Parameter fileName: 文件名称
    /// - Returns: 判断结果
    func fileIsExists(_ fileName: String) -> Bool {
        guard let filePath = self.documentFullDirectory(fileName) else { return false }
        
        return self.fileExists(atPath: filePath)
    }
    
    /// 创建文件夹
    /// e.g. "mycache/user"，如果存在就跳过
    /// - Parameter folderName: 文件夹
    func createFolder(_ folderName: String) {
        //create file directory, include multilayer directory
        guard let fullDir = self.documentFullDirectory(folderName) else { return }
            
        if !self.fileIsExists(fullDir) {
            do {
                try self.createDirectory(atPath: fullDir, withIntermediateDirectories: true, attributes: nil)
                logging("create file \(folderName)")
            }
            catch {
                logging("createFolder \(folderName) 失败")
                logging(error)
            }
        }
    }
    
    /// 创建文件
    /// e.g. "mycache/user/icon.png".
    /// - Parameters:
    ///   - fileName: 文件名称
    ///   - overwrite: 是否覆盖
    func createFile(_ fileName: String, overwrite: Bool = false) {
        //create file directory, include multilayer directory
        let lastTag : String.Index? = fileName.lastIndex(of: "/")
        logging(lastTag)
        if lastTag != nil {
            let directory = fileName[..<lastTag!]
            self.createFolder(String(directory))
        }
        
        //file not exists or want to overwrite it
        if overwrite || !self.fileIsExists(fileName) {
            guard let path = self.documentFullDirectory(fileName) else { return }
            let suc = self.createFile(atPath: path, contents: nil, attributes: nil)
            logging("create file \(fileName) \(suc)")
        }
    }

    /// 删除文件夹
    ///
    /// - Parameter folderName: 文件
    func deleteAllFiles(_ folderName: String) {
        guard let fullDir = self.documentFullDirectory(folderName) else { return }
        
        do {
            let files = try self.contentsOfDirectory(atPath: fullDir)
            let fullDirUrl = URL(fileURLWithPath: fullDir)
            
            for file in files {
                let fileUrl = fullDirUrl.appendingPathComponent(file)
                try self.removeItem(at: fileUrl)
            }
        }
        catch {
            logging(error)
        }
    }
}
