

import UIKit
import QuartzCore


//MARK: ViewController
class ViewController: UIViewController {
    
    @IBOutlet var bgImageView: UIImageView!
    
    @IBOutlet var summaryIcon: UIImageView!
    @IBOutlet var summary: UILabel!
    
    @IBOutlet var flightNr: UILabel!
    @IBOutlet var gateNr: UILabel!
    @IBOutlet var departingFrom: UILabel!
    @IBOutlet var arrivingTo: UILabel!
    @IBOutlet var planeImage: UIImageView!
    
    @IBOutlet var flightStatus: UILabel!
    @IBOutlet var statusBanner: UIImageView!
    
    var snowView: SnowView!
    
    //MARK:- animations
    func fade(
        toImage: UIImage,
        showEffects: Bool
        ) {
        //TODO: Create a crossfade animation for the background
        
        //Create and set up temp view
        let tempView = UIImageView(frame: bgImageView.frame)
        tempView.image = toImage
        tempView.alpha = 0.0
        tempView.center.y += 20
        tempView.bounds.size.width = bgImageView.bounds.width * 1.3
        bgImageView.superview?.insertSubview(tempView, aboveSubview: bgImageView)
        
        UIView.animate(withDuration: 0.5,
                       animations: {
                         //Fade temp view in
                        tempView.alpha = 1.0
                        tempView.center.y -= 20
                        tempView.bounds.size = self.bgImageView.bounds.size
        }) {_ in
            //Remove temp view and update background view
            self.bgImageView.image = toImage
            tempView.removeFromSuperview()
        }
       
        //TODO: Create a fade animation for snowView
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: .curveEaseOut,
            animations: {
                self.snowView.alpha = showEffects ? 1.0 : 00.0
        },
            completion: nil)
        
    }
    
    func moveLabel() {
        //TODO: Animate a label's translation property
    }
    
    func cubeTransition() {
        //TODO: Create a faux rotating cube animation
    }
    
    
    func planeDepart() {
        //TODO: Animate the plane taking off and landing
    }
    
    func changeSummary(to summaryText: String) {
        //TODO: Animate the summary text
        
        delay(seconds: 0.5) {
            self.summary.text = summaryText
        }
    }
    
    
    //MARK:- custom methods
    
    func changeFlight(to data: FlightData, animated: Bool = false) {
        // populate the UI with the next flight's data
        bgImageView.image = UIImage(named: data.weatherImageName)
        departingFrom.text = data.departingFrom
        arrivingTo.text = data.arrivingTo
        flightNr.text = data.flightNr
        gateNr.text = data.gateNr
        flightStatus.text = data.flightStatus
        summary.text = data.summary
        
        if animated {
            //TODO: Call your animation
            fade(toImage: UIImage(named: data.weatherImageName)!,
                 showEffects: data.showWeatherEffects)
            
        } else {
            bgImageView.image = UIImage(named: data.weatherImageName)
        }
        
        // schedule next flight
        delay(seconds: 3.0) {
            self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis, animated: true)
        }
    }
    
    //MARK:- view controller methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adjust UI
        summary.addSubview(summaryIcon)
        summaryIcon.center.y = summary.frame.size.height/2
        
        //add the snow effect layer
        snowView = SnowView(frame: CGRect(x: -150, y:-100, width: 300, height: 50))
        let snowClipView = UIView(frame: view.frame.offsetBy(dx: 0, dy: 50))
        snowClipView.clipsToBounds = true
        snowClipView.addSubview(snowView)
        view.addSubview(snowClipView)
        
        //start rotating the flights
        changeFlight(to: londonToParis, animated: false)
    }
    
    
    //MARK:- utility methods
    func delay(seconds: Double, completion: @escaping ()-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
    func duplicateLabel(label: UILabel) -> UILabel {
        let newLabel = UILabel(frame: label.frame)
        newLabel.font = label.font
        newLabel.textAlignment = label.textAlignment
        newLabel.textColor = label.textColor
        newLabel.backgroundColor = label.backgroundColor
        return newLabel
    }
}
