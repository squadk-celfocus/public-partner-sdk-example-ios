//
//  ViewController.swift
//  PartnerIntegration
//
//  Created by Nuno Salvador on 06/11/2020.
//  Copyright © 2020 Celfocus. All rights reserved.
//

import UIKit
import VPartnerLib

protocol HomeController {
    func goHomeController()
}

class ViewController: UIViewController, HomeController {
    var nameDeviceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "VodafoneRg-Bold", size: 30)
        label.numberOfLines = 1
        label.text = "Partner Device"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionDeviceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: "VodafoneRg-Bold", size: 15)
        label.numberOfLines = 1
        label.text = "Serial: UHJ2EVFE676F"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var addDeviceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Add Device", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var manageSubscriptionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Manage Subscriptions", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var theme: Theme = {
        var theme = Theme()
        theme.backgroundColor = UIColor.white.toHexString()
        theme.primaryButtonColorEnabled = UIColor.black.toHexString()
        theme.primaryButtonColorDisabled = UIColor.darkGray.toHexString()
        theme.secondaryButtonColorEnabled = UIColor.white.toHexString()
        theme.secondaryButtonColorDisabled = UIColor.darkGray.toHexString()
        theme.navigationBarTitleTextColor = UIColor.black.toHexString()
        return theme
    }()

    lazy var containerView: UIView = {
        var stack = UIStackView()
        stack.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.2)
        stack = UIStackView(arrangedSubviews: [addDeviceButton, manageSubscriptionButton, logoutButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        addDeviceButton.addTarget(self, action: #selector(addDeviceAction), for: .touchUpInside)
        manageSubscriptionButton.addTarget(self, action: #selector(manageSubscriptionsAction), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutIDTM), for: .touchUpInside)

    }

    func setupView() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)

        view.addSubview(backView)
        backView.addSubview(nameDeviceLabel)
        backView.addSubview(descriptionDeviceLabel)
        backView.addSubview(containerView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backView.topAnchor.constraint(equalTo: view.topAnchor),
            backView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            backView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            
            nameDeviceLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 40),
            nameDeviceLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor),

            descriptionDeviceLabel.topAnchor.constraint(equalTo: nameDeviceLabel.bottomAnchor, constant: 5),
            descriptionDeviceLabel.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func addDeviceAction(sender: UIButton!) {
        let vParnerLib = VPartnerLib.shared
        let partnerCode = "" // e.g. DUMMY_PARTNER
        let productCode = "" // e.g. DUMMY_PARTNER_TRACKER2

        vParnerLib.requiredSetup(clientID: "",
                                 grantID: "",
                                 partnerCode: partnerCode,
                                 productCode: productCode,
                                 appIconName: "") // e.g second_logo

        // Default local theme can be configured
        let designConfiguration = ConfigurationsDesign(theme: theme, screens: nil)
        vParnerLib.configure(designConfig: designConfiguration)

        let destinationVC = vParnerLib.buildAddDeviceViewController()
        destinationVC.modalPresentationStyle = .fullScreen

        present(destinationVC, animated: true, completion: nil)
    }


    @objc func manageSubscriptionsAction(sender: UIButton!) {
        let vParnerLib = VPartnerLib.shared
        let partnerCode = "" // e.g. DUMMY_PARTNER
        let productCode = "" // e.g. DUMMY_PARTNER_TRACKER2

        vParnerLib.requiredSetup(clientID: "",
                                 grantID: "",
                                 partnerCode: partnerCode,
                                 productCode: productCode,
                                 appIconName: "") // e.g second_logo


        let designConfiguration = ConfigurationsDesign(theme: theme, screens: nil)
        vParnerLib.configure(designConfig: designConfiguration)

        let destinationVC = vParnerLib.buildManageSubscriptionsViewController()
        destinationVC.modalPresentationStyle = .fullScreen

        present(destinationVC, animated: true, completion: nil)
    }

    @objc func logoutIDTM() {
        let vParnerLib = VPartnerLib.shared
        vParnerLib.logoutUserFromIDTM { result in
            DispatchQueue.main.async {
                if result {
                    let alert = UIAlertController(title: "Logout Successful", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "IDMT Logout failed", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    func goHomeController() {
        // action to handle in navigation
    }
}
