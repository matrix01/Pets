//
//  WebInfoViewViewController.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import UIKit
import WebKit

class WebInfoViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!

    var viewModel: WebInfoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        guard let url = URL(string: viewModel.descUrl) else {
            return
        }
        webView.load(URLRequest(url: url))
    }

}
