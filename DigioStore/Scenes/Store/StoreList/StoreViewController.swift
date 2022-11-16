import UIKit

// MARK: - StoreViewController

final class StoreViewController: BaseViewController<StoreView> {
  
  // MARK: - Private variables
  
  private let viewModel: StoreViewModelProtocol
  
  // MARK: - Initializers
  
  init(viewModel: StoreViewModelProtocol) {
    self.viewModel = viewModel
    super.init()
  }
  
  // MARK: - Override methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    customView.tableView.dataSource = self
    customView.tableView.delegate = self
    customView.showLoading()
    viewModel.fetchStore()
    title = DSStrings.digioStore
  }
}

// MARK: - UITableViewDataSource

extension StoreViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.storeSections.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell
    else { return UITableViewCell()}
    
    let section = viewModel.storeSections[indexPath.section]
    let values = section.value
    cell.configure(data: values, section: indexPath.section)
    cell.cellDelegate = self
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if section >= viewModel.storeSections.count { return nil }
    let section = viewModel.storeSections[section]
    
    switch section.key {
    case .spotlight:
      return nil
    default:
      let sectionview = SectionView()
      sectionview.configure(sectionType: section.key)
      return sectionview
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 32
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let section = indexPath.section
    if section == 0 {
      return 200
    }
    return 120
  }
}

// MARK: - UITableViewDelegate

extension StoreViewController: UITableViewDelegate {}

// MARK: - StoreDelegate

extension StoreViewController: StoreDelegate {
  
  func showErrorMessage(error: String) {
    customView.showError(error: error)
  }
  
  func showEmptyDataMessage() {
    customView.showNoData()
  }
  
  func updateTableView() {
    customView.tableView.reloadData()
    customView.showTableView()
  }
}

// MARK: - CollectionViewCellDelegate

extension StoreViewController: CollectionViewCellDelegate {
  
  func collectionView(indexCell: Int, tableViewSection: Int) {
    let item = viewModel.storeSections[tableViewSection].value[indexCell]
    viewModel.routeToDetails(selectedItem: item)
  }
}
