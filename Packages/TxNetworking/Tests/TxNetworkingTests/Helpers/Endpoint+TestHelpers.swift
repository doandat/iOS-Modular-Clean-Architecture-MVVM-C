import Foundation
import Moya

extension Endpoint {
    func replacing(task: Task) -> Endpoint {
        return Endpoint(
            url: self.url,
            sampleResponseClosure: self.sampleResponseClosure,
            method: self.method,
            task: task,
            httpHeaderFields: self.httpHeaderFields
        )
    }
}
