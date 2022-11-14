platform :ios, '12.0'

inhibit_all_warnings!

def shared_pods
  use_frameworks!
  pod 'SwiftLint'
  pod 'SwiftGen'
end

target 'DigioStore' do
  shared_pods

  target 'DigioStoreTests' do
    inherit! :search_paths
    shared_pods
  end
end
