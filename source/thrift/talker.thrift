namespace cpp kiwi
namespace cocoa kiwi
namespace java me.hatice.kiwi

const string KIWI_VERSION = "0.0.1"
const i32 MAX_RESULTS = 25;
const i32 DEFAULT_ROOMS = 3;

enum ErrorCode {
    ILLEGAL_ARGUMENT = 0;
    AUTHENTICATION_FAILED = 1;
    DB_FAILED = 2;
    INVALID_STATE = 3;
    EXCESSIVE_ACCESS = 4;
    NOT_FOUND = 5;
    INVALID_LENGTH = 6;
    NOT_AVAILABLE_USER = 7;
    NOT_AUTHORIZED_DEVICE = 8;
    INVALID_MID = 9;
    NOT_A_MEMBER = 10;
    INCOMPATIBLE_APP_VERSION = 11;
    NOT_READY = 12;
    NOT_AVAILABLE_SESSION = 13;
    NOT_AUTHORIZED_SESSION = 14;
    SYSTEM_ERROR = 15;
    NO_AVAILABLE_VERIFICATION_METHOD = 16;
    NOT_AUTHENTICATED = 17;
    INVALID_IDENTITY_CREDENTIAL = 18;
    NOT_AVAILABLE_IDENTITY_IDENTIFIER = 19;
    INTERNAL_ERROR = 20;
    NO_SUCH_IDENTITY_IDENFIER = 21;
    DEACTIVATED_ACCOUNT_BOUND_TO_THIS_IDENTITY = 22;
    ILLEGAL_IDENTITY_CREDENTIAL = 23;
    UNKNOWN_CHANNEL = 24;
    NO_SUCH_MESSAGE_BOX = 25;
    NOT_AVAILABLE_MESSAGE_BOX = 26;
    CHANNEL_DOES_NOT_MATCH = 27;
    NOT_YOUR_MESSAGE = 28;
    MESSAGE_DEFINED_ERROR = 29;
    USER_CANNOT_ACCEPT_PRESENTS = 30;
    USER_NOT_STICKER_OWNER = 32;
    MAINTENANCE_ERROR = 33;
    ACCOUNT_NOT_MATCHED = 34;
    ABUSE_BLOCK = 35;
    NOT_FRIEND = 36;
    NOT_ALLOWED_CALL = 37;
    BLOCK_FRIEND = 38;
    INCOMPATIBLE_VOIP_VERSION = 39;
    INVALID_SNS_ACCESS_TOKEN = 40;
    EXTERNAL_SERVICE_NOT_AVAILABLE = 41;
    NOT_ALLOWED_ADD_CONTACT = 42;
    NOT_CERTIFICATED = 43;
    NOT_ALLOWED_SECONDARY_DEVICE = 44;
    INVALID_PIN_CODE = 45;
    NOT_FOUND_IDENTITY_CREDENTIAL = 46;
    EXCEED_FILE_MAX_SIZE = 47;
    EXCEED_DAILY_QUOTA = 48;
    NOT_SUPPORT_SEND_FILE = 49;
    MUST_UPGRADE = 50;
    NOT_AVAILABLE_PIN_CODE_SESSION = 51;
}


enum NotificationType {
    APPLE_APNS = 1;
    GOOGLE_C2DM = 2;
    NHN_NNI = 3;
    SKT_AOM = 4;
    MS_MPNS = 5;
    RIM_BIS = 6;
    GOOGLE_GCM = 7;
    NOKIA_NNAPI = 8;
    TIZEN = 9;
}

struct ServiceInfo {
	1: string ServiceName,
	2: string AliasName,
	3: string HostName,
	4: string Version,
	5: i32 ServicePort,
	6: i32 Onlines,
}

typedef list<ServiceInfo> ServiceList


struct Location {
    1: required double latitude;
    2: required double longitude;
}

enum ShipType {
    RESERVED,
    CONNECT = 0x01,
    PUBLISH = 0x02,
    SUBSCRIBE   = 0x03,
    DISCONNECT  = 0x04,
    TEXT = 0x10,
    TEXTURE = 0x0a,
    ACTION = 0x1a,
    PICTURE = 0x2a,
    ANIMATION = 0x3a,
    VOICE = 0x4a,
    LOCATION = 0x5a,
}

struct Ship {
	1: required string userId,
	2: required string nickName,
	3: required ShipType shipType = ShipType.TEXT,
	4: required i32 timeStamp,
	5: optional i32 shipId,
	6: optional string text,
	7: optional binary picture,
	8: optional binary animation,
	9: optional Location loc,
	10: optional string action,
	11: optional string texId,
}

/// response option
enum Response {
	ACCEPTED = 0x0a,
	REFUSE = 0x1a,
}

#
# Exceptions
# (note that internal server errors will raise a TApplicationException, courtesy of Thrift)
#
/** A specific column was requested that does not exist. */
exception NotFoundException {
}

/** Invalid request could mean keyspace or column family does not exist, required parameters are missing, or a parameter is malformed.
    why contains an associated error message.
*/
exception InvalidRequestException {
    1: required string why
}

/** Not all the replicas required could be created and/or read. */
exception UnavailableException {
}

/** RPC timeout was exceeded.  either a node failed mid-operation, or load was too high, or the requested op was too large. */
exception TimedOutException {
}


/** invalid Request  */
exception RequestException {
    1: ErrorCode code;
    2: string why;
    3: map<string, string> parameterMap;
}

/* service to service talk in whisper */
service baseService {
	void ConnectDB()
    throws (1:RequestException re, 2:TimedOutException te),
	string FindUid( 1:required string email, 2:required string phoneNo )
    throws (1:RequestException re, 2:TimedOutException te),

	bool FindEmail( 1:required string email )
    throws (1:RequestException re, 2:TimedOutException te),

  i32 Ping(),

  /** get the version of server */
  string GetVersion()
    throws (1:RequestException re, 2:TimedOutException te);

  void subscribe( 1:required string topic )
    throws (1:RequestException re, 2:TimedOutException te);

  void unsubscribe( 1:required string topic)
    throws (1:RequestException re, 2:TimedOutException te);

  /** ship api */
  oneway void postShip( 1:required string channel, 2:required Ship ship);

  oneway void receiveShip( 1:required Ship ship );

}