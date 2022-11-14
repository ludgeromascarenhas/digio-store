//
//  OverlayView.swift
//  DigioStore
//
//  Created by Ludgero Mascarenhas on 11/11/22.
//

import UIKit

// MARK: - OverlayView

final class OverlayView: UIView {
  
  // MARK: - Public variables
  
  public enum Style {
    case solid, transparent
  }
  
  public var overlayStyle: Style = .solid {
    didSet {
      updateLayout()
    }
  }
  
  // MARK: - Private variables
  
  let indicator: UIActivityIndicatorView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.startAnimating()
    return $0
  }(UIActivityIndicatorView(style: .gray))
  
  // MARK: - Initializers
  
  init(style: Style) {
    super.init(frame: .zero)
    setupLayout()
    overlayStyle = style
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private methods

private extension OverlayView{
  
  func updateLayout() {
    switch overlayStyle {
    case .solid:
      backgroundColor = .white
      
    case .transparent:
      backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
  }
  
  func setupLayout() {
    addComponents()
    setupIndicatiorConstraints()
  }
  
  func addComponents() {
    addSubview(indicator)
  }
  
  func setupIndicatiorConstraints() {
    NSLayoutConstraint.activate([
      indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
      indicator.centerXAnchor.constraint(equalTo: centerXAnchor)
    ])
  }
}
