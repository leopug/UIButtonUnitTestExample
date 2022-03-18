//
//  CoreDataPoCTests.swift
//  CoreDataPoCTests
//
//  Created by Leonardo on 08/02/2022.
//

import XCTest
@testable import CoreDataPoC

class ViewControllerButtonTests: XCTestCase {
    
    func testCustomButton_configuration() {
        let button = CustomButton(title: "Mike")
        
        XCTAssertEqual(button.backgroundColor, UIColor.black)
        XCTAssertFalse(button.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(button.titleLabel?.text, "Mike")
    }
    
    func testButton_viewDidload_haveTwoCustomButtonsInSubviews() {
        let buttonViewList = createButtonViews()
        
        XCTAssertEqual(buttonViewList.count, 2)
        XCTAssertEqual(buttonViewList[0].titleLabel?.text!, "Button1")
        XCTAssertEqual(buttonViewList[1].titleLabel?.text!, "Button2")
    }
    
    func testCounterButton_whenTapped_incrementCount() {
        let sut = ViewController()
        sut.loadViewIfNeeded()
            
        XCTAssertEqual(sut.buttonPressCount, 0)
        
        sut.counterButton.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(sut.buttonPressCount, 1)
        
        sut.counterButton.sendActions(for: .touchUpInside)

        XCTAssertEqual(sut.buttonPressCount, 2)
    }
    
    func testClosureButton_whenTapped_callInjectedClosure() {
        var button2Pressed = false
        
        let sut = ViewController() {
            button2Pressed = true
            return "Ana"
        }
        Array<Int?>(unsafeUninitializedCapacity: 10) { buffer, initializedCount in
            
        }
        sut.loadViewIfNeeded()
        
        XCTAssertFalse(button2Pressed)

        sut.closureButton.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(button2Pressed)
    }
}

extension ViewControllerButtonTests {
    private func createButtonViews() -> [UIButton] {
        let sut = ViewController()
        
        var viewList = [CustomButton]()
        
        sut.view.subviews.forEach { view in
            if let view = view as? CustomButton {
                viewList.append(view)
            }
        }
                
        return viewList.sorted { button1, button2 in

            guard let text1 = button1.titleLabel?.text else {
                return true
            }

            guard let text2 = button2.titleLabel?.text else {
                return false
            }

            return text1 < text2
        }
    }
}
