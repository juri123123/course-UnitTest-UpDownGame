//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import XCTest
@testable import UpDownGame

class UpDownGameTests: XCTestCase {
    var sut: UpDownGame!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UpDownGame()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_compareValue_hitNUmber가_randomValue보다작을때() {
        //given
        let hitInput = 10
        sut.randomValue = 15
        
        //when
        let result = sut.compareValue(with: hitInput)
        
        //then
        XCTAssertEqual(result, .Up)
    }
    
    func test_compareValue_hitNUmber가_randomValue보다클때() {
        //given
        let hitInput = 15
        sut.randomValue = 10
        
        //when
        let result = sut.compareValue(with: hitInput)
        
        //then
        XCTAssertEqual(result, .Down)
    }
    
    func test_compareValue_hitNUmber가_randomValue와같을때() {
        //given
        let hitInput = 10
        sut.randomValue = 10
        
        //when
        let result = sut.compareValue(with: hitInput)
        
        //then
        XCTAssertEqual(result, .Win)
    }
    
    func test_compareValue_tryCount가5면서_hitNum과randomVal이_일치하지않을때() {
        //given
        let hitInput = 10
        sut.randomValue = 15
        sut.tryCount = 5
        
        //when
        let result = sut.compareValue(with: hitInput)
        
        //then
        XCTAssertEqual(result, .Lose)
    }
    
    func test_makeRandomValue호출시_ramdomValue를_0에서30까지숫자로설정해주는지() {
        //given
        let promise = expectation(description: "It makes random value")
        sut.randomValue = 50
        
        //when
        sut.makeRandomValue {
            //then
            XCTAssertGreaterThanOrEqual(self.sut.randomValue, 0)
            XCTAssertLessThanOrEqual(self.sut.randomValue, 30)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func test_reset호출시_tryCount를초기화시켜주는지() {
        //given
        let promise = expectation(description: "It makes reset")
        sut.tryCount = 5
        
        //when
        sut.reset {
            //then
            XCTAssertEqual(self.sut.tryCount, 0)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }

}
