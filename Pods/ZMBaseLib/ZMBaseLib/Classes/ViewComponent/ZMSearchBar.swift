//
//  ZMSearchBar.swift
//  CrovAssistant
//
//  Created by zhoumin on 2019/9/26.
//  Copyright © 2019 zhoumin. All rights reserved.
//

import UIKit

open class ZMSearchBar: UIView {
    
    public var searchTextFiled: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        textField.backgroundColor = UIColor.white
        textField.cornerRadius = 5
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.placeholder = "Search"
        textField.returnKeyType = UIReturnKeyType.search
        textField.leftViewMode = .always
        
        let path = Bundle(for: ZMSearchBar.self).path(forResource: "ZMBaseLib", ofType: "bundle") ?? ""
        let bundle = Bundle(path: path)
        
        let searchImage = UIImage(named: "search_icon", in: bundle, compatibleWith: nil)
        let searchImageView = UIImageView(frame: CGRect(x: 5, y: 0, width: 16, height: 16))
        searchImageView.image = searchImage
        
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 26, height: 16))
        searchImageViewWrapper.addSubview(searchImageView)
        textField.leftView = searchImageViewWrapper
        
        return textField
    }()
    
    public var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.isHidden = true
        return cancelButton
    }()
    
    /// 搜索内容
    public var searchText: String {
        get {
            return self.searchTextFiled.text ?? ""
        }
        
        set {
            self.searchTextFiled.text = newValue
        }
    }
    
    public var delegate: ZMSearchBarDelegate?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initView()
    }
    
    open func initView() {
        self.searchTextFiled.delegate = self
        self.addSubview(self.searchTextFiled)
        
        self.cancelButton.addTarget(self, action: #selector(cancelSearch), for: .touchUpInside)
        self.addSubview(self.cancelButton)
        
    }
    
    override open var frame: CGRect {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override open func draw(_ rect: CGRect) {
        self.cancelButton.frame = CGRect(x: self.frame.width - 50, y: 0, width: 50, height: self.frame.height)
        
        if self.cancelButton.isHidden {
            self.searchTextFiled.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }
        else {
            self.searchTextFiled.frame = CGRect(x: 0, y: 0, width: self.frame.width - 50 - 8, height: self.frame.height)
        }
    }
    
    
    @discardableResult override open func becomeFirstResponder() -> Bool {
        self.searchTextFiled.becomeFirstResponder()
        return true
    }
    
    @discardableResult override open func resignFirstResponder() -> Bool {
        self.searchTextFiled.resignFirstResponder()
        return true
    }

    
    @objc func cancelSearch() {
        guard let delegate = self.delegate else { return }
        
        delegate.searchBarCancelButtonClicked?(self)
    }
}

extension ZMSearchBar: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let delegate = self.delegate else {
            return true
        }
        
        return delegate.searchBarShouldBeginEditing?(self) ?? true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let delegate = self.delegate {
            delegate.searchBar?(self, textDidChange: textField.text ?? "")
        }
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let delegate = self.delegate {
            if textField.text != nil && !(textField.text!.isEmpty) {
                delegate.searchBarSearchButtonClicked?(self, searchText: textField.text!)
            }
        }
        
        return true
    }
}

@objc public protocol ZMSearchBarDelegate : UIBarPositioningDelegate {
    
    @objc optional func searchBarCancelButtonClicked(_ searchBar: ZMSearchBar)
    
    @objc optional func searchBarShouldBeginEditing(_ searchBar: ZMSearchBar) -> Bool
    
    @objc optional func searchBar(_ searchBar: ZMSearchBar, textDidChange searchText: String)

    @objc optional func searchBarSearchButtonClicked(_ searchBar: ZMSearchBar, searchText: String)

}
