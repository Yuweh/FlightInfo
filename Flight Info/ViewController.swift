

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
		
		//TODO: Create a fade animation for snowView
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
		} else {
			
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
