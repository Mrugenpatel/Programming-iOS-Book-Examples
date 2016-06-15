
import UIKit

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
extension CGSize {
    init(_ width:CGFloat, _ height:CGFloat) {
        self.init(width:width, height:height)
    }
}
extension CGPoint {
    init(_ x:CGFloat, _ y:CGFloat) {
        self.init(x:x, y:y)
    }
}


class MyView : UIView {
    
    lazy var arrow : UIImage = self.arrowImage()
    
    override init (frame:CGRect) {
        super.init(frame:frame)
        self.isOpaque = false
    }

    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    func arrowImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(40,100), false, 0.0)
        
        // obtain the current graphics context
        let con = UIGraphicsGetCurrentContext()!
        con.saveGState()
        
        // punch triangular hole in context clipping region
        con.moveTo(x: 10, y: 100)
        con.addLineTo(x: 20, y: 90)
        con.addLineTo(x: 30, y: 100)
        con.closePath()
        con.addRect(con.boundingBoxOfClipPath)
        con.eoClip()
        
        // draw the vertical line, add its shape to the clipping region
        con.moveTo(x: 20, y: 100)
        con.addLineTo(x: 20, y: 19)
        con.setLineWidth(20)
        con.replacePathWithStrokedPath()
        con.clip()
        
        // draw the gradient
        let locs : [CGFloat] = [ 0.0, 0.5, 1.0 ]
        let colors : [CGFloat] = [
                                     0.8, 0.4, // starting color, transparent light gray
            0.1, 0.5, // intermediate color, darker less transparent gray
            0.8, 0.4, // ending color, transparent light gray
        ]
        let sp = CGColorSpaceCreateDeviceGray()
        let grad =
            CGGradient(colorComponentsSpace:sp, components: colors, locations: locs, count: 3)!
        con.drawLinearGradient(grad, start: CGPoint(9,0), end: CGPoint(31,0), options: [])
        
        con.restoreGState() // done clipping
        
        // draw the red triangle, the point of the arrow
        UIGraphicsBeginImageContextWithOptions(CGSize(4,4), false, 0)
        let imcon = UIGraphicsGetCurrentContext()!
        imcon.setFillColor(UIColor.red().cgColor)
        imcon.fill(CGRect(0,0,4,4))
        imcon.setFillColor(UIColor.blue().cgColor)
        imcon.fill(CGRect(0,0,4,2))
        let stripes = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let stripesPattern = UIColor(patternImage:stripes)
        stripesPattern.setFill()
        let p = UIBezierPath()
        p.move(to:CGPoint(0,25))
        p.addLine(to:CGPoint(20,0))
        p.addLine(to:CGPoint(40,25))
        p.fill()
        
        let im = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return im

    }
    
    let which = 2

    override func draw(_ rect: CGRect) {

        switch which {
        case 1:
            let con = UIGraphicsGetCurrentContext()!
            self.arrow.draw(at:CGPoint(0,0))
            for _ in 0..<3 {
                con.translate(x: 20, y: 100)
                con.rotate(byAngle: 30 * CGFloat(M_PI)/180.0)
                con.translate(x: -20, y: -100)
                self.arrow.draw(at:CGPoint(0,0))
            }
            
        case 2:
            let con = UIGraphicsGetCurrentContext()!
            con.setShadow(offset: CGSize(7, 7), blur: 12)
            
            self.arrow.draw(at:CGPoint(0,0))
            for _ in 0..<3 {
                con.translate(x: 20, y: 100)
                con.rotate(byAngle: 30 * CGFloat(M_PI)/180.0)
                con.translate(x: -20, y: -100)
                self.arrow.draw(at:CGPoint(0,0))
            }
            
        case 3:
            let con = UIGraphicsGetCurrentContext()!
            con.setShadow(offset: CGSize(7, 7), blur: 12)
            
            con.beginTransparencyLayer(auxiliaryInfo: nil)
            self.arrow.draw(at:CGPoint(0,0))
            for _ in 0..<3 {
                con.translate(x: 20, y: 100)
                con.rotate(byAngle: 30 * CGFloat(M_PI)/180.0)
                con.translate(x: -20, y: -100)
                self.arrow.draw(at:CGPoint(0,0))
            }
            con.endTransparencyLayer()

        default: break
        }
        
    }
    
    
}
