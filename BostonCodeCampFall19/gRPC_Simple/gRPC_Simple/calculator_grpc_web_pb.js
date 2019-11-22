/**
 * @fileoverview gRPC-Web generated client stub for grpcdemo
 * @enhanceable
 * @public
 */

// GENERATED CODE -- DO NOT EDIT!



const grpc = {};
grpc.web = require('grpc-web');

const proto = {};
proto.grpcdemo = require('./calculator_pb.js');

/**
 * @param {string} hostname
 * @param {?Object} credentials
 * @param {?Object} options
 * @constructor
 * @struct
 * @final
 */
proto.grpcdemo.AddDemoClient =
    function(hostname, credentials, options) {
  if (!options) options = {};
  options['format'] = 'text';

  /**
   * @private @const {!grpc.web.GrpcWebClientBase} The client
   */
  this.client_ = new grpc.web.GrpcWebClientBase(options);

  /**
   * @private @const {string} The hostname
   */
  this.hostname_ = hostname;

};


/**
 * @param {string} hostname
 * @param {?Object} credentials
 * @param {?Object} options
 * @constructor
 * @struct
 * @final
 */
proto.grpcdemo.AddDemoPromiseClient =
    function(hostname, credentials, options) {
  if (!options) options = {};
  options['format'] = 'text';

  /**
   * @private @const {!grpc.web.GrpcWebClientBase} The client
   */
  this.client_ = new grpc.web.GrpcWebClientBase(options);

  /**
   * @private @const {string} The hostname
   */
  this.hostname_ = hostname;

};


/**
 * @const
 * @type {!grpc.web.MethodDescriptor<
 *   !proto.grpcdemo.AddRequest,
 *   !proto.grpcdemo.AddReply>}
 */
const methodDescriptor_AddDemo_AddNumber = new grpc.web.MethodDescriptor(
  '/grpcdemo.AddDemo/AddNumber',
  grpc.web.MethodType.UNARY,
  proto.grpcdemo.AddRequest,
  proto.grpcdemo.AddReply,
  /**
   * @param {!proto.grpcdemo.AddRequest} request
   * @return {!Uint8Array}
   */
  function(request) {
    return request.serializeBinary();
  },
  proto.grpcdemo.AddReply.deserializeBinary
);


/**
 * @const
 * @type {!grpc.web.AbstractClientBase.MethodInfo<
 *   !proto.grpcdemo.AddRequest,
 *   !proto.grpcdemo.AddReply>}
 */
const methodInfo_AddDemo_AddNumber = new grpc.web.AbstractClientBase.MethodInfo(
  proto.grpcdemo.AddReply,
  /**
   * @param {!proto.grpcdemo.AddRequest} request
   * @return {!Uint8Array}
   */
  function(request) {
    return request.serializeBinary();
  },
  proto.grpcdemo.AddReply.deserializeBinary
);


/**
 * @param {!proto.grpcdemo.AddRequest} request The
 *     request proto
 * @param {?Object<string, string>} metadata User defined
 *     call metadata
 * @param {function(?grpc.web.Error, ?proto.grpcdemo.AddReply)}
 *     callback The callback function(error, response)
 * @return {!grpc.web.ClientReadableStream<!proto.grpcdemo.AddReply>|undefined}
 *     The XHR Node Readable Stream
 */
proto.grpcdemo.AddDemoClient.prototype.addNumber =
    function(request, metadata, callback) {
  return this.client_.rpcCall(this.hostname_ +
      '/grpcdemo.AddDemo/AddNumber',
      request,
      metadata || {},
      methodDescriptor_AddDemo_AddNumber,
      callback);
};


/**
 * @param {!proto.grpcdemo.AddRequest} request The
 *     request proto
 * @param {?Object<string, string>} metadata User defined
 *     call metadata
 * @return {!Promise<!proto.grpcdemo.AddReply>}
 *     A native promise that resolves to the response
 */
proto.grpcdemo.AddDemoPromiseClient.prototype.addNumber =
    function(request, metadata) {
  return this.client_.unaryCall(this.hostname_ +
      '/grpcdemo.AddDemo/AddNumber',
      request,
      metadata || {},
      methodDescriptor_AddDemo_AddNumber);
};


module.exports = proto.grpcdemo;

