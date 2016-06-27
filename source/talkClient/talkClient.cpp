//
// Created by Benjamin Schulz on 15/03/15.
//

#include <iostream>

#include "../include/thrift_asio_client.hpp"

/// gen by thrift
#include "../thrift/gen-cpp/talkServer.h"
#include "../thrift/gen-cpp/talkClient.h"
#include <boost/asio.hpp>
#include <thread>


class talkClient_handler : public betabugs::networking::thrift_asio_client<
	kiwi::talkServerClient,
	kiwi::talkClientProcessor,
	kiwi::talkClientIf
>
{
  public:
	using betabugs::networking::thrift_asio_client<
		kiwi::talkServerClient,
		kiwi::talkClientProcessor,
		kiwi::talkClientIf
	>::thrift_asio_client;

	talkClient_handler(
		boost::asio::io_service& io_service,
		const std::string& host_name,
		const std::string& service_name
	)
		: thrift_asio_client(io_service, host_name, service_name)
		, stdin_(io_service, ::dup(STDIN_FILENO))
		, input_buffer_(1024)
	{
	}

	virtual void on_getVersion(const std::string& version) override {
        std::cout << "server version: " << version << std::endl;

	}

	virtual void on_getVersion_failed(const std::string& why) override {
        std::cerr << "get version failed: " << why << std::endl;

	}

	virtual void on_setUserName_failed(const std::string& why) override {
		std::cerr << "setting user name failed: " << why << std::endl;
		read_username();
	}

    virtual void on_setUserName_succeeded(const std::string& userId) override {
        std::cout << "user name id: " << userId << std::endl;
	}

    virtual void on_subscribe(const std::string& topicId) override {
        std::cout << "user subscribe id: " << topicId << std::endl;

	}
    
    virtual void on_subscribe_failed(const std::string& why) override {
        std::cerr << "subscribe failed: " << why << std::endl;
        
    }

	/**
	 * unsubscribe topic api
	 */
	virtual void on_unsubscribe_succeeded() override {
        std::cout << "user on subscribe succeeded"  << std::endl;
	}

	virtual void on_unsubscribe_failed(const std::string& why) override {
        std::cerr << "unsubscribe failed: " << why << std::endl;

	}

	virtual void on_subscribeShip(const std::string& from_user, const kiwi::Ship& ship) override {
		std::cout << from_user << ":, ship :"<< ship.text  << std::endl;

	}

    virtual void on_subscribeShip_failed(const std::string& why) override {
		std::cerr << "subscribe ship failed: " << why << std::endl;

	}

	// called by the transport
	virtual void on_error(const boost::system::error_code& ec) override
	{
		std::clog << "!! error: " << ec.message() << std::endl;
		this->reconnect_in(boost::posix_time::seconds(1));
	}

	virtual void on_connected() override
	{
		std::clog << "!! connected" << std::endl;
		///read_username();
	}

	virtual void on_disconnected() override
	{
		std::clog << "!! disconnected" << std::endl;
	}
    
public:
    void get_version() {
        client_.getVersion();
    }
    
    void read_subscribe() {
        std::cout << "enter subscribe topic: " << std::endl;
        std::string topic = this->read_input();
        client_.subscribe(topic);

    }
    
    void read_unsubscribe() {
        std::cout << "enter unsubscribe topic: " << std::endl;
        
        std::string topic = this->read_input();
        client_.unsubscribe(topic);
        
    }

    void read_post_ship() {
        std::cout << "enter topic and ship, first which topic: " << std::endl;
        // Read a line of input entered by the user.
        
        std::string topic = this->read_input();

        std::cout << "second input ship: " << std::endl;
        
        std::string text = this->read_input();
        
        kiwi::Ship ship;
        ship.__set_text(text);
        ship.__set_shipType( kiwi::ShipType::TEXT );
        client_.postShip(topic, ship);
        
    }
    
    // read the username from stdin and send it to the server
    void read_username()
    {
        std::cout << "enter user name: " << std::endl;
        // Read a line of input entered by the user.
        boost::asio::async_read_until(stdin_, input_buffer_, '\n',
                                      [this](const boost::system::error_code& ec, std::size_t length)
                                      {
                                          if (!ec && length > 1)
                                          {
                                              std::string line;
                                              std::istream is(&input_buffer_);
                                              std::getline(is, line);
                                              
                                              if (!line.empty())
                                                  client_.setUserName(line);
                                              else
                                                  read_username();
                                          }
                                      }
                                      );
    }


  private:
	boost::asio::posix::stream_descriptor stdin_;
	boost::asio::streambuf input_buffer_;
    
    std::string read_input() {
        // Read a line of input entered by the user.
        boost::asio::async_read_until(stdin_, input_buffer_, '\n',
            [this](const boost::system::error_code& ec, std::size_t length) {
                if (!ec && length > 1) {
                    std::string line;
                    std::istream is(&input_buffer_);
                    std::getline(is, line);
                    
                    if (!line.empty()) {
                        return line;
                    }
                    else
                        read_input();
                }
            }
        );
        
    }


	void read_message()
	{
		std::cout << "broadcast message: " << std::endl;
		// Read a line of input entered by the user.
		boost::asio::async_read_until(stdin_, input_buffer_, '\n',
			[this](const boost::system::error_code& ec, std::size_t)
			{
				if (!ec)
				{
					std::string line;
					std::istream is(&input_buffer_);
					std::getline(is, line);

					if (!line.empty())
						///client_.broadcast_message(line);

					// start over
					read_message();
				}
			}
		);
	}
};

/* this is the blocking version of the event loop
*
* this unfortunately causes high cpu load because of
* a (suspected) bug in boost::asio::posix::stream_descriptor
* when used with kevent.
* */
void the_blocking_loop(boost::asio::io_service& io_service, talkClient_handler& handler)
{
	while (true)
	{
		boost::system::error_code ec;
		while (io_service.run_one(ec)) // run_one blocks until there is new data
		{
			if (ec) handler.on_error(ec);
			else handler.update();
		}
	}
}

void the_non_blocking_loop(boost::asio::io_service& io_service, talkClient_handler& handler)
{
	while (true)
	{
		boost::system::error_code ec;
		while (io_service.poll_one(ec))
		{
			if (ec) handler.on_error(ec);
            else {
                handler.update();
            
                int num;
                std::cout<<std::endl<<"Welcome to talk service :"<<std::endl;
                std::cout<<"**********************************"<<std::endl;
                std::cout<<"Enter one of the following options : "<<std::endl;
                std::cout<<"1. getVersion"<<std::endl;
                std::cout<<"2. subscribe"<<std::endl;
                std::cout<<"3. unsubscribe"<<std::endl;
                std::cout<<"4. postShip"<<std::endl;
                std::cout<<"5. Exit" << std::endl;
                std::cin>>num;
                
                switch(num){
                    case 1 :
                        handler.get_version();
                        break;
                        
                    case 2:
                        handler.read_subscribe();
                        break;
                        
                    case 3:
                        handler.read_unsubscribe();
                        break;
                        
                    case 4:
                        handler.read_post_ship();
                        break;
                        
                        
                    default:
                        ///std::cout<<"Invalid Selection";
                        handler.read_username();
                        break;
                }
            }
		}

		// do some other work. e.g. sleep
		std::this_thread::sleep_for(std::chrono::milliseconds(100));
	}
}


int main(int argc, char* argv[])
{
	(void) argc;
	(void) argv;

	std::string host_name = "127.0.0.1";
	std::string service_name = "19999";

	boost::asio::io_service io_service;
	boost::asio::io_service::work work(io_service);

	talkClient_handler handler(io_service, host_name, service_name);

	the_non_blocking_loop(io_service, handler);

	//the_blocking_loop(io_service, handler);

	return 0;
}
