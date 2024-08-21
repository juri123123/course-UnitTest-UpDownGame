//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import Foundation

// URLSession이 네트워킹을 통해 받아와서 처리하는 data, response, error를 직접 만들어서 담기 위한 구조체
struct DummyData {
    let data: Data?
    let response: URLResponse?
    let error: Error?
    var completionHandler: DataTaskCompletionHandler? = nil
    
    func completion() {
        completionHandler?(data, response, error)
    }
}

// 테스트 중에 URLSession을 대체할 객체
// DummyData를 URLSessionDataTask에 초기화와 동시에 전달
class StubURLSession: URLSessionProtocol {
    var dummyData: DummyData?
    
    init(dummy: DummyData) {
        self.dummyData = dummy
    }

    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTask {
        return StubURLSessionDataTask(dummy: dummyData, completionHandler: completionHandler)
    }
}

// 테스트 중에 URLSessionDataTask를 대체할 객체
// resume을 통해 completion handler 수행
// dummyData의 completion을 호출하여 dummyData의 프로퍼티에 접근 가능
class StubURLSessionDataTask: URLSessionDataTask {
    var dummyData: DummyData?
    
    init(dummy: DummyData?, completionHandler: DataTaskCompletionHandler?) {
        self.dummyData = dummy
        self.dummyData?.completionHandler = completionHandler
    }
    
    override func resume() {
        dummyData?.completion()
    }
}
