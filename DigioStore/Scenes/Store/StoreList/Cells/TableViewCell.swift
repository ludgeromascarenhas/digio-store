import UIKit

// MARK: - CollectionViewCellDelegate

protocol CollectionViewCellDelegate: class {
  func collectionView(indexCell: Int, tableViewSection: Int)
}

// MARK: - TableViewCell

final class TableViewCell: UITableViewCell {
  
  // MARK: - Public variables
  
  static let identifier = String(describing: TableViewCell.self)
  
  weak var cellDelegate: CollectionViewCellDelegate?
  
  // MARK: - Private variables
  
  private let stackView: UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    return $0
  }(UIStackView())
  
  private let collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    let collection = UICollectionView(frame: .zero,
                                      collectionViewLayout: flowLayout)
    collection.backgroundColor = .clear
    flowLayout.scrollDirection = .horizontal
    flowLayout.estimatedItemSize = .zero
    collection.showsHorizontalScrollIndicator = false
    collection.register(CollectionViewCell.self,
                        forCellWithReuseIdentifier: CollectionViewCell.identifier)
    return collection
  }()
  
  private var data: [Item] = []
  private var tableViewSection: Int = 0
  
  // MARK: - Initializers
  
  override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    setupLayout()
    selectionStyle = .none
    
  }
  
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Internal methods

extension TableViewCell {
  
  func configure(data: [Item], section: Int) {
    self.data = data
    tableViewSection = section
    collectionView.reloadData()
    collectionView.layoutIfNeeded()
  }
}

// MARK: - Private methods

private extension TableViewCell {
  
  func setupLayout() {
    addComponents()
    setupCollectionViewConstraints()
    backgroundColor = .clear
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  func addComponents() {
    contentView.addSubview(stackView)
    stackView.addArrangedSubview(collectionView)
  }
  
  func setupCollectionViewConstraints() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension TableViewCell: UICollectionViewDelegate,
                         UICollectionViewDataSource,
                         UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.cellDelegate?.collectionView(indexCell: indexPath.item,
                                      tableViewSection: tableViewSection)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier,
                                                     for: indexPath) as? CollectionViewCell {
      
      let item = data[indexPath.row]
      cell.configure(data: item.imageURL)
      return cell
    }
    return UICollectionViewCell()
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    if tableViewSection == 0 {
      return CGSize(width: UIScreen.main.bounds.width - 32, height: 160)
    } else if tableViewSection == 1 {
      return CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
    } else {
      return CGSize(width: 100, height: 100)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    if tableViewSection < 2 {
      return 16
    }
    return 24
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    if tableViewSection < 2 {
      return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    return UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 16)
  }
}
