import UIKit

// MARK: - StoreView

final class StoreView: UIView {
  
  // MARK: - Internal variables
  
  let tableView: UITableView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    $0.tableFooterView = nil
    $0.tableHeaderView = nil
    $0.rowHeight = UITableView.automaticDimension
    $0.estimatedRowHeight = 72.0
    $0.separatorStyle = .none
    $0.backgroundColor = .white
    return $0
  }(UITableView(frame: .zero, style: .grouped))
  
  let overlayView: OverlayView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.isHidden = true
    return $0
  }(OverlayView())
  
  let warningLabel: UILabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.isHidden = true
    $0.text = DSStrings.emptyData
    $0.numberOfLines = 0
    $0.textAlignment = .center
    return $0
  }(UILabel())
  
  // MARK: - Initializers
  
  init() {
    super.init(frame: .zero)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Internal methods

extension StoreView {
  
  func showLoading() {
    tableView.isHidden = true
    overlayView.isHidden = false
    warningLabel.isHidden = true
  }
  
  func showError(error: String) {
    tableView.isHidden = false
    overlayView.isHidden = true
    warningLabel.isHidden = false
    warningLabel.text = error
  }
  
  func showTableView() {
    tableView.isHidden = false
    overlayView.isHidden = true
    warningLabel.isHidden = true
  }
  
  func showNoData() {
    overlayView.isHidden = true
    tableView.isHidden = false
    warningLabel.isHidden = false
  }
}

// MARK: - Private methods

private extension StoreView {
  
  func setupLayout() {
    backgroundColor = .white
    addComponents()
    setupTableViewContraints()
    setupOverlayViewConstraints()
    setupWarningLabelConstraints()
  }
  
  func addComponents() {
    addSubview(tableView)
    addSubview(overlayView)
    tableView.addSubview(warningLabel)
  }
  
  func setupTableViewContraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }
  
  func setupOverlayViewConstraints() {
    NSLayoutConstraint.activate([
      overlayView.topAnchor.constraint(equalTo: tableView.topAnchor),
      overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
      overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
      overlayView.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }
  
  func setupWarningLabelConstraints() {
    NSLayoutConstraint.activate([
      warningLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
      warningLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      warningLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
    ])
  }
}
