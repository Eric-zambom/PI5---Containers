import UIKit
import Foundation
import CoreGraphics

class OldViewController: UIViewController {

    var caixa1: Double = 1000.0
    var caixa2 = 0.0
    var drop: Double = 0.1
    var days = 1
    var count = 0
    var box1 = 100.0
    var box2 = 300.0
    
    let e = 2.718281828459045235360287
    
    
    @IBOutlet weak var ContainerInput: UITextField!
    @IBOutlet weak var taxInput: UITextField!
    @IBOutlet weak var Output: UITextView!
    @IBOutlet weak var diasInput: UITextField!
    
    @IBOutlet weak var conteiner1: UIView!
    @IBOutlet weak var conteiner2: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //createSquare3(yinitial: 100, yFinal: 200, xinitial: 50, xFinal: 150)
        //createSquare1()

        //createSquare2()
        
        self.conteiner1.frame.size.height = 200
        self.conteiner1.frame.size.width = 200
        
        self.conteiner2.frame.size.height = 0
        self.conteiner2.frame.size.width = 200
        
        Output.text = ""
        
        
    }

    func vazamento(tax: Double, dias: Int) {
//        let d = dias * 24
//        for i in 1...d {
//            let conteudo = caixa1 * tax
//            caixa1 = caixa1 - conteudo
//            caixa2 = caixa2 + conteudo
//            print("Hora: \(i) - Transferencia:\(conteudo) - Caixa 1 :\(caixa1) - Caixa 2 :\(caixa2) ")
//
//            Output.text = Output.text! + "\n" + "Hora: \(i) - Transferencia:\(conteudo) - Caixa 1 :\(caixa1) - Caixa 2 :\(caixa2) "
//
//            createSquare1()
//            createSquare1()
//            createSquare2()
//            count = count + 1
//        }
        let temp = caixa1
        caixa1 = caixa1 * pow(e, (-drop * Double(days)))
        caixa2 = abs(caixa1 - temp)
        print("Caixa 1 :\(caixa1) - Caixa 2 :\(caixa2)")
        Output.text = "Caixa 1 :\(caixa1) - Caixa 2 :\(caixa2)"
        
        UIView.animate(withDuration: 1.0, delay: 1.2, options: .curveEaseOut, animations: {
            var container1Frame = self.conteiner1.frame
            container1Frame.size.height -= 50
            
            var container2Frame = self.conteiner2.frame
            container2Frame.size.height -= 50
            
            self.conteiner1.frame = container1Frame
            self.conteiner2.frame = container2Frame
        }, completion: { finished in
            print("Transaction Complete")
        })
        
//        createSquare1()
//        createSquare1()
//        createSquare2()
    }
    
//    func createSquare1() {
//
//        for layer in self.view.layer.sublayers! {
//            if layer.name == "square" {
//                layer.removeFromSuperlayer()
//            }
//
//        }
//
//        //Square 1
//        let squarePath = UIBezierPath()//1
//
//        let taxa = (drop/24.0)
//
//        //let conteudo = box1 * taxa
//
//        box1 = box1 + (0.25 * (drop * 10))
//
//        squarePath.move(to: CGPoint(x: 50, y: box1))
//
//        squarePath.addLine(to: CGPoint(x: 150, y: box1))
//        squarePath.addLine(to: CGPoint(x: 150, y: 200))
//        squarePath.addLine(to: CGPoint(x: 50, y: 200))
//
//        squarePath.close() //5
//
//        let square = CAShapeLayer() //6
//        square.name = "square"
//        square.path = squarePath.cgPath //7
//        square.fillColor = UIColor.blue.cgColor //8
//        self.view.layer.addSublayer(square) //9
//    }
//
//
//    func createSquare2() {
//        //Square 2
//        let squarePath2 = UIBezierPath()
//        squarePath2.move(to: CGPoint(x: 250, y: 300))
//
//        let taxa = (drop/24.0)
//
//        let conteudo = box2 * taxa
//
//        box2 = box2 - (0.25 * (drop * 10))
//
//        squarePath2.addLine(to: CGPoint(x: 350, y: 300))
//        squarePath2.addLine(to: CGPoint(x: 350, y: box2))
//        squarePath2.addLine(to: CGPoint(x: 250, y: box2))
//
//        squarePath2.close()
//
//        let square2 = CAShapeLayer() //6
//        square2.name = "square2"
//        square2.path = squarePath2.cgPath //7
//        square2.fillColor = UIColor.blue.cgColor //8
//        self.view.layer.addSublayer(square2) //9
//
//    }
//
//    func createSquare3(yinitial: Int, yFinal: Int, xinitial: Int, xFinal: Int) {
//
//        //Square 3
//        let squarePath3 = UIBezierPath()//1
//        squarePath3.move(to: CGPoint(x: xinitial, y: yinitial))
//
//        squarePath3.addLine(to: CGPoint(x: xFinal, y: yinitial))
//        squarePath3.addLine(to: CGPoint(x: xFinal, y: yFinal))
//        squarePath3.addLine(to: CGPoint(x: xinitial, y: yFinal))
//
//        squarePath3.close() //5
//
//        let square3 = CAShapeLayer() //6
//        square3.name = "square3"
//        square3.path = squarePath3.cgPath //7
//        square3.fillColor = UIColor.blue.cgColor //8
//        self.view.layer.addSublayer(square3) //9
//    }
    
    @IBAction func run(_ sender: UIButton) {
        
//        for layer in self.view.layer.sublayers! {
//            if layer.name == "square3" {
//                layer.removeFromSuperlayer()
//            }
//            else if layer.name == "square2" {
//                layer.removeFromSuperlayer()
//            }
//            else if layer.name == "square" {
//                layer.removeFromSuperlayer()
//            }
//
//        }
        
        caixa1 = Double(ContainerInput.text!) as! Double
        drop = Double(taxInput.text!) as! Double
        days = Int(diasInput.text!) as! Int
        
        let taxa = (drop/24.0)
        
        vazamento(tax: taxa, dias: days)
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseOut, animations: {
            var container1Frame = self.conteiner1.frame
            container1Frame.size.height = 200
            
            var container2Frame = self.conteiner2.frame
            container2Frame.size.height = 0
            
            self.conteiner1.frame = container1Frame
            self.conteiner2.frame = container2Frame
        }, completion: { finished in
            print("Reset Complete")
        })
        
        Output.text = ""
        
    }
    
}

/*
 
 UIView.animate(withDuration: 1.0, delay: 1.2, options: .curveEaseOut, animations: {
 var fabricTopFrame = self.fabricTop.frame
 fabricTopFrame.origin.y -= fabricTopFrame.size.height
 
 var fabricBottomFrame = self.fabricBottom.frame
 fabricBottomFrame.origin.y += fabricBottomFrame.size.height
 
 self.fabricTop.frame = fabricTopFrame
 self.fabricBottom.frame = fabricBottomFrame
 }, completion: { finished in
 print("Napkins opened!")
 })
 
 */

