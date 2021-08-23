
import UIKit

class CalculateViewController: UIViewController {
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    
    var tip: Double = 0.10
    var billTotal = 0.0
    var numberOfPeople = 2
    var finalResult = "0.0"

    override func viewDidLoad() {
      
        
        super.viewDidLoad()
        
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        
        if bill != "" {
            
            billTotal = Double(bill)! * (1 + tip)
            
            let result = billTotal / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)
        }
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        //reseting all buttons
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        //The percentage value on button title
        let buttonTitle = sender.currentTitle!
        let buttonValue = String(buttonTitle.dropLast())
        tip = Double(buttonValue)! / 100
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           //If the currently triggered segue is the "goToResults" segue.
           if segue.identifier == "goToResult" {
               
               //Get hold of the instance of the destination VC and type cast it to a ResultViewController.
               let destinationVC = segue.destination as! ResultViewController
               
               //Set the destination ResultsViewController's properties.
               destinationVC.result = finalResult
               destinationVC.tip = Int(tip * 100)
               destinationVC.split = numberOfPeople
           }
       }
}

