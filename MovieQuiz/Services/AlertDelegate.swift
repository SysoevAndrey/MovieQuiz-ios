//
//  AlertDelegate.swift
//  MovieQuiz
//
//  Created by Andrey Sysoev on 05.10.2022.
//

import Foundation
import UIKit

protocol AlertDelegate: AnyObject {
    func didGenerateAlertContent(alert: UIAlertController)
}
