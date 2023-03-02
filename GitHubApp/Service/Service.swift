import Foundation

struct Service {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()) {
        self.network = network
    }

    func fetchList(of user: String, completion: @escaping ([Repository]?) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(user)/repos")
        
        if url != nil {
            self.network.performGet(url: url!, completion: { data in
                do {
                    let jsonDecoder = JSONDecoder()
                    let repositories = try jsonDecoder.decode([Repository].self, from: data!)
                    completion(repositories)
                } catch {
                    print("Their is an error!")
                }
            })
        }
    }
}
