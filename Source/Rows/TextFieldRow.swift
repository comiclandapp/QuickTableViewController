//
//  TextFieldRow.swift
//  QuickTableViewController-iOS
//
//  Created by Antonio Montes on 3/25/20.
//  Copyright © 2020 bcylin. All rights reserved.
//

import UIKit

/// A class that represents a row with a UITextField.
open class TextFieldRow<T: TextFieldCell>: TextFieldRowCompatible, Equatable {

    public var customize: ((UITableViewCell, any Row & RowStyle) -> Void)?
    
    // MARK: - Initializer

    /// Initializes a `TextFieldRow` with a title, a TextField value, and an action closure.
    /// The detail text, placeholder, keyboard type, icon and the customization closure are optional.
    public init(
        text: String,
        detailText: DetailText? = nil,
        textFieldValue: String,
        placeholder: String = "",
        keyboardType: UIKeyboardType = .default,
        icon: Icon? = nil,
        action: ((Row) -> Void)?
    ) {
        self.text = text
        self.detailText = detailText
        self.textFieldValue = textFieldValue
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.icon = icon
        self.action = action
    }

    // MARK: - TextFieldRowCompatible

    /// The value of the text field.
    public var textFieldValue: String = "" {
        didSet {
            guard textFieldValue != oldValue else {
                return
            }
            DispatchQueue.main.async {
                self.action?(self)
            }
        }
    }

    /// The value of the placeholder text.
    public var placeholder: String

    /// The keyboard type.
    public var keyboardType: UIKeyboardType

    // MARK: - Row

    /// The text of the row.
    public let text: String

    /// The detail text of the row.
    public let detailText: DetailText?

    /// A closure that will be invoked when the `textFieldValue` is changed.
    public let action: ((Row) -> Void)?

    // MARK: - RowStyle

    /// The type of the table view cell to display the row.
    public let cellType: UITableViewCell.Type = T.self

    /// The reuse identifier of the table view cell to display the row. The default value is **TextFieldCell**.
    public let cellReuseIdentifier: String = T.reuseIdentifier

    /// The cell style is `.subtitle`.
    public let cellStyle: UITableViewCell.CellStyle = .subtitle

    /// The icon of the row.
    public let icon: Icon?

    /// The default accessory type is `.none`.
    public let accessoryType: UITableViewCell.AccessoryType = .none

    /// The `TextFieldRow` should not be selectable.
    public let isSelectable: Bool = false

    /// The additional customization during cell configuration.
    //public let customize: ((UITableViewCell, Row & RowStyle) -> Void)?

    // MARK: - Equatable

    /// Returns true iff `lhs` and `rhs` have equal titles, textField values, and icons.
    public static func == (lhs: TextFieldRow, rhs: TextFieldRow) -> Bool {
    return
        lhs.text == rhs.text &&
        lhs.textFieldValue == rhs.textFieldValue &&
        lhs.placeholder == rhs.placeholder &&
        lhs.keyboardType == rhs.keyboardType &&
        lhs.icon == rhs.icon
    }
}
