#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import "Synchronicity.pbrpc.h"
#import "Synchronicity.pbobjc.h"
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriter+Immediate.h>


@implementation Synchronicity

// Designated initializer
- (instancetype)initWithHost:(NSString *)host {
  self = [super initWithHost:host
                 packageName:@"protod"
                 serviceName:@"Synchronicity"];
  return self;
}

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

#pragma mark - Method Implementations

#pragma mark CheckAuth(CheckAuthRequest) returns (CheckAuthReply)

- (void)checkAuthWithRequest:(CheckAuthRequest *)request handler:(void(^)(CheckAuthReply *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToCheckAuthWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToCheckAuthWithRequest:(CheckAuthRequest *)request handler:(void(^)(CheckAuthReply *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"CheckAuth"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[CheckAuthReply class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark TokenRefresh(TokenRefreshRequest) returns (TokenRefreshReply)

- (void)tokenRefreshWithRequest:(TokenRefreshRequest *)request handler:(void(^)(TokenRefreshReply *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToTokenRefreshWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToTokenRefreshWithRequest:(TokenRefreshRequest *)request handler:(void(^)(TokenRefreshReply *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"TokenRefresh"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[TokenRefreshReply class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark Login(LoginRequest) returns (LoginReply)

- (void)loginWithRequest:(LoginRequest *)request handler:(void(^)(LoginReply *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToLoginWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToLoginWithRequest:(LoginRequest *)request handler:(void(^)(LoginReply *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"Login"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[LoginReply class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark Register(RegisterRequest) returns (RegisterReply)

- (void)registerWithRequest:(RegisterRequest *)request handler:(void(^)(RegisterReply *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRegisterWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToRegisterWithRequest:(RegisterRequest *)request handler:(void(^)(RegisterReply *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"Register"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RegisterReply class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark RequestChangePassword(RequestChangePasswordRequest) returns (RequestChangePasswordReply)

- (void)requestChangePasswordWithRequest:(RequestChangePasswordRequest *)request handler:(void(^)(RequestChangePasswordReply *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToRequestChangePasswordWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToRequestChangePasswordWithRequest:(RequestChangePasswordRequest *)request handler:(void(^)(RequestChangePasswordReply *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"RequestChangePassword"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[RequestChangePasswordReply class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark ChangePassword(ChangePasswordRequest) returns (ChangePasswordReply)

- (void)changePasswordWithRequest:(ChangePasswordRequest *)request handler:(void(^)(ChangePasswordReply *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCToChangePasswordWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToChangePasswordWithRequest:(ChangePasswordRequest *)request handler:(void(^)(ChangePasswordReply *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"ChangePassword"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[ChangePasswordReply class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
#pragma mark SimpleRPC(stream StreamData) returns (stream StreamDataResponse)

- (void)simpleRPCWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, StreamDataResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToSimpleRPCWithRequestsWriter:requestWriter eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToSimpleRPCWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, StreamDataResponse *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"SimpleRPC"
            requestsWriter:requestWriter
             responseClass:[StreamDataResponse class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
#pragma mark SimpleRPCBytes(stream StreamDataBytes) returns (stream StreamDataResponseBytes)

- (void)simpleRPCBytesWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, StreamDataResponseBytes *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCToSimpleRPCBytesWithRequestsWriter:requestWriter eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCToSimpleRPCBytesWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, StreamDataResponseBytes *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"SimpleRPCBytes"
            requestsWriter:requestWriter
             responseClass:[StreamDataResponseBytes class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
@end
#endif
