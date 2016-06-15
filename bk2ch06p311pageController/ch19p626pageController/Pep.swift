

import UIKit

class Pep: UIViewController {
    
    let boy : String
    @IBOutlet var name : UILabel!
    @IBOutlet var pic : UIImageView!
    
    init(pepBoy boy:String) {
        self.boy = boy
        super.init(nibName: "Pep", bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = self.boy
        self.pic.image = UIImage(named:"\(self.boy.lowercased()).jpg")
    }
    
    override var description : String {
    return self.boy
    }
    
    @IBAction func tap (_ sender: UIGestureRecognizer?) {
        NotificationCenter.default().post(name:"tap" as Notification.Name, object: sender)
    }


}
