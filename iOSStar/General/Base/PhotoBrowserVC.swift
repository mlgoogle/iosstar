import UIKit
import MWPhotoBrowser
class PhotoBrowserVC: MWPhotoBrowser {
    
    convenience init(image:UIImage) {
        let photo = MWPhoto(image: image)
        self.init(photos:[photo!])

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
        displayActionButton = true
        displayNavArrows = false
        displaySelectionButtons = false
        zoomPhotosToFill = true
        alwaysShowControls = false
        enableGrid = true
        startOnGrid = false
        autoPlayOnAppear = false
        enableSwipeToDismiss = true
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(selfDismiss))
        view.subviews.first?.subviews.first?.subviews[1].addGestureRecognizer(tapGes)
    }
    
    func selfDismiss() {
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismiss(animated: true, completion: nil)
    }
    
}
