import UIKit

class PortfolioView: UIView {
    
    var expanded = false
    var collapsedHeight: CGFloat = 100
    var expandedHeight: CGFloat = 200
    
    lazy var collapsedView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var expandedView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let button : UIButton = {
        let button = UIButton()
        button.setTitle("show", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setImage(UIImage(named: "arrow.down.to.line"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(collapsedView)
        collapsedView.frame = CGRect(x: 0, y: 0, width: frame.width, height: collapsedHeight)
        
        addSubview(expandedView)
        expandedView.frame = CGRect(x: 0, y: collapsedHeight, width: frame.width, height: expandedHeight)
        expandedView.isHidden = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleView))
        collapsedView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func toggleView() {
        expanded.toggle()
        if expanded {
            collapsedView.isHidden = true
            expandedView.isHidden = false
        } else {
            collapsedView.isHidden = false
            expandedView.isHidden = true
        }
    }
}



