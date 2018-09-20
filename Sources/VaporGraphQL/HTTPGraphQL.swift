import Vapor
import GraphQL

public typealias ExecutionContext = (
  schema: GraphQLSchema,
  rootValue: Any,
  context: Any
)

/// Provides HTTPGraphQL an execution context to perform per request.
public typealias ExecutionContextProvider = (Request) throws -> ExecutionContext

public struct HTTPGraphQL: GraphQLService {
  
  /// Provides the schema based off the given request.
  public let executionContextProvider: ExecutionContextProvider
  
  /// If enabled, HTTPGraphQL returns an introspection of the GraphQL Schema if
  /// given an empty query.
  public let enableIntrospection: Bool
  
  /// Moves the graphql execution to a separate thread so the NIO event loop
  /// isn't blocked.
  private  let dispatchQueue: DispatchQueue
  
  public init(
    enableIntrospection: Bool = true,
    executionContextProvider: @escaping ExecutionContextProvider)
  {
    self.executionContextProvider = executionContextProvider
    self.enableIntrospection = enableIntrospection
    self.dispatchQueue = DispatchQueue(
      label: "HTTP GraphQL Execution Queue",
      qos: .userInitiated,
      attributes: .concurrent
    )
  }
  
  public func execute(_ executionRequest: GraphQLExecutionRequest, for req: Request) -> Future<Map> {
    if executionRequest.query == "" && executionRequest.variables.isEmpty && self.enableIntrospection {
      return self.executeIntrospectionQuery(for: req)
    }
//    let promise = req.eventLoop.newPromise(Map.self);
//    self.dispatchQueue.async {
      do {
        let (schema, rootValue, context) = try self.executionContextProvider(req)
        let result = try graphql(
//            queryStrategy: <#T##QueryFieldExecutionStrategy#>, 
//                    mutationStrategy: <#T##MutationFieldExecutionStrategy#>, 
//                    subscriptionStrategy: <#T##SubscriptionFieldExecutionStrategy#>, 
//                    instrumentation: <#T##Instrumentation#>, 
                    schema: schema, 
                    request: executionRequest.query, 
                    rootValue: rootValue, 
                    context: context, 
                    eventLoopGroup: req, 
                    variableValues: executionRequest.variables, 
                    operationName: executionRequest.operationName)
        return result
//        promise.succeed(result: result)
//        promise.succeed(result: try graphql(
//          queryStrategy: ConcurrentDispatchFieldExecutionStrategy(dispatchQueue: self.dispatchQueue),
//          subscriptionStrategy: ConcurrentDispatchFieldExecutionStrategy(dispatchQueue: self.dispatchQueue),
//          schema: schema,
//          request: executionRequest.query,
//          rootValue: rootValue,
//          context: context,
//          variableValues: executionRequest.variables,
//          operationName: executionRequest.operationName)
//        )
      } catch let e as GraphQLError {
        let graphQLError: [String: Map] = [
                  "data": [
                    "errors": [e.map]
                  ]
                ]
        let map = Map.dictionary(graphQLError)
        return req.future(map)
//        promise.succeed(result: [
//          "data": [
//            "errors": [e.map]
//          ]
//        ])
      } catch let e {
        fatalError("\(e)")
//        return req.future(Map.
//        promise.fail(error: e)
      }
//    }
//    return promise.futureResult
  }
  
}
