//
// Created by Chimera Kang on 16/06/21.
//



#include "../include/thrift_asio_server.hpp"
#include "../include/thrift_asio_connection_management_mixin.hpp"
/// gen by thrift
#include "../thrift/gen-cpp/talkServer.h"
#include "../thrift/gen-cpp/talkClient.h"
#include "../thrift/gen-cpp/talker_types.h"
#include "../thrift/gen-cpp/talker_constants.h"
#include <thread> // for sleep
#include <vector>
#include <boost/uuid/uuid.hpp>            // uuid class
#include <boost/uuid/uuid_generators.hpp> // generators
#include <boost/uuid/uuid_io.hpp>         // streaming operators etc.

/**
* a chat-session holds the user name and a client
* */
struct session {
	session(const boost::shared_ptr<apache::thrift::protocol::TProtocol>& output_protocol)
		: client(output_protocol) {

	}

    kiwi::User user;
	kiwi::talkClientClient client;
};


class talkServer_handler
	: public kiwi::talkServerIf
	, public betabugs::networking::thrift_asio_transport::event_handlers
	, public betabugs::networking::thrift_asio_connection_management_mixin<session> {

  public:
		virtual void getVersion() override {
			assert(current_client_);
            current_client_->client.on_getVersion( kiwi::g_talker_constants.KIWI_VERSION );
		}

		virtual void setUserName(const std::string& name) override {
			for (auto& p : clients_) {
				if (p.second->user.name == name) {
					p.second->client.on_setUserName_failed("username already taken");
					return;
				}
			}

			assert(current_client_);
            current_client_->user.__set_name(name);
            
            std::string id = this->genUserId();
            current_client_->user.__set_userId(id);
            current_client_->client.on_setUserName_succeeded( current_client_->user.userId );
            
            /// add to session map
            this->sessionMap[name] = &current_client_->client;
		}

		virtual void subscribe(const std::string& topic) override {
			assert(current_client_);
            
            
            std::map<std::string, kiwi::Subscriber>::iterator it = this->subscriberMap.find(topic);

            /// not found topic
            if (it == this->subscriberMap.end() ) {
                kiwi::Subscriber subscriber;
                
                std::string id = this->genUserId();
                subscriber.__set_topicId(id);
                subscriber.users.push_back( current_client_->user );
                this->subscriberMap[topic] = subscriber;
                current_client_->client.on_subscribe(id);
                
            } else {
                /// find subscriber
                bool found = false;
                std::vector<kiwi::User>::iterator user_iter;
                for( user_iter = it->second.users.begin(); user_iter != it->second.users.end(); user_iter++ ) {
                    if( user_iter->name == current_client_->user.name ) {
                        found = true;
                        break;
                    }
                }
                
                if( !found ) {
                    it->second.users.push_back( current_client_->user );
                    
                }
            }
		}

		virtual void unsubscribe(const std::string& topic) override {
			assert(current_client_);
            
            std::map<std::string, kiwi::Subscriber>::iterator it = this->subscriberMap.find(topic);
            
            if (it != this->subscriberMap.end() ) {
                
                for( int i=0; i<it->second.users.size(); i++ ) {
                    if( it->second.users[i].name == current_client_->user.name ) {
                        it->second.users.erase( it->second.users.begin()+i );
                        current_client_->client.on_unsubscribe_succeeded();
                        break;
                    }
                    
                }
            } else {
                /// not found topic
                current_client_->client.on_unsubscribe_failed("not found this topic");
            }



		}


        virtual void postShip(const std::string& topic, const kiwi::Ship& ship) override {
			assert(current_client_);
            
            std::map<std::string, kiwi::Subscriber>::iterator it = this->subscriberMap.find(topic);
            if (it != this->subscriberMap.end() ) {
                
                for( auto & user_iter : it->second.users ) {
                    
                    std::string user_name = user_iter.name;
                    std::map<std::string, kiwi::talkClientClient*>::iterator session_it;
                    session_it = this->sessionMap.find(user_name);
                    
                    /// found session and post ship to each subscriber
                    if( session_it != this->sessionMap.end() ) {
                        
                        if (session_it->second != &current_client_->client) {
                            session_it->second->on_subscribeShip( current_client_->user.name , ship );
                        }
                    }
                }
            }
		}
        
    private:
        std::string genUserId() {
            boost::uuids::uuid uuid = boost::uuids::random_generator()();
            
            std::string user_id = boost::lexical_cast<std::string>(uuid);
            return user_id;
        }
        
        kiwi::talkClientClient* getSession(std::string userName) {
            std::map<std::string, kiwi::talkClientClient*>::iterator it = this->sessionMap.find(userName);
            
            if( it != this->sessionMap.end() ) {
                return it->second;
            }
            
            return nullptr;

        }
        
    private:
        /// maps protocol instances to clients
        typedef std::map<std::string, kiwi::Subscriber> subscriber_map;
        typedef std::map<std::string, kiwi::talkClientClient*> session_map;
        
        subscriber_map subscriberMap;
        session_map sessionMap;
        
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

	auto handler = boost::make_shared<talkServer_handler>();
    auto processor = kiwi::talkServerProcessor
		(
			handler
		);

	betabugs::networking::thrift_asio_server<talkServer_handler> server;

	boost::asio::io_service io_service;
	boost::asio::io_service::work work(io_service);

	server.serve(io_service, processor, handler, 19999);

	///the_blocking_version(io_service);

	/// this version is more suitable for realtime applications
	the_non_blocking_loop(io_service);

	return 0;
}
