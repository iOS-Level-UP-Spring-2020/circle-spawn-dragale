import UIKit

class CircleSpawnController: UIViewController, UIGestureRecognizerDelegate {
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    var locationInSubView = CGPoint()
    let animation = Animation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
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
        animation.spawn(object: spawnedView)
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(handleTripleTap))
        tripleTap.numberOfTapsRequired = 3
        spawnedView.addGestureRecognizer(tripleTap)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        spawnedView.addGestureRecognizer(longPress)
    }
    
    @objc func handleTripleTap(_ tap: UITapGestureRecognizer) {
        guard let spawnedView = tap.view else { return }
        animation.despawn(object: spawnedView)
    }
    
    @objc func handleLongPress(_ longPress: UILongPressGestureRecognizer) {
        guard let spawnedView = longPress.view else { return }
        let longPressLocation = longPress.location(in: self.view)

        switch longPress.state {
        case .began:
            animation.pickUp(object: spawnedView)
            locationInSubView = longPress.location(in: longPress.view)
            view.bringSubviewToFront(spawnedView)
        case .changed:
            spawnedView.center.x = longPressLocation.x + ((50 - locationInSubView.x) * 1.5)
            spawnedView.center.y = longPressLocation.y + ((50 - locationInSubView.y) * 1.5)
        case .ended, .cancelled:
            animation.putDown(object: spawnedView)
        default:
            return
        }
    }
}
