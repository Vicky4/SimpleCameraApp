#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#import "Synchronicity.pbobjc.h"
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPC.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

@class ChangePasswordReply;
@class ChangePasswordRequest;
@class CheckAuthReply;
@class CheckAuthRequest;
@class LoginReply;
@class LoginRequest;
@class RegisterReply;
@class RegisterRequest;
@class RequestChangePasswordReply;
@class RequestChangePasswordRequest;
@class StreamData;
@class StreamDataBytes;
@class StreamDataResponse;
@class StreamDataResponseBytes;
@class TokenRefreshReply;
@class TokenRefreshRequest;

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#endif

@class GRPCProtoCall;


NS_ASSUME_NONNULL_BEGIN

@protocol Synchronicity <NSObject>

#pragma mark CheckAuth(CheckAuthRequest) returns (CheckAuthReply)

- (void)checkAuthWithRequest:(CheckAuthRequest *)request handler:(void(^)(CheckAuthReply *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToCheckAuthWithRequest:(CheckAuthRequest *)request handler:(void(^)(CheckAuthReply *_Nullable response, NSError *_Nullable error))handler;


#pragma mark TokenRefresh(TokenRefreshRequest) returns (TokenRefreshReply)

- (void)tokenRefreshWithRequest:(TokenRefreshRequest *)request handler:(void(^)(TokenRefreshReply *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToTokenRefreshWithRequest:(TokenRefreshRequest *)request handler:(void(^)(TokenRefreshReply *_Nullable response, NSError *_Nullable error))handler;


#pragma mark Login(LoginRequest) returns (LoginReply)

- (void)loginWithRequest:(LoginRequest *)request handler:(void(^)(LoginReply *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToLoginWithRequest:(LoginRequest *)request handler:(void(^)(LoginReply *_Nullable response, NSError *_Nullable error))handler;


#pragma mark Register(RegisterRequest) returns (RegisterReply)

- (void)registerWithRequest:(RegisterRequest *)request handler:(void(^)(RegisterReply *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRegisterWithRequest:(RegisterRequest *)request handler:(void(^)(RegisterReply *_Nullable response, NSError *_Nullable error))handler;


#pragma mark RequestChangePassword(RequestChangePasswordRequest) returns (RequestChangePasswordReply)

- (void)requestChangePasswordWithRequest:(RequestChangePasswordRequest *)request handler:(void(^)(RequestChangePasswordReply *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToRequestChangePasswordWithRequest:(RequestChangePasswordRequest *)request handler:(void(^)(RequestChangePasswordReply *_Nullable response, NSError *_Nullable error))handler;


#pragma mark ChangePassword(ChangePasswordRequest) returns (ChangePasswordReply)

- (void)changePasswordWithRequest:(ChangePasswordRequest *)request handler:(void(^)(ChangePasswordReply *_Nullable response, NSError *_Nullable error))handler;

- (GRPCProtoCall *)RPCToChangePasswordWithRequest:(ChangePasswordRequest *)request handler:(void(^)(ChangePasswordReply *_Nullable response, NSError *_Nullable error))handler;


#pragma mark SimpleRPC(stream StreamData) returns (stream StreamDataResponse)

- (void)simpleRPCWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, StreamDataResponse *_Nullable response, NSError *_Nullable error))eventHandler;

- (GRPCProtoCall *)RPCToSimpleRPCWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, StreamDataResponse *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark SimpleRPCBytes(stream StreamDataBytes) returns (stream StreamDataResponseBytes)

- (void)simpleRPCBytesWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, StreamDataResponseBytes *_Nullable response, NSError *_Nullable error))eventHandler;

- (GRPCProtoCall *)RPCToSimpleRPCBytesWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, StreamDataResponseBytes *_Nullable response, NSError *_Nullable error))eventHandler;


@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface Synchronicity : GRPCProtoService<Synchronicity>
- (instancetype)initWithHost:(NSString *)host NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

