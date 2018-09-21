///// Wraps resolvers to provide better type support when working with GraphQL.
//
//import GraphQL
//import NIO
//
//enum TypedFieldResolveError: Error {
//  case InvalidType
//}
//
//public typealias TypedTypeResolver1<Value, Result: TypeResolveResultRepresentable> = (
//  _ value: Value
////    ,
////    _ eventLoopGroup: EventLoopGroup
//  ) throws -> Result
//
//public typealias TypedTypeResolver2<Value, Context, Result: TypeResolveResultRepresentable> = (
//  _ value: Value,
//  _ context: Context//,
////    _ eventLoopGroup: EventLoopGroup
//  ) throws -> Result
//
//public typealias TypedTypeResolver3<Value, Context, Result: TypeResolveResultRepresentable> = (
//  _ value: Value,
//  _ context: Context,
////    _ eventLoopGroup: EventLoopGroup,
//  _ info: GraphQLResolveInfo
//  ) throws -> Result
//
//public typealias TypedFieldResolver1<Source, Result> = (
//  _ source: Source,
//  _ args: Map,
//    _ eventLoopGroup: EventLoopGroup
//  ) throws -> Result?
//
//public typealias TypedFieldResolver2<Source, Context, Result> = (
//  _ source: Source,
//  _ args: Map,
//  _ context: Context,
//    _ eventLoopGroup: EventLoopGroup
//  ) throws -> Result?
//
//public typealias TypedFieldResolver3<Source, Context, Result> = (
//  _ source: Source,
//  _ args: Map,
//  _ context: Context,
//    _ eventLoopGroup: EventLoopGroup,
//  _ info: GraphQLResolveInfo
//  ) throws -> Result?
//
//public func withTypedResolve<Source, Result>(resolver: @escaping TypedFieldResolver1<Source, Result>) -> GraphQLFieldResolve {
////    _ source: Any,
////    _ args: Map,
////    _ context: Any,
////    _ eventLoopGroup: EventLoopGroup,
////    _ info: GraphQLResolveInfo
//
//    return { (source: Any, args: Map, context: Any, eventLoopGroup: EventLoopGroup, info: GraphQLResolveInfo) throws in
//    guard let typedSource = source as? Source else {
//      throw TypedFieldResolveError.InvalidType
//    }
//        let resolved = try resolver(typedSource, args, eventLoopGroup) 
//    return eventLoopGroup.future(resolved)
//  }
//}
//
//public func withTypedResolve<Source, Context, Result>(resolver: @escaping TypedFieldResolver2<Source, Context, Result>) -> GraphQLFieldResolve {
//  return { (source: Any, args: Map, context: Any, eventLoopGroup: EventLoopGroup, info: GraphQLResolveInfo) throws in
//    guard
//      let typedSource = source as? Source,
//      let typedContext = context as? Context else {
//        throw TypedFieldResolveError.InvalidType
//    }
//    return eventLoopGroup.future(try resolver(typedSource, args, typedContext, eventLoopGroup))
//  }
//}
//
//public func withTypedResolve<Source, Context, Result>(resolver: @escaping TypedFieldResolver3<Source, Context, Result>) -> GraphQLFieldResolve {
//  return { (source: Any, args: Map, context: Any, eventLoopGroup: EventLoopGroup, info: GraphQLResolveInfo) throws in
//    guard
//      let typedSource = source as? Source,
//      let typedContext = context as? Context else {
//        throw TypedFieldResolveError.InvalidType
//    }
//    return eventLoopGroup.future(try resolver(typedSource, args, typedContext, eventLoopGroup, info))
//  }
//}
//
//public func withTypedResolve<Value, Result: TypeResolveResultRepresentable>(
//  resolver: @escaping TypedTypeResolver1<Value, Result>
//) throws -> GraphQLTypeResolve {
//  return { (value: Any, context: Any, info: GraphQLResolveInfo) throws in
//    guard let typedValue = value as? Value else {
//      throw TypedFieldResolveError.InvalidType
//    }
//    return try resolver(typedValue)
//  }
//}
//
//public func withTypedResolve<Value, Context, Result: TypeResolveResultRepresentable>(
//  resolver: @escaping TypedTypeResolver2<Value, Context, Result>
//) throws -> GraphQLTypeResolve {
//  return { (value: Any, context: Any, info: GraphQLResolveInfo) throws in
//    guard
//      let typedValue = value as? Value,
//      let typedContext = context as? Context else {
//        throw TypedFieldResolveError.InvalidType
//    }
//    return try resolver(typedValue, typedContext)
//  }
//}
//
//public func withTypedResolve<Value, Context, Result: TypeResolveResultRepresentable>(
//  resolver: @escaping TypedTypeResolver3<Value, Context, Result>
//  ) throws -> GraphQLTypeResolve {
//  return { (value: Any, context: Any, info: GraphQLResolveInfo) throws in
//    guard
//      let typedValue = value as? Value,
//      let typedContext = context as? Context else {
//        throw TypedFieldResolveError.InvalidType
//    }
//    return try resolver(typedValue, typedContext, info)
//  }
//}
