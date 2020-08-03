//
//  PetsViewController.swift
//  Pets
//
//  Created by milan.mia on 7/28/20.
//  Copyright © 2020 milan. All rights reserved.
//

import UIKit

class PetsViewController: UIViewController {

    @IBOutlet private weak var topHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topActionView: UIView!
    @IBOutlet private weak var officeHoursLabel: UILabel!
    @IBOutlet private weak var officeHoursContainer: UIView!
    @IBOutlet private weak var chatCallStack: UIStackView!
    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = PetsViewControllerModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PetCell", bundle: nil), forCellReuseIdentifier: PetCell.reuseIdentifier)

        viewModel.getConfig {[weak self] in
            DispatchQueue.main.async {
                self?.updateConfig()
            }
        }

        viewModel.getPets {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func updateConfig() {
        officeHoursLabel.text = viewModel.officeHours

        //considering top veiw height is 90 as height is not mentioned in the desing
        topHeightConstraint.constant = viewModel.showTopView ? 90 : 0
        officeHoursContainer.setBorder(with: .lightGray, borderWidth: 1.0)

        configButtons()
    }

    private func configButtons() {
        chatCallStack.removeAllViews()
        let chatButton = Button(style: .chat, text: "Chat", corner: 8.0, tag: BtnType.chat.rawValue)
        let callButton = Button(style: .call, text: "Call", corner: 8.0, tag: BtnType.call.rawValue)

        if viewModel.isChatEnabled {
            chatCallStack.addArrangedSubview(chatButton)
        }
        if viewModel.isCallEnabled {
            chatCallStack.addArrangedSubview(callButton)
        }

        let numOfBtn = viewModel.isChatEnabled.intValue + viewModel.isCallEnabled.intValue

        if numOfBtn > 1 {
            chatCallStack.spacing = 10
        }

        chatButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
    }

    @objc func buttonAction(sender: Button) {
        let alert = Alert.create(message: viewModel.messageToShow())
        self.present(alert, animated: true, completion: nil)
    }
}

extension PetsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PetCell.reuseIdentifier,
                                                       for: indexPath) as? PetCell else {
                                                        return UITableViewCell()
        }
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let webViewController = UIStoryboard.stwithName(name: "Pets").instantiateViewController(withIdentifier: "WebView") as? WebInfoViewController else {return}
        webViewController.viewModel = viewModel.webViewModel(index: indexPath.row)
        self.present(webViewController, animated: true, completion: nil)
    }
}
