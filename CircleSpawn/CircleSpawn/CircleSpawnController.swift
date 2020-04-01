import UIKit

class CircleSpawnController: UIViewController {

	// TODO: Assignment 1

	override func loadView() {
		view = UIView()
		view.backgroundColor = .white
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }

    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        
        let size: CGFloat = 100
        let spawnedView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        spawnedView.center = tap.location(in: self.view)
        spawnedView.backgroundColor = .randomBrightColor()
        spawnedView.layer.cornerRadius = size * 0.5
        view.addSubview(spawnedView)
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
