import UIKit

class CircleSpawnController: UIViewController {
    
    // TODO: Assignment 1
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    private let startSize: CGSize = .init(width: 20, height: 20)
    private var spawnedView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap))
        tripleTap.numberOfTapsRequired = 3
        
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.require(toFail: tripleTap)
        view.addGestureRecognizer(tripleTap)
        view.addGestureRecognizer(doubleTap)
        
    }
    
    @objc func handleDoubleTap(_ tap: UITapGestureRecognizer) {
        
        let size: CGFloat = 100
        let spawnedView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        spawnedView.center = tap.location(in: view)
        spawnedView.backgroundColor = UIColor.randomBrightColor()
        spawnedView.layer.cornerRadius = size * 0.5
        view.addSubview(spawnedView)
        
        spawnedView.alpha = 0
        spawnedView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.2, animations: {
            spawnedView.alpha = 1
            spawnedView.transform = .identity
        })
        
    }
    
    @objc func handleTripleTap(_ tap: UITapGestureRecognizer) {
        
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return random(min: 0.0, max: 1.0)
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(max > min)
        return min + ((max - min) * CGFloat(arc4random()) / CGFloat(UInt32.max))
    }
}

extension UIColor {
    static func randomBrightColor() -> UIColor {
        return UIColor(hue: .random(),
                       saturation: .random(min: 0.5, max: 1.0),
                       brightness: .random(min: 0.7, max: 1.0),
                       alpha: 1.0)
    }
}

