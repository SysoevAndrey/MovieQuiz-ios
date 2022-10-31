import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
    // MARK: - Outlets
    
    @IBOutlet private weak var poster: UIImageView!
    @IBOutlet private weak var questionText: UILabel!
    @IBOutlet private weak var questionCounter: UILabel!
    @IBOutlet private var answerButtons: [UIButton]!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Actions
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
    
    // MARK: - Vars
    
    private var presenter: MovieQuizPresenter!
    private var alert: AlertPresenter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieQuizPresenter(viewController: self)
        
        poster.layer.masksToBounds = true
        
        alert = AlertPresenter(controller: self)
        
        showLoadingIndicator()
    }
    
    // MARK: - Overridden functions
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Public methods
    
    func toggleButtonsEnableProperty(to value: Bool) {
        answerButtons.forEach { $0.isEnabled = value }
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let content = AlertModel(
            title: "Ошибка",
            message: message,
            buttonText: "Попробовать ещё раз") { [weak self] in
                guard let self = self else { return }
                
                self.presenter.loadData()
            }
        
        alert?.showAlert(with: content)
    }
    
    func show(quiz step: QuizStepViewModel) {
        poster.layer.borderWidth = 0
        poster.image = step.image
        questionText.text = step.question
        questionCounter.text = step.questionNumber
        
        toggleButtonsEnableProperty(to: true)
    }
    
    func show(quiz result: QuizResultsViewModel) {
        let content = AlertModel(
            title: result.title,
            message: result.text,
            buttonText: result.buttonText,
            completion: presenter.restartGame)
        
        alert?.showAlert(with: content)
    }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
        poster.layer.borderWidth = 8
        poster.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
    }
}
