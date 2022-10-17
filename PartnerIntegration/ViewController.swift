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
    
    var addDeviceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Add Device", for: .normal)
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

    lazy var containerView: UIView = {
        var stack = UIStackView()
        stack.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.2)
        stack = UIStackView(arrangedSubviews: [addDeviceButton, manageSubscriptionButton])
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
    }

    func setupView() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)

        view.addSubview(backView)
        backView.addSubview(nameDeviceLabel)
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
            
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func addDeviceAction(sender: UIButton!) {
        let vPartnerLib = VPartnerLib.shared
        let partnerCode = "" // e.g. DUMMY_PARTNER
        let partnerPassword = "" // Password sent by Vodafone
        let productCode = "" // e.g. DUMMY_PARTNER_TRACKER2
        let appIconName = "emptyLogo" // default emptyLogo
        let sponsorIconName = "vodafoneLogo" // default vodafoneLogo
        let locale: String? = nil // Country code used for Terms & Conditions/Privacy & Policy URLs, before the IDTM Login (OPTIONS: uk, de, es, it, za) (default nil = SIM card locale)

        vPartnerLib.requiredSetup(partnerPassword: partnerPassword,
                                 partnerCode: partnerCode,
                                 productCode: productCode,
                                 appIconName: appIconName,
                                 sponsorIconName: sponsorIconName,
                                 locale: locale)

        vPartnerLib.addDevice(vc: self) { value in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Onboarding status: \(value)", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }


    @objc func manageSubscriptionsAction(sender: UIButton!) {
        let vPartnerLib = VPartnerLib.shared
        let partnerCode = "" // e.g. DUMMY_PARTNER
        let partnerPassword = "" // Password sent by Vodafone
        let productCode = "" // e.g. DUMMY_PARTNER_TRACKER2
        let appIconName = "emptyLogo" // default emptyLogo
        let sponsorIconName = "vodafoneLogo" // default vodafoneLogo
        

        vPartnerLib.requiredSetup(partnerPassword: partnerPassword,
                                 partnerCode: partnerCode,
                                 productCode: productCode,
                                 appIconName: appIconName,
                                 sponsorIconName: sponsorIconName,
                                 locale: nil)

        vPartnerLib.manageSubscriptions(vc: self)
    }

    func goHomeController() {
        // action to handle in navigation
    }
}
