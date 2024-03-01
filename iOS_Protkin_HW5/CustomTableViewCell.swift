import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var circleView: UIButton!
    var nameItemLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCircleView()
        setupNameItemLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCircleView() {
        circleView = UIButton()
        circleView.layer.borderWidth = 2
        circleView.layer.borderColor = UIColor.gray.cgColor
        circleView.layer.cornerRadius = 10
        circleView.backgroundColor = .clear
        circleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(circleView)

        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 20),
            circleView.heightAnchor.constraint(equalToConstant: 20),
            circleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            circleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    private func setupNameItemLabel() {
        nameItemLabel = UILabel()
        nameItemLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameItemLabel)

        NSLayoutConstraint.activate([
            nameItemLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 10),
            nameItemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            nameItemLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with shoppingItem: ShoppingList) {
        nameItemLabel.text = shoppingItem.name

        circleView.layer.borderWidth = 2
        circleView.layer.borderColor = UIColor.blue.cgColor
        circleView.layer.cornerRadius = 10
        circleView.backgroundColor = .clear

        circleView.addTarget(self, action: #selector(circleViewTapped), for: .touchUpInside)
    }

    @objc private func circleViewTapped() {
        circleView.backgroundColor = .green
    }
}

