import UIKit

class CircleSpawnController: UIViewController, UIGestureRecognizerDelegate {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap))
        tripleTap.numberOfTapsRequired = 3
        spawnedView.addGestureRecognizer(tripleTap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        spawnedView.addGestureRecognizer(longPress)
    }
    
    @objc func handleTripleTap(_ tap: UITapGestureRecognizer) {
        guard let spawnedView = tap.view else { return }
        UIView.animate(withDuration: 0.2, animations: {
            spawnedView.alpha = 0
            spawnedView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { completed in
            spawnedView.removeFromSuperview()
        })
    }
    
    @objc func handleLongPress(_ longPress: UILongPressGestureRecognizer) {
        guard let spawnedView = longPress.view else { return }
        let longPressLocation = longPress.location(in: self.view)
        
        if longPress.state == .began {
            view.bringSubviewToFront(spawnedView)
        }
        
        if longPress.state == .changed {
            spawnedView.center.x = longPressLocation.x
            spawnedView.center.y = longPressLocation.y
        }
        
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

