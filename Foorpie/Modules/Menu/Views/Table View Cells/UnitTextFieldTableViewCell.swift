//
//  UnitTextFieldTableViewCell.swift
//  Foorpie
//
//  Created by Ignacio Paradisi on 9/20/20.
//  Copyright © 2020 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol UnitTextFieldTableViewCellDelegate: class {
    func presentSheet(_ alert: UIAlertController)
}

class UnitTextFieldTableViewCell: TextFieldTableViewCell {
    
    let unitButton = UIButton()
    weak var delegate: UnitTextFieldTableViewCellDelegate?
    
    override func setup() {
        super.setup()
        contentView.addSubview(unitButton)
        unitButton.setTitle(Ingredient.UnitType.unit.abbreviatedText, for: .normal)
        unitButton.setTitleColor(.label, for: .normal)
        textField.anchor.deactivate()
        textField.anchor
            .top(to: titleLabel.bottomAnchor, constant: 5)
            .leadingToSuperview(constant: horizontalMargin)
            .activate()
        unitButton.anchor
            .top(to: textField.topAnchor)
            .bottom(to: textField.bottomAnchor)
            .trailingToSuperview(constant: -horizontalMargin)
            .width(constant: 50)
            .activate()
        unitButton.layer.cornerRadius = 10
        
        if #available(iOS 14.0, *) {
            unitButton.menu = createMenu()
            unitButton.showsMenuAsPrimaryAction = true
        } else {
            unitButton.addTarget(self, action: #selector(createSheetController), for: .touchUpInside)
        }
        textField.anchor.trailing(to: unitButton.leadingAnchor, constant: -10).activate()
        
        
        unitButton.backgroundColor = .tertiarySystemFill
    }
    
    private func createMenu() -> UIMenu {
        var menuActions: [UIAction] = []
        var submenus: [UIMenu] = []
        for (index, unit) in Ingredient.UnitType.allCases.enumerated() {
            let action = UIAction(title: unit.text) { _ in
                self.unitButton.setTitle(unit.abbreviatedText, for: .normal)
            }
            menuActions.append(action)
            if [0, 4, 8, 12].contains(index) {
                submenus.append(UIMenu(title: "", options: .displayInline, children: menuActions))
                menuActions = []
            }
        }
        return UIMenu(title: "", children: submenus)
    }
    
    @objc private func createSheetController() {
        let sheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for unit in Ingredient.UnitType.allCases {
            let action = UIAlertAction(title: unit.text, style: .default) { _ in
                self.unitButton.setTitle(unit.abbreviatedText, for: .normal)
            }
            sheetController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        sheetController.addAction(cancelAction)
        if let popoverController = sheetController.popoverPresentationController {
            popoverController.sourceView = unitButton
            popoverController.sourceRect = unitButton.bounds
        }
        delegate?.presentSheet(sheetController)
    }
}
