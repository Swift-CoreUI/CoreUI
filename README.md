# CoreUI

Library to build UI in declarative and functional style. Built on top of UIKit and supports old iOS versions.

```swift
import UIKit
import CoreUI

class MyViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    addSubview(
      UI.VScrollView(
        contentInset: .vertical(12),
        UI.VStack(
          UI.View(backgroundColor: .red, height: 20),
          UI.Label("Are you sure?", font: .systemFont(ofSize: 24), color: .label),
          UI.Spacer(minHeight: 30),
          UI.HStack(
            spacing: 12,
            UI.Button("Yes").apply { $0.addTarget(self, action: #selector(yesTapped), for: .touchUpInside) },
            UI.Button("No").apply { $0.addTarget(self, action: #selector(noTapped), for: .touchUpInside) }
          )
        ),
        .leading(6), .trailing(-6), .safeTop(0), .safeBottom(0)
      )
    )
  }

}
```
