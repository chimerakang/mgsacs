/**
 * Autogenerated by Thrift Compiler (0.9.3)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
#include "talker_types.h"

#include <algorithm>
#include <ostream>

#include <thrift/TToString.h>

namespace kiwi {

int _kErrorCodeValues[] = {
  ErrorCode::ILLEGAL_ARGUMENT,
  ErrorCode::AUTHENTICATION_FAILED,
  ErrorCode::DB_FAILED,
  ErrorCode::INVALID_STATE,
  ErrorCode::EXCESSIVE_ACCESS,
  ErrorCode::NOT_FOUND,
  ErrorCode::INVALID_LENGTH,
  ErrorCode::NOT_AVAILABLE_USER,
  ErrorCode::NOT_AUTHORIZED_DEVICE,
  ErrorCode::INVALID_MID,
  ErrorCode::NOT_A_MEMBER,
  ErrorCode::INCOMPATIBLE_APP_VERSION,
  ErrorCode::NOT_READY,
  ErrorCode::NOT_AVAILABLE_SESSION,
  ErrorCode::NOT_AUTHORIZED_SESSION,
  ErrorCode::SYSTEM_ERROR,
  ErrorCode::NO_AVAILABLE_VERIFICATION_METHOD,
  ErrorCode::NOT_AUTHENTICATED,
  ErrorCode::INVALID_IDENTITY_CREDENTIAL,
  ErrorCode::NOT_AVAILABLE_IDENTITY_IDENTIFIER,
  ErrorCode::INTERNAL_ERROR,
  ErrorCode::NO_SUCH_IDENTITY_IDENFIER,
  ErrorCode::DEACTIVATED_ACCOUNT_BOUND_TO_THIS_IDENTITY,
  ErrorCode::ILLEGAL_IDENTITY_CREDENTIAL,
  ErrorCode::UNKNOWN_CHANNEL,
  ErrorCode::NO_SUCH_MESSAGE_BOX,
  ErrorCode::NOT_AVAILABLE_MESSAGE_BOX,
  ErrorCode::CHANNEL_DOES_NOT_MATCH,
  ErrorCode::NOT_YOUR_MESSAGE,
  ErrorCode::MESSAGE_DEFINED_ERROR,
  ErrorCode::USER_CANNOT_ACCEPT_PRESENTS,
  ErrorCode::USER_NOT_STICKER_OWNER,
  ErrorCode::MAINTENANCE_ERROR,
  ErrorCode::ACCOUNT_NOT_MATCHED,
  ErrorCode::ABUSE_BLOCK,
  ErrorCode::NOT_FRIEND,
  ErrorCode::NOT_ALLOWED_CALL,
  ErrorCode::BLOCK_FRIEND,
  ErrorCode::INCOMPATIBLE_VOIP_VERSION,
  ErrorCode::INVALID_SNS_ACCESS_TOKEN,
  ErrorCode::EXTERNAL_SERVICE_NOT_AVAILABLE,
  ErrorCode::NOT_ALLOWED_ADD_CONTACT,
  ErrorCode::NOT_CERTIFICATED,
  ErrorCode::NOT_ALLOWED_SECONDARY_DEVICE,
  ErrorCode::INVALID_PIN_CODE,
  ErrorCode::NOT_FOUND_IDENTITY_CREDENTIAL,
  ErrorCode::EXCEED_FILE_MAX_SIZE,
  ErrorCode::EXCEED_DAILY_QUOTA,
  ErrorCode::NOT_SUPPORT_SEND_FILE,
  ErrorCode::MUST_UPGRADE,
  ErrorCode::NOT_AVAILABLE_PIN_CODE_SESSION
};
const char* _kErrorCodeNames[] = {
  "ILLEGAL_ARGUMENT",
  "AUTHENTICATION_FAILED",
  "DB_FAILED",
  "INVALID_STATE",
  "EXCESSIVE_ACCESS",
  "NOT_FOUND",
  "INVALID_LENGTH",
  "NOT_AVAILABLE_USER",
  "NOT_AUTHORIZED_DEVICE",
  "INVALID_MID",
  "NOT_A_MEMBER",
  "INCOMPATIBLE_APP_VERSION",
  "NOT_READY",
  "NOT_AVAILABLE_SESSION",
  "NOT_AUTHORIZED_SESSION",
  "SYSTEM_ERROR",
  "NO_AVAILABLE_VERIFICATION_METHOD",
  "NOT_AUTHENTICATED",
  "INVALID_IDENTITY_CREDENTIAL",
  "NOT_AVAILABLE_IDENTITY_IDENTIFIER",
  "INTERNAL_ERROR",
  "NO_SUCH_IDENTITY_IDENFIER",
  "DEACTIVATED_ACCOUNT_BOUND_TO_THIS_IDENTITY",
  "ILLEGAL_IDENTITY_CREDENTIAL",
  "UNKNOWN_CHANNEL",
  "NO_SUCH_MESSAGE_BOX",
  "NOT_AVAILABLE_MESSAGE_BOX",
  "CHANNEL_DOES_NOT_MATCH",
  "NOT_YOUR_MESSAGE",
  "MESSAGE_DEFINED_ERROR",
  "USER_CANNOT_ACCEPT_PRESENTS",
  "USER_NOT_STICKER_OWNER",
  "MAINTENANCE_ERROR",
  "ACCOUNT_NOT_MATCHED",
  "ABUSE_BLOCK",
  "NOT_FRIEND",
  "NOT_ALLOWED_CALL",
  "BLOCK_FRIEND",
  "INCOMPATIBLE_VOIP_VERSION",
  "INVALID_SNS_ACCESS_TOKEN",
  "EXTERNAL_SERVICE_NOT_AVAILABLE",
  "NOT_ALLOWED_ADD_CONTACT",
  "NOT_CERTIFICATED",
  "NOT_ALLOWED_SECONDARY_DEVICE",
  "INVALID_PIN_CODE",
  "NOT_FOUND_IDENTITY_CREDENTIAL",
  "EXCEED_FILE_MAX_SIZE",
  "EXCEED_DAILY_QUOTA",
  "NOT_SUPPORT_SEND_FILE",
  "MUST_UPGRADE",
  "NOT_AVAILABLE_PIN_CODE_SESSION"
};
const std::map<int, const char*> _ErrorCode_VALUES_TO_NAMES(::apache::thrift::TEnumIterator(51, _kErrorCodeValues, _kErrorCodeNames), ::apache::thrift::TEnumIterator(-1, NULL, NULL));

int _kNotificationTypeValues[] = {
  NotificationType::APPLE_APNS,
  NotificationType::GOOGLE_C2DM,
  NotificationType::NHN_NNI,
  NotificationType::SKT_AOM,
  NotificationType::MS_MPNS,
  NotificationType::RIM_BIS,
  NotificationType::GOOGLE_GCM,
  NotificationType::NOKIA_NNAPI,
  NotificationType::TIZEN
};
const char* _kNotificationTypeNames[] = {
  "APPLE_APNS",
  "GOOGLE_C2DM",
  "NHN_NNI",
  "SKT_AOM",
  "MS_MPNS",
  "RIM_BIS",
  "GOOGLE_GCM",
  "NOKIA_NNAPI",
  "TIZEN"
};
const std::map<int, const char*> _NotificationType_VALUES_TO_NAMES(::apache::thrift::TEnumIterator(9, _kNotificationTypeValues, _kNotificationTypeNames), ::apache::thrift::TEnumIterator(-1, NULL, NULL));

int _kShipTypeValues[] = {
  ShipType::RESERVED,
  ShipType::CONNECT,
  ShipType::PUBLISH,
  ShipType::SUBSCRIBE,
  ShipType::DISCONNECT,
  ShipType::TEXT,
  ShipType::TEXTURE,
  ShipType::ACTION,
  ShipType::PICTURE,
  ShipType::ANIMATION,
  ShipType::VOICE,
  ShipType::LOCATION
};
const char* _kShipTypeNames[] = {
  "RESERVED",
  "CONNECT",
  "PUBLISH",
  "SUBSCRIBE",
  "DISCONNECT",
  "TEXT",
  "TEXTURE",
  "ACTION",
  "PICTURE",
  "ANIMATION",
  "VOICE",
  "LOCATION"
};
const std::map<int, const char*> _ShipType_VALUES_TO_NAMES(::apache::thrift::TEnumIterator(12, _kShipTypeValues, _kShipTypeNames), ::apache::thrift::TEnumIterator(-1, NULL, NULL));


ServiceInfo::~ServiceInfo() throw() {
}


void ServiceInfo::__set_ServiceName(const std::string& val) {
  this->ServiceName = val;
}

void ServiceInfo::__set_AliasName(const std::string& val) {
  this->AliasName = val;
}

void ServiceInfo::__set_HostName(const std::string& val) {
  this->HostName = val;
}

void ServiceInfo::__set_Version(const std::string& val) {
  this->Version = val;
}

void ServiceInfo::__set_ServicePort(const int32_t val) {
  this->ServicePort = val;
}

void ServiceInfo::__set_Onlines(const int32_t val) {
  this->Onlines = val;
}

uint32_t ServiceInfo::read(::apache::thrift::protocol::TProtocol* iprot) {

  apache::thrift::protocol::TInputRecursionTracker tracker(*iprot);
  uint32_t xfer = 0;
  std::string fname;
  ::apache::thrift::protocol::TType ftype;
  int16_t fid;

  xfer += iprot->readStructBegin(fname);

  using ::apache::thrift::protocol::TProtocolException;


  while (true)
  {
    xfer += iprot->readFieldBegin(fname, ftype, fid);
    if (ftype == ::apache::thrift::protocol::T_STOP) {
      break;
    }
    switch (fid)
    {
      case 1:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->ServiceName);
          this->__isset.ServiceName = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 2:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->AliasName);
          this->__isset.AliasName = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 3:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->HostName);
          this->__isset.HostName = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 4:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->Version);
          this->__isset.Version = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 5:
        if (ftype == ::apache::thrift::protocol::T_I32) {
          xfer += iprot->readI32(this->ServicePort);
          this->__isset.ServicePort = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 6:
        if (ftype == ::apache::thrift::protocol::T_I32) {
          xfer += iprot->readI32(this->Onlines);
          this->__isset.Onlines = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      default:
        xfer += iprot->skip(ftype);
        break;
    }
    xfer += iprot->readFieldEnd();
  }

  xfer += iprot->readStructEnd();

  return xfer;
}

uint32_t ServiceInfo::write(::apache::thrift::protocol::TProtocol* oprot) const {
  uint32_t xfer = 0;
  apache::thrift::protocol::TOutputRecursionTracker tracker(*oprot);
  xfer += oprot->writeStructBegin("ServiceInfo");

  xfer += oprot->writeFieldBegin("ServiceName", ::apache::thrift::protocol::T_STRING, 1);
  xfer += oprot->writeString(this->ServiceName);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("AliasName", ::apache::thrift::protocol::T_STRING, 2);
  xfer += oprot->writeString(this->AliasName);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("HostName", ::apache::thrift::protocol::T_STRING, 3);
  xfer += oprot->writeString(this->HostName);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("Version", ::apache::thrift::protocol::T_STRING, 4);
  xfer += oprot->writeString(this->Version);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("ServicePort", ::apache::thrift::protocol::T_I32, 5);
  xfer += oprot->writeI32(this->ServicePort);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("Onlines", ::apache::thrift::protocol::T_I32, 6);
  xfer += oprot->writeI32(this->Onlines);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldStop();
  xfer += oprot->writeStructEnd();
  return xfer;
}

void swap(ServiceInfo &a, ServiceInfo &b) {
  using ::std::swap;
  swap(a.ServiceName, b.ServiceName);
  swap(a.AliasName, b.AliasName);
  swap(a.HostName, b.HostName);
  swap(a.Version, b.Version);
  swap(a.ServicePort, b.ServicePort);
  swap(a.Onlines, b.Onlines);
  swap(a.__isset, b.__isset);
}

ServiceInfo::ServiceInfo(const ServiceInfo& other0) {
  ServiceName = other0.ServiceName;
  AliasName = other0.AliasName;
  HostName = other0.HostName;
  Version = other0.Version;
  ServicePort = other0.ServicePort;
  Onlines = other0.Onlines;
  __isset = other0.__isset;
}
ServiceInfo& ServiceInfo::operator=(const ServiceInfo& other1) {
  ServiceName = other1.ServiceName;
  AliasName = other1.AliasName;
  HostName = other1.HostName;
  Version = other1.Version;
  ServicePort = other1.ServicePort;
  Onlines = other1.Onlines;
  __isset = other1.__isset;
  return *this;
}
void ServiceInfo::printTo(std::ostream& out) const {
  using ::apache::thrift::to_string;
  out << "ServiceInfo(";
  out << "ServiceName=" << to_string(ServiceName);
  out << ", " << "AliasName=" << to_string(AliasName);
  out << ", " << "HostName=" << to_string(HostName);
  out << ", " << "Version=" << to_string(Version);
  out << ", " << "ServicePort=" << to_string(ServicePort);
  out << ", " << "Onlines=" << to_string(Onlines);
  out << ")";
}


Location::~Location() throw() {
}


void Location::__set_latitude(const double val) {
  this->latitude = val;
}

void Location::__set_longitude(const double val) {
  this->longitude = val;
}

uint32_t Location::read(::apache::thrift::protocol::TProtocol* iprot) {

  apache::thrift::protocol::TInputRecursionTracker tracker(*iprot);
  uint32_t xfer = 0;
  std::string fname;
  ::apache::thrift::protocol::TType ftype;
  int16_t fid;

  xfer += iprot->readStructBegin(fname);

  using ::apache::thrift::protocol::TProtocolException;

  bool isset_latitude = false;
  bool isset_longitude = false;

  while (true)
  {
    xfer += iprot->readFieldBegin(fname, ftype, fid);
    if (ftype == ::apache::thrift::protocol::T_STOP) {
      break;
    }
    switch (fid)
    {
      case 1:
        if (ftype == ::apache::thrift::protocol::T_DOUBLE) {
          xfer += iprot->readDouble(this->latitude);
          isset_latitude = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 2:
        if (ftype == ::apache::thrift::protocol::T_DOUBLE) {
          xfer += iprot->readDouble(this->longitude);
          isset_longitude = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      default:
        xfer += iprot->skip(ftype);
        break;
    }
    xfer += iprot->readFieldEnd();
  }

  xfer += iprot->readStructEnd();

  if (!isset_latitude)
    throw TProtocolException(TProtocolException::INVALID_DATA);
  if (!isset_longitude)
    throw TProtocolException(TProtocolException::INVALID_DATA);
  return xfer;
}

uint32_t Location::write(::apache::thrift::protocol::TProtocol* oprot) const {
  uint32_t xfer = 0;
  apache::thrift::protocol::TOutputRecursionTracker tracker(*oprot);
  xfer += oprot->writeStructBegin("Location");

  xfer += oprot->writeFieldBegin("latitude", ::apache::thrift::protocol::T_DOUBLE, 1);
  xfer += oprot->writeDouble(this->latitude);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("longitude", ::apache::thrift::protocol::T_DOUBLE, 2);
  xfer += oprot->writeDouble(this->longitude);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldStop();
  xfer += oprot->writeStructEnd();
  return xfer;
}

void swap(Location &a, Location &b) {
  using ::std::swap;
  swap(a.latitude, b.latitude);
  swap(a.longitude, b.longitude);
}

Location::Location(const Location& other2) {
  latitude = other2.latitude;
  longitude = other2.longitude;
}
Location& Location::operator=(const Location& other3) {
  latitude = other3.latitude;
  longitude = other3.longitude;
  return *this;
}
void Location::printTo(std::ostream& out) const {
  using ::apache::thrift::to_string;
  out << "Location(";
  out << "latitude=" << to_string(latitude);
  out << ", " << "longitude=" << to_string(longitude);
  out << ")";
}


Ship::~Ship() throw() {
}


void Ship::__set_userId(const std::string& val) {
  this->userId = val;
}

void Ship::__set_nickName(const std::string& val) {
  this->nickName = val;
}

void Ship::__set_shipType(const ShipType::type val) {
  this->shipType = val;
}

void Ship::__set_timeStamp(const int32_t val) {
  this->timeStamp = val;
}

void Ship::__set_shipId(const int32_t val) {
  this->shipId = val;
__isset.shipId = true;
}

void Ship::__set_text(const std::string& val) {
  this->text = val;
__isset.text = true;
}

void Ship::__set_picture(const std::string& val) {
  this->picture = val;
__isset.picture = true;
}

void Ship::__set_animation(const std::string& val) {
  this->animation = val;
__isset.animation = true;
}

void Ship::__set_loc(const Location& val) {
  this->loc = val;
__isset.loc = true;
}

void Ship::__set_action(const std::string& val) {
  this->action = val;
__isset.action = true;
}

void Ship::__set_texId(const std::string& val) {
  this->texId = val;
__isset.texId = true;
}

uint32_t Ship::read(::apache::thrift::protocol::TProtocol* iprot) {

  apache::thrift::protocol::TInputRecursionTracker tracker(*iprot);
  uint32_t xfer = 0;
  std::string fname;
  ::apache::thrift::protocol::TType ftype;
  int16_t fid;

  xfer += iprot->readStructBegin(fname);

  using ::apache::thrift::protocol::TProtocolException;

  bool isset_userId = false;
  bool isset_nickName = false;
  bool isset_shipType = false;
  bool isset_timeStamp = false;

  while (true)
  {
    xfer += iprot->readFieldBegin(fname, ftype, fid);
    if (ftype == ::apache::thrift::protocol::T_STOP) {
      break;
    }
    switch (fid)
    {
      case 1:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->userId);
          isset_userId = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 2:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->nickName);
          isset_nickName = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 3:
        if (ftype == ::apache::thrift::protocol::T_I32) {
          int32_t ecast4;
          xfer += iprot->readI32(ecast4);
          this->shipType = (ShipType::type)ecast4;
          isset_shipType = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 4:
        if (ftype == ::apache::thrift::protocol::T_I32) {
          xfer += iprot->readI32(this->timeStamp);
          isset_timeStamp = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 5:
        if (ftype == ::apache::thrift::protocol::T_I32) {
          xfer += iprot->readI32(this->shipId);
          this->__isset.shipId = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 6:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->text);
          this->__isset.text = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 7:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readBinary(this->picture);
          this->__isset.picture = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 8:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readBinary(this->animation);
          this->__isset.animation = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 9:
        if (ftype == ::apache::thrift::protocol::T_STRUCT) {
          xfer += this->loc.read(iprot);
          this->__isset.loc = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 10:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->action);
          this->__isset.action = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      case 11:
        if (ftype == ::apache::thrift::protocol::T_STRING) {
          xfer += iprot->readString(this->texId);
          this->__isset.texId = true;
        } else {
          xfer += iprot->skip(ftype);
        }
        break;
      default:
        xfer += iprot->skip(ftype);
        break;
    }
    xfer += iprot->readFieldEnd();
  }

  xfer += iprot->readStructEnd();

  if (!isset_userId)
    throw TProtocolException(TProtocolException::INVALID_DATA);
  if (!isset_nickName)
    throw TProtocolException(TProtocolException::INVALID_DATA);
  if (!isset_shipType)
    throw TProtocolException(TProtocolException::INVALID_DATA);
  if (!isset_timeStamp)
    throw TProtocolException(TProtocolException::INVALID_DATA);
  return xfer;
}

uint32_t Ship::write(::apache::thrift::protocol::TProtocol* oprot) const {
  uint32_t xfer = 0;
  apache::thrift::protocol::TOutputRecursionTracker tracker(*oprot);
  xfer += oprot->writeStructBegin("Ship");

  xfer += oprot->writeFieldBegin("userId", ::apache::thrift::protocol::T_STRING, 1);
  xfer += oprot->writeString(this->userId);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("nickName", ::apache::thrift::protocol::T_STRING, 2);
  xfer += oprot->writeString(this->nickName);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("shipType", ::apache::thrift::protocol::T_I32, 3);
  xfer += oprot->writeI32((int32_t)this->shipType);
  xfer += oprot->writeFieldEnd();

  xfer += oprot->writeFieldBegin("timeStamp", ::apache::thrift::protocol::T_I32, 4);
  xfer += oprot->writeI32(this->timeStamp);
  xfer += oprot->writeFieldEnd();

  if (this->__isset.shipId) {
    xfer += oprot->writeFieldBegin("shipId", ::apache::thrift::protocol::T_I32, 5);
    xfer += oprot->writeI32(this->shipId);
    xfer += oprot->writeFieldEnd();
  }
  if (this->__isset.text) {
    xfer += oprot->writeFieldBegin("text", ::apache::thrift::protocol::T_STRING, 6);
    xfer += oprot->writeString(this->text);
    xfer += oprot->writeFieldEnd();
  }
  if (this->__isset.picture) {
    xfer += oprot->writeFieldBegin("picture", ::apache::thrift::protocol::T_STRING, 7);
    xfer += oprot->writeBinary(this->picture);
    xfer += oprot->writeFieldEnd();
  }
  if (this->__isset.animation) {
    xfer += oprot->writeFieldBegin("animation", ::apache::thrift::protocol::T_STRING, 8);
    xfer += oprot->writeBinary(this->animation);
    xfer += oprot->writeFieldEnd();
  }
  if (this->__isset.loc) {
    xfer += oprot->writeFieldBegin("loc", ::apache::thrift::protocol::T_STRUCT, 9);
    xfer += this->loc.write(oprot);
    xfer += oprot->writeFieldEnd();
  }
  if (this->__isset.action) {
    xfer += oprot->writeFieldBegin("action", ::apache::thrift::protocol::T_STRING, 10);
    xfer += oprot->writeString(this->action);
    xfer += oprot->writeFieldEnd();
  }
  if (this->__isset.texId) {
    xfer += oprot->writeFieldBegin("texId", ::apache::thrift::protocol::T_STRING, 11);
    xfer += oprot->writeString(this->texId);
    xfer += oprot->writeFieldEnd();
  }
  xfer += oprot->writeFieldStop();
  xfer += oprot->writeStructEnd();
  return xfer;
}

void swap(Ship &a, Ship &b) {
  using ::std::swap;
  swap(a.userId, b.userId);
  swap(a.nickName, b.nickName);
  swap(a.shipType, b.shipType);
  swap(a.timeStamp, b.timeStamp);
  swap(a.shipId, b.shipId);
  swap(a.text, b.text);
  swap(a.picture, b.picture);
  swap(a.animation, b.animation);
  swap(a.loc, b.loc);
  swap(a.action, b.action);
  swap(a.texId, b.texId);
  swap(a.__isset, b.__isset);
}

Ship::Ship(const Ship& other5) {
  userId = other5.userId;
  nickName = other5.nickName;
  shipType = other5.shipType;
  timeStamp = other5.timeStamp;
  shipId = other5.shipId;
  text = other5.text;
  picture = other5.picture;
  animation = other5.animation;
  loc = other5.loc;
  action = other5.action;
  texId = other5.texId;
  __isset = other5.__isset;
}
Ship& Ship::operator=(const Ship& other6) {
  userId = other6.userId;
  nickName = other6.nickName;
  shipType = other6.shipType;
  timeStamp = other6.timeStamp;
  shipId = other6.shipId;
  text = other6.text;
  picture = other6.picture;
  animation = other6.animation;
  loc = other6.loc;
  action = other6.action;
  texId = other6.texId;
  __isset = other6.__isset;
  return *this;
}
void Ship::printTo(std::ostream& out) const {
  using ::apache::thrift::to_string;
  out << "Ship(";
  out << "userId=" << to_string(userId);
  out << ", " << "nickName=" << to_string(nickName);
  out << ", " << "shipType=" << to_string(shipType);
  out << ", " << "timeStamp=" << to_string(timeStamp);
  out << ", " << "shipId="; (__isset.shipId ? (out << to_string(shipId)) : (out << "<null>"));
  out << ", " << "text="; (__isset.text ? (out << to_string(text)) : (out << "<null>"));
  out << ", " << "picture="; (__isset.picture ? (out << to_string(picture)) : (out << "<null>"));
  out << ", " << "animation="; (__isset.animation ? (out << to_string(animation)) : (out << "<null>"));
  out << ", " << "loc="; (__isset.loc ? (out << to_string(loc)) : (out << "<null>"));
  out << ", " << "action="; (__isset.action ? (out << to_string(action)) : (out << "<null>"));
  out << ", " << "texId="; (__isset.texId ? (out << to_string(texId)) : (out << "<null>"));
  out << ")";
}

} // namespace
