import UIKit

@available(iOS 14.0, *)
public extension UIControl {

    /// Adds `action` block to `self` to run for specified `event`.
    ///
    /// - Parameters:
    ///   - event: UIControl.Event to react on
    ///   - action: block to run for `event`
    /// - Returns: self
    func on(_ event: UIControl.Event, do action: @escaping () -> Void) -> Self {
        addAction(
            UIAction { _ in
                action()
            },
            for: event
        )
        return self
    }

    /// Adds async `action` block to `self` to run for specified `event`.
    ///
    /// - Parameters:
    ///   - event: UIControl.Event to react on
    ///   - action: async block to run for `event`
    /// - Returns: self
    ///
    /// Action will be started concurrently in cooperative thread pool. It would not inherit parent's actor.
    /// If you need to run block's code with specific actor/queue you should take care of it by yourself.
    /// E.g. if you'll need to run some code on MainActor you should wrap it with `MainActor.run` or annotate function called from block with @MainActor.
    /// 
    /// NB: Adding @MainActor annotation to `action` block will be not enough!
    ///
    /// # Example:
    ///
    ///     // MyViewController
    ///     override func viewDidLoad() {
    ///         // ...
    ///         addSubview(
    ///             UI.VStack(
    ///                 UIButton()
    ///                     .apply { $0.setTitle("First button", for: .normal) }
    ///                     .on(.touchUpInside, do: viewModel.firstButtonTapped),
    ///                 UIButton()
    ///                     .apply { $0.setTitle("Second button", for: .normal) }
    ///                     .on(.touchUpInside) { [unowned self] in await viewModel.secondButtonTapped() }
    ///             ),
    ///             padding: 20
    ///         )
    ///         // ...
    ///     }
    ///
    ///     // MyViewModel
    ///     @MainActor
    ///     func firstButtonTapped() async {
    ///         // code from this funciton will run on MainActor
    ///     }
    ///
    ///     func secondButtonTapped() async {
    ///         // following code will NOT run on MainActor
    ///         doSomethingSync()
    ///         await doSomethingAsync()
    ///
    ///         await MainActor.run {
    ///             updateUI() // syncronous func will run on MainActor
    ///         }
    ///     }
    ///
    func on(_ event: UIControl.Event, do action: @escaping () async -> Void) -> Self {
        addAction(
            UIAction { _ in
                Task {
                    // NB: action does not run on MainActor!
                    await action()
                }
            },
            for: event
        )
        return self
    }

}
