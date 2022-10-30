//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by Andrey Sysoev on 29.10.2022.
//

protocol MovieQuizViewControllerProtocol: AnyObject {
    func toggleButtonsEnableProperty(to value: Bool)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
    
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func highlightImageBorder(isCorrectAnswer: Bool)
}
