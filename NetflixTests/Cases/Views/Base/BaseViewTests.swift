//
//  BaseViewTests.swift
//  NetflixTests
//
//  Created by SERDAR TURAN on 4.01.2021.
//

import XCTest
@testable import Netflix

class BaseViewTests: XCTestCase {

    var sut: BaseView!
    
    override func setUp() {
        super.setUp()
        sut = BaseView()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func whenSetBaseViewModel(isActivityIndicatorEnabled: Bool) -> BaseViewModel {
        return BaseViewModel(isActivityIndicatorEnabled: isActivityIndicatorEnabled)
    }

    func test_initBase_whenInitCoder() {
        sut = BaseView(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func test_configureActivityIndicator_whenEnabledTrue_setContainerView() {
        sut.baseViewModel = whenSetBaseViewModel(isActivityIndicatorEnabled: true)
        sut.configureActivityIndicator()
        XCTAssertTrue(sut.subviews.contains(sut.activityContainerView))
    }
    
    func test_configureActivityIndicator_whenEnabledTrue_setActivityIndicator() {
        sut.baseViewModel = whenSetBaseViewModel(isActivityIndicatorEnabled: true)
        sut.configureActivityIndicator()
        XCTAssertTrue(sut.activityContainerView.subviews.contains(sut.activityIndicator))
    }
    
    func test_configureActivityIndicator_whenEnabledTrue_setActivityIndicatorAnimation() {
        sut.baseViewModel = whenSetBaseViewModel(isActivityIndicatorEnabled: true)
        sut.configureActivityIndicator()
        XCTAssertTrue(sut.activityIndicator.isAnimating)
    }
    
    func test_configureActivityIndicator_whenEnabledFalse_setContainerView() {
        sut.baseViewModel = whenSetBaseViewModel(isActivityIndicatorEnabled: false)
        sut.configureActivityIndicator()
        XCTAssertFalse(sut.subviews.contains(sut.activityContainerView))
    }
    
    func test_configureActivityIndicator_whenEnabledFalse_setActivityIndicator() {
        sut.baseViewModel = whenSetBaseViewModel(isActivityIndicatorEnabled: false)
        sut.configureActivityIndicator()
        XCTAssertFalse(sut.activityContainerView.subviews.contains(sut.activityIndicator))
    }
    
    func test_configureActivityIndicator_whenEnabledFalse_setActivityIndicatorAnimation() {
        sut.baseViewModel = whenSetBaseViewModel(isActivityIndicatorEnabled: false)
        sut.configureActivityIndicator()
        XCTAssertFalse(sut.activityIndicator.isAnimating)
    }
    
    func test_activityContainerViewAppearance_setCornerRadius() {
        XCTAssertEqual(sut.activityContainerView.layer.cornerRadius, 35.0)
    }
    
    func test_activityContainerViewAppearance_setBackgroundColor() {
        XCTAssertEqual(sut.activityContainerView.backgroundColor, StyleConstants.Color.turquoise?.withAlphaComponent(0.6))
    }
    
    func test_activityIndicatorAppearance_setCenter() {
        XCTAssertEqual(sut.activityIndicator.center, sut.center)
    }
    
    func test_activityIndicatorAppearance_setColor() {
        XCTAssertEqual(sut.activityIndicator.color, StyleConstants.Color.lightGray)
    }
}
