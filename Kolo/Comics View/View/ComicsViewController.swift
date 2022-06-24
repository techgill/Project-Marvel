//
//  ComicsViewController.swift
//  Kolo
//
//  Created by Hardeep on 14/04/22.
//

import UIKit
import SafariServices

class ComicsViewController: UIViewController {
    
    enum FiltersOptions: String {
        case LASTWEEK = "Last Week"
        case THISWEEK = "This Week"
        case NEXTWEEK = "Next Week"
        case THISMONTH = "This Month"
        case ALL = "All"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var noDataLabel: UILabel!
    var vm: ComicsViewModel
    
    init() {
        self.vm = ComicsViewModel()
        super.init(nibName: "ComicsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNoDataLabel()
        setUpNavBar()
        setUpCollectionView()
        vm.callNetComics(offset: 0)
        bindUI()
        
    }
    
    func addNoDataLabel() {
        noDataLabel = Utilities.getNoDataLabel(text: AAConstants.nothingHere)
        collectionView.addSubview(noDataLabel)
        noDataLabel.isHidden = true
    }
    
    func setUpNavBar() {
        let rightBarButton = UIBarButtonItem(title: "FILTERS", style: .plain, target: self, action: #selector(didTapOnRightBarButton))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setUpCollectionView() {
        collectionView.backgroundView = Utilities.indicatorView
        collectionView.register(UINib(nibName: "LoaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "LoaderCollectionReusableView")
        collectionView.register(UINib(nibName: AAConstants.comicCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: AAConstants.comicCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc func didTapOnRightBarButton(_ sender: UIBarButtonItem) {
        let options = [FiltersOptions.LASTWEEK, FiltersOptions.THISWEEK, FiltersOptions.NEXTWEEK, FiltersOptions.THISMONTH, FiltersOptions.ALL]
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in options {
            alert.addAction(UIAlertAction(title: item.rawValue, style: .default, handler: { _ in
                self.collectionView.backgroundView = Utilities.indicatorView
                switch item {
                case .LASTWEEK:
                    self.vm.selectedFilter = "lastWeek"
                case .THISWEEK:
                    self.vm.selectedFilter = "thisWeek"
                case .NEXTWEEK:
                    self.vm.selectedFilter = "nextWeek"
                case .THISMONTH:
                    self.vm.selectedFilter = "thisMonth"
                case .ALL:
                    self.vm.selectedFilter = ""
                }
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func bindUI() {
        vm.observer.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.updateBindUI()
            }
        }
    }
    
    func updateBindUI() {
        noDataLabel.isHidden = vm.getCellCount() != 0
        collectionView.reloadData()
        collectionView.backgroundView = nil
    }

}

extension ComicsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return vm.getCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.getCellCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AAConstants.comicCollectionViewCell, for: indexPath) as? ComicCollectionViewCell else {return UICollectionViewCell()}
        cell.fillDetails(vm: self.vm, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == vm.getCellCount() - 1 {
            vm.callPagination(index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: vm.getUrl(index: indexPath.row)) {
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return vm.getCellCount() == 0 ? CGSize.zero:CGSize(width: collectionView.bounds.size.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoaderCollectionReusableView", for: indexPath) as! LoaderCollectionReusableView
            aFooterView.fillDetails(isLoaded: vm.isLoaded)
            return aFooterView
        }
        return UICollectionReusableView()
    }
}
