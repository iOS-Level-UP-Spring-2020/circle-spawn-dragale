import UIKit

class CircleSpawnController: UIViewController, UIGestureRecognizerDelegate {

	// TODO: Assignment 1

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(spawnCircle(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        view.addGestureRecognizer(doubleTap)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UILongPressGestureRecognizer && otherGestureRecognizer is UILongPressGestureRecognizer {
            return true
        }
        return false
    }

    @objc func spawnCircle(_ tap: UITapGestureRecognizer) {
        
        let size: CGFloat = 100
        let spawnedView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        spawnedView.center = tap.location(in: self.view)
        spawnedView.backgroundColor = .randomBrightColor()
        spawnedView.layer.cornerRadius = size * 0.5
        view.addSubview(spawnedView)
        
        spawnedView.alpha = 0
        spawnedView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        
        UIView.animate(withDuration: 0.2, animations: {
            spawnedView.alpha = 1
            spawnedView.transform = .identity
        })
        
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(destroyCircle(_:)))
        tripleTap.numberOfTapsRequired = 3
        spawnedView.addGestureRecognizer(tripleTap)
        
        let grab = UILongPressGestureRecognizer(target: self, action: #selector(moveCircle(_ :)))
        spawnedView.addGestureRecognizer(grab)
    }
    
    @objc func destroyCircle(_ tap: UITapGestureRecognizer) {
        let spawnedView = tap.view!
        
        UIView.animate(withDuration: 0.2, animations: {
            spawnedView.alpha = 0
            spawnedView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }, completion: {completed in
            spawnedView.removeFromSuperview()
        })
    }
    
    @objc func moveCircle(_ longTap: UILongPressGestureRecognizer) {
        guard let circle = longTap.view else {return}
        let point = longTap.location(in: self.view)
        
        if longTap.state == UIGestureRecognizer.State.began {
            UIView.animate(withDuration: 0.2, animations: {
                circle.alpha = 0.6
                circle.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
        }
        
        if longTap.state == UIGestureRecognizer.State.changed {
            circle.center.x = point.x
            circle.center.y = point.y
        }
        
        if longTap.state == UIGestureRecognizer.State.ended {
            UIView.animate(withDuration: 0.2, animations: {
                circle.alpha = 1
                circle.transform = .identity
            })
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
