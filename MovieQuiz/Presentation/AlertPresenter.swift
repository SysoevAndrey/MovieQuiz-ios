//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Andrey Sysoev on 29.09.2022.
//

import Foundation
import UIKit

class AlertPresenter: AlertProtocol {
    private weak var delegate: AlertDelegate?
    
    init(delegate: AlertDelegate?) {
        self.delegate = delegate
    }
    
    func generateContent(for model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .cancel) { _ in
            model.completion()
        }

        alert.addAction(action)

        delegate?.didGenerateAlertContent(alert: alert)
    }
}
