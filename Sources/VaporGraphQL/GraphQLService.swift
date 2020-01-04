import Vapor
import GraphQL

/// Protocol for services that can execute graphql queries from vapor requests. This protocol exists
/// to allow testing with mock services. For actual use, see HTTPGraphQL.
public protocol GraphQLService: Service {
  
  /// Execute a graphql request.
  func execute(_ executionRequest: GraphQLExecutionRequest, for req: Request) -> Future<GraphQLResult>
  
}

public extension GraphQLService {
  
  /// Executes graphql from either POST or GET requests.
  func execute(_ req: Request) throws -> Future<GraphQLResult> {
    if req.http.method == .GET {
      return try self.executeGet(req)
    } else if req.http.method == .POST {
      return try self.executePost(req)
    }
    throw Abort(.methodNotAllowed)
  }
  
  private func executeGet(_ req: Request) throws -> Future<GraphQLResult> {
    return try self.execute(
      GraphQLExecutionRequest(url: req.http.url),
      for: req
    )
  }
  
  private func executePost(_ req: Request) throws -> Future<GraphQLResult> {
    return try req.content.decode(GraphQLExecutionRequest.self)
      .then { executionRequest -> Future<GraphQLResult> in
        self.execute(
          executionRequest,
          for: req
        )
    }
  }
  
}
