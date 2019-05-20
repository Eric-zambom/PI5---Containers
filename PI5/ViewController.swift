import UIKit
import Foundation
import CoreGraphics

class ViewController: UIViewController {

    //Containers
    var caixa1: Double = 1.0
    var caixa2 = 0.0
    var caixa3 = 0.0
    
    //Taxas de vazamento/enchimento
    var drop12: Double = 0.1
    var drop23: Double = 0.05
    var drop31: Double = 0.01
    
    var days = 1.0
    var time = 0.0
    var count = 0
    
    var h: Double = 0.001
    
    var height = 200.0
    var height2 = 0.0
    var height3 = 0.0
    
    let e = 2.718281828459045235360287
    
    
    @IBOutlet weak var ContainerInput: UITextField!
    
    //Taxas
    @IBOutlet weak var taxInput: UITextField!
    @IBOutlet weak var taxInput2: UITextField!
    @IBOutlet weak var taxInput3: UITextField!
    
    //Define o que será mostrado ao usuário como output técnico
    @IBOutlet weak var Output: UITextView!
    @IBOutlet weak var diasInput: UITextField!
    
    @IBOutlet weak var conteiner1: UIView!
    @IBOutlet weak var conteiner2: UIView!
    @IBOutlet weak var conteiner3: UIView!
    
    @IBOutlet weak var conteinerFill: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.conteiner1.frame.size.height = 200
        self.conteiner1.frame.size.width = 200
        
        self.conteiner2.frame.size.height = 0
        self.conteiner2.frame.size.width = 200
        
        Output.text = ""
        
        
    }
    
    @IBAction func run(_ sender: UIButton) {
        
        caixa1 = Double(ContainerInput.text!) as! Double
        drop12 = Double(taxInput.text!) as! Double
        drop23 = Double(taxInput2.text!) as! Double
        drop31 = Double(taxInput3.text!) as! Double
        days = Double(diasInput.text!) as! Double
        
        animation()
        
        vazamentoV2(i: 1)
        //vazamento(dias: days)
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
       
        var containerFillFrame = self.conteinerFill.frame
        containerFillFrame.size.height = 0
        
        var container2Frame = self.conteiner2.frame
        container2Frame.size.height = 0
        container2Frame.origin.y = 323
        
        var container3Frame = self.conteiner3.frame
        container3Frame.size.height = 0
        container3Frame.origin.y = 323
        
        self.conteinerFill.frame = containerFillFrame
        self.conteiner2.frame = container2Frame
        self.conteiner3.frame = container3Frame
        
        height = 200.0
        
//        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseOut, animations: {
//
//        }, completion: { finished in
//            print("Reset Complete")
//        })
        
        Output.text = ""
        
    }
    
    func animation() {
        height = height * drop12 * Double(days)
        
    }
    
    
    func rungeKutta4(tax1: Double, tax2: Double, tax3: Double, q1: Double, q2: Double, q3: Double) -> Double {
        return tax1 * q1 + tax2 * q2 + tax3 * q3;
    }
    
    func rungeKutta4formula1(box1: Double, box3: Double) -> Double {
        return (-drop12 * box1) + (drop31 * box3)
    }
    
    func rungeKutta4formula2(box1: Double, box2: Double) -> Double {
        return (drop12 * box1) - (drop23 * box2)
    }
    
    func rungeKutta4formula3(box2: Double, box3: Double) -> Double {
        return (drop23 * box2) - (drop31 * box3)
    }
    
    func  rk4Compartimento1(y: Double, q1: Double, q3: Double, h: Double) -> Double {
        let k1: Double = rungeKutta4formula1(box1: q1, box3: q3)
        
        let k2: Double = rungeKutta4formula1(box1: q1 + h*k1/2, box3: q3 + h*k1/2)
        
        let k3: Double = rungeKutta4formula1(box1: q1 + h*k2/2, box3: q3 + h*k2/2)
        
        let k4: Double = rungeKutta4formula1(box1: q1 + h*k3, box3: q3 + h*k3)
    
        return y + (k1 + 2*k2 + 2*k3 + k4) * h/6
    }
    
    func rk4Compartimento2(y: Double, q1: Double, q2: Double, h: Double) -> Double {
        let k1: Double = rungeKutta4formula2(box1: q1, box2: q2)
        
        let k2: Double = rungeKutta4formula2(box1: q1 + h*k1/2, box2: q2 + h*k1/2)
        
        let k3: Double = rungeKutta4formula2(box1: q1 + h*k2/2, box2: q2 + h*k2/2)

        let k4: Double = rungeKutta4formula2(box1: q1 + h*k3, box2: q2 + h*k3)
        
        return y + (k1 + 2*k2 + 2*k3 + k4) * h/6
    }
    
    func  rk4Compartimento3(y: Double, q2: Double, q3: Double, h: Double) -> Double {
        let k1: Double = rungeKutta4formula3(box2: q2, box3: q3)
        
        let k2: Double = rungeKutta4formula3(box2: q2 + h*k1/2, box3: q3 + h*k1/2)
        
        let k3: Double = rungeKutta4formula3(box2: q2 + h*k2/2, box3: q3 + h*k2/2)
        
        let k4: Double = rungeKutta4formula3(box2: q2 + h*k3, box3: q3 + h*k3)
        
        return y + (k1 + 2*k2 + 2*k3 + k4) * h/6
    }
    
    func vazamentoV2(i: Int) {
        
        print("Caixa1: \(caixa1), Caixa2: \(caixa2), Caixa3: \(caixa3)")
        
        var j: Double = 0.0
        
        while j < days {
            
            let c1QuantidadeLiquido: Double = rk4Compartimento1(y: caixa1, q1: caixa1, q3: caixa3, h: h)
            
            caixa1 = c1QuantidadeLiquido

            let c2QuantidadeLiquido: Double = rk4Compartimento2(y: caixa2, q1: caixa1, q2: caixa2, h: h)
            
            caixa2 = c2QuantidadeLiquido
            
            let c3QuantidadeLiquido: Double = rk4Compartimento3(y: caixa3, q2: caixa2, q3: caixa3, h: h)
            
            caixa3 = c3QuantidadeLiquido
            
            j += h
            
            //print("Caixa1: \(caixa1), Caixa2: \(caixa2), Caixa3: \(caixa3)")
            Output.text += "Dia: \(j) || Caixa1: \(caixa1) || Caixa2: \(caixa2) || Caixa3: \(caixa3) \n"
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseOut, animations: {
            
            //MARK: - Tem que fazer a regra de três
            //Tá bem diferente do certo, BEM ERRADO
            var containerFillFrame = self.conteinerFill.frame
            containerFillFrame.size.height += CGFloat(self.height)
            
            var container2Frame = self.conteiner2.frame
            container2Frame.size.height -= CGFloat(self.height)
            container2Frame.origin.y = 323
            
            //MARK: -Isso aqui é diferente
            var container3Frame = self.conteiner3.frame
            container3Frame.size.height -= CGFloat(self.height)
            container3Frame.origin.y = 323
            
            self.conteinerFill.frame = containerFillFrame
            self.conteiner2.frame = container2Frame
            self.conteiner3.frame = container3Frame
        }, completion: { finished in
            print("Transaction Complete")
        })
    }
    
}
