//
//  TxLoading.swift
//  TxDesignSystem
//
//  Created by doandat on 12/4/25.
//

import UIKit

public extension TxLoading {
    class func dismiss() {
        DispatchQueue.main.async {
            shared.dismissHUD()
        }
    }

    class func show() {
        DispatchQueue.main.async {
            shared.setup()
        }
    }
}

// MARK: - TxLoading
public class TxLoading: UIView {
    private var viewBackground: UIView?
    private(set) var loadingView = TxLoadingUIView()

    private var colorBackground = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

    static let shared: TxLoading = {
        let instance = TxLoading()
        return instance
    }()

    private convenience init() {
        self.init(frame: UIScreen.main.bounds)
        self.alpha = 0
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override private init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        setupBackground()
        setupToolbar()
    }
}

private extension TxLoading {
    private func setup() {
        setupBackground()
    }
}

// MARK: - Background View

private extension TxLoading {
    private func removeBackground() {
        viewBackground?.removeFromSuperview()
        viewBackground = nil
    }

    private func setupBackground() {
        guard let mainWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene }) // Lọc các UIWindowScene
            .flatMap({ $0.windows }) // Lấy danh sách các cửa sổ
            .first(where: { $0.isKeyWindow }) // Tìm key window
        else {
            return
        }

        if viewBackground == nil {
            viewBackground = UIView(frame: mainWindow.frame)
            viewBackground?.backgroundColor = colorBackground
        }
        viewBackground?.removeFromSuperview()
        viewBackground?.translatesAutoresizingMaskIntoConstraints = false
        mainWindow.addSubview(viewBackground!)
        NSLayoutConstraint.activate([
            viewBackground!.leadingAnchor.constraint(equalTo: mainWindow.leadingAnchor),
            viewBackground!.trailingAnchor.constraint(equalTo: mainWindow.trailingAnchor),
            viewBackground!.topAnchor.constraint(equalTo: mainWindow.topAnchor),
            viewBackground!.bottomAnchor.constraint(equalTo: mainWindow.bottomAnchor)
        ])

    }
}

private extension TxLoading {
    private func setupToolbar() {
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        guard let viewBackground else { return }
        viewBackground.addSubview(loadingView)
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: viewBackground.centerYAnchor)
        ])
    }
}

private extension TxLoading {
    private func dismissHUD() {
        viewBackground?.removeFromSuperview()
    }
}
