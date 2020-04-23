import PureSwiftJSONCoding

public final class JSONEncoder {
  private let encoder = PureSwiftJSONCoding.JSONEncoder()

  public init() {}

  public func encode<T: Encodable>(_ value: T) throws -> Data {
    try Data(encoder.encode(value))
  }
}

public final class JSONDecoder {
  private let decoder = PureSwiftJSONCoding.JSONDecoder()

  public init() {}

  public func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
    try decoder.decode(type, from: data)
  }
}
