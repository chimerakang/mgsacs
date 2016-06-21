// This autogenerated skeleton file illustrates how to build a server.
// You should copy it to another filename to avoid overwriting it.

#include "talkClient.h"
#include <thrift/protocol/TBinaryProtocol.h>
#include <thrift/server/TSimpleServer.h>
#include <thrift/transport/TServerSocket.h>
#include <thrift/transport/TBufferTransports.h>

using namespace ::apache::thrift;
using namespace ::apache::thrift::protocol;
using namespace ::apache::thrift::transport;
using namespace ::apache::thrift::server;

using boost::shared_ptr;

using namespace  ::kiwi;

class talkClientHandler : virtual public talkClientIf {
 public:
  talkClientHandler() {
    // Your initialization goes here
  }

  /**
   * get the version of server
   * 
   * @param version
   */
  void on_getVersion(const std::string& version) {
    // Your implementation goes here
    printf("on_getVersion\n");
  }

  void on_getVersion_failed(const std::string& why) {
    // Your implementation goes here
    printf("on_getVersion_failed\n");
  }

  /**
   * set user name api
   * 
   * @param userId
   */
  void on_setUserName_succeeded(const int64_t userId) {
    // Your implementation goes here
    printf("on_setUserName_succeeded\n");
  }

  void on_setUserName_failed(const std::string& why) {
    // Your implementation goes here
    printf("on_setUserName_failed\n");
  }

  /**
   * subscribe topic api
   * 
   * @param topicId
   */
  void on_subscribe(const int64_t topicId) {
    // Your implementation goes here
    printf("on_subscribe\n");
  }

  void on_subscribe_failed(const std::string& why) {
    // Your implementation goes here
    printf("on_subscribe_failed\n");
  }

  /**
   * unsubscribe topic api
   */
  void on_unsubscribe_succeeded() {
    // Your implementation goes here
    printf("on_unsubscribe_succeeded\n");
  }

  void on_unsubscribe_failed(const std::string& why) {
    // Your implementation goes here
    printf("on_unsubscribe_failed\n");
  }

  /**
   * ship api
   * 
   * @param name
   * @param ship
   */
  void on_subscribeShip(const std::string& name, const Ship& ship) {
    // Your implementation goes here
    printf("on_subscribeShip\n");
  }

  void on_subscribeShip_failed(const RequestException& exp) {
    // Your implementation goes here
    printf("on_subscribeShip_failed\n");
  }

};

int main(int argc, char **argv) {
  int port = 9090;
  shared_ptr<talkClientHandler> handler(new talkClientHandler());
  shared_ptr<TProcessor> processor(new talkClientProcessor(handler));
  shared_ptr<TServerTransport> serverTransport(new TServerSocket(port));
  shared_ptr<TTransportFactory> transportFactory(new TBufferedTransportFactory());
  shared_ptr<TProtocolFactory> protocolFactory(new TBinaryProtocolFactory());

  TSimpleServer server(processor, serverTransport, transportFactory, protocolFactory);
  server.serve();
  return 0;
}

