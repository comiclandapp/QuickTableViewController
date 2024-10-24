//
//  TextFieldCell.swift
//  QuickTableViewController
//
//  Created by Antonio Montes on 3/25/20.
//  Copyright © 2020 bcylin. All rights reserved.

import UIKit

/// The `TextFieldCellDelegate` protocol allows the adopting delegate to respond to the UI interaction.
public protocol TextFieldCellDelegate: AnyObject {

    /// Tells the delegate that the textField control has new text.
    func textFieldCell(_ cell: TextFieldCell,
                       textFieldDidChange text: String)
}

/// A `UITableViewCell` subclass that shows a `UITextField` as the `accessoryView`.
open class TextFieldCell: UITableViewCell, Configurable, UITextFieldDelegate {

    private var emptyDefault: String = "1"

    /// A `UITextField` as the `accessoryView`.
    public private(set) lazy var textField: PaddedTextField = {

        let screenWidth = UIScreen.main.bounds.width
        let width: CGFloat = screenWidth/4

        let tf = PaddedTextField(frame: CGRect(x: 0,
                                               y: 0,
                                               width: width,
                                               height: 30))
        tf.delegate = self
        tf.font = .preferredFont(forTextStyle: .body)
        tf.textColor = .systemGray

        tf.layer.borderColor = UIColor.label.cgColor
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 5.0

        tf.autocorrectionType = .no
        tf.keyboardType = .default
        tf.returnKeyType = .done
        tf.clearButtonMode = .whileEditing
        tf.textAlignment = .right
        tf.contentVerticalAlignment = .center

        return tf
    }()

    /// The switch cell's delegate object, which should conform to `TextFieldCellDelegate`.
    open weak var delegate: TextFieldCellDelegate?

    // MARK: - Initializer

    /**
    Overrides `UITableViewCell`'s designated initializer.

    - parameter style:           A constant indicating a cell style.
    - parameter reuseIdentifier: A string used to identify the cell object if it is to be reused for drawing multiple rows of a table view.

    - returns: An initialized `TextFieldCell` object.
    */
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpAppearance()
    }

    /**
    Overrides the designated initializer that returns an object initialized from data in a given unarchiver.

    - parameter aDecoder: An unarchiver object.

    - returns: `self`, initialized using the data in decoder.
    */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setUpAppearance()
    }

    // MARK: - Configurable

    /// Set up the TextFieldCell control with the provided row.
    open func configure(with row: Row & RowStyle) {

        if let row = row as? TextFieldRowCompatible {

            textField.text = row.textFieldValue
            textField.placeholder = row.placeholder
            textField.keyboardType = row.keyboardType

            emptyDefault = row.placeholder
        }
        accessoryView = textField
    }

    // MARK: - UITextFieldDelegate

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        return true
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {

        if var changedText = textField.text {

            if changedText.count == 0 {
                changedText = emptyDefault
            }

            callDelegate(changedText)
        }
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {

        // called when clear button pressed. return NO to ignore (no notifications)

        callDelegate(emptyDefault)

        return true
    }

    public func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        return string.rangeOfCharacter(from: CharacterSet.letters) == nil
    }

    private func callDelegate(_ changedText: String) {

        delegate?.textFieldCell(self,
                                textFieldDidChange: changedText)
    }

    private func setUpAppearance() {

        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
    }
}

public class PaddedTextField: UITextField {

    var padding: CGFloat = 10

    // text position
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding*3, dy: 0)
    }

    // placeholder position
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
}
