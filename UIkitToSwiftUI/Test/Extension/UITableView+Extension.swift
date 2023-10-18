//
//  UITableView+Extension.swift
//  Test
//
//  Created by Thanh Duy on 14/09/2023.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(of type: T.Type = T.self,
                                indexPath: IndexPath) -> T? {
        let cell = dequeueReusableCell(withIdentifier: NSStringFromClass(type.self),
                                       for: indexPath) as? T

        return cell
    }

    func register<T: UITableViewCell>(of type: T.Type = T.self) {
        register(type.self, forCellReuseIdentifier: NSStringFromClass(type.self))
    }
}
