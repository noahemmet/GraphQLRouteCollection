import GraphQL
import Vapor

extension GraphQLResult: ResponseEncodable {
  public func encode(for req: Request) throws -> Future<Response> {
    let graphql = try req.make(GraphQLService.self)
    return try graphql
      .execute(req)
      .encode(for: req)
  }
}
