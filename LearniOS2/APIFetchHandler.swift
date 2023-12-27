import Foundation
import Alamofire

class APIFetchHandler {
    static let sharedInstance = APIFetchHandler()
    func fetchAPIData(completion: @escaping ([Model]) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts";
        var result = [Model]()
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response{ resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let models: [Model] = try JSONDecoder().decode([Model].self, from: data!)
                        models.forEach { model in
                            result.append(model)
                            print(model.title + "\n")
                        }
                        completion(models)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

struct Model: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
