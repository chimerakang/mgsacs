//
// Created by Chimera Kang on 16/06/21.
//

#include "../include/thrift_asio_server.hpp"
#include "../include/thrift_asio_connection_management_mixin.hpp"
/// gen by thrift
#include "../thrift/gen-cpp/talkServer.h"
#include "../thrift/gen-cpp/talkClient.h"
#include <thread> // for sleep

/**
* a chat-session holds the user name and a client
* */
struct session {
	session(const boost::shared_ptr<apache::thrift::protocol::TProtocol>& output_protocol)
		: client(output_protocol) {

	}

	std::string user_name;
	kiwi::talkClientClient client;
};


class talkServer_handler
	: public kiwi::talkServerIf
	, public betabugs::networking::thrift_asio_transport::event_handlers
	, public betabugs::networking::thrift_asio_connection_management_mixin<session> {

  public:
		virtual void getVersion() override {
			assert(current_client_);
			current_client_->client.on_getVersion( KIWI_VERSION );
		}

		virtual void setUserName(const std::string& name) override {
			for (auto& p : clients_) {
				if (p.second->user_name == name) {
					p.second->client.on_setUserName_failed("username already taken");
					return;
				}
			}

			assert(current_client_);
			current_client_->user_name = name;
			current_client_->client.on_setUserName_succeeded();
		}

		virtual void subscribe(const std::string& topic) override {
			assert(current_client_);

			current_client_->on_subscribe_succeeded(123);

		}

		virtual void unsubscribe(const std::string& topic) override {
			assert(current_client_);

			current_client_->on_unsubscribe_succeeded();

		}


		virtual void postShip(const std::string& channel, const Ship& ship) override {
			assert(current_client_);
			for (auto& s : clients_) {
				if (s.second != current_client_) {
					s.second->client.on_subscribeShip( current_client_->user_name , ship );
				}
			}
		}
};


/// This is the simple version that blocks.
void the_blocking_version(boost::asio::io_service& io_service)
{
	io_service.run();
}


/*! this is why we went through all this efford. You're in control of the event lopp. huray!!!
 * this version is more suitable for realtime applications
 * */
void the_non_blocking_loop(boost::asio::io_service& io_service)
{
	while (true)
	{
		while (io_service.poll_one());

		// do some other work, e.g. sleep
		std::this_thread::sleep_for(std::chrono::milliseconds(100));
	}
}


int main(int argc, char* argv[])
{
	(void) argc;
	(void) argv;

	auto handler = boost::make_shared<chat_server_handler>();
	auto processor = example::chat::chat_serverProcessor
		(
			handler
		);

	betabugs::networking::thrift_asio_server<chat_server_handler> server;

	boost::asio::io_service io_service;
	boost::asio::io_service::work work(io_service);

	server.serve(io_service, processor, handler, 19999);

	///the_blocking_version(io_service);

	/// this version is more suitable for realtime applications
	the_non_blocking_loop(io_service);

	return 0;
}
