require 'rest_client'
require 'time'

class Person < ActiveRecord::Base
	has_many :personal_records, dependent: :destroy
	has_and_belongs_to_many :friends


	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    user.provider = auth.provider
	    #binding.pry 
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.oauth_token = auth.credentials.token
	    user.email = auth.info.email
	    user.first_name = auth.info.first_name
	    user.last_name = auth.info.last_name	
	    user.gender = auth.extra.raw_info.gender 
	    user.image = auth.info.image
	    user.oauth_expires = Time.at(auth.credentials.expires_at)
	    user.save!
		Person.findActiveResults(user)

	    #find a list of this users friends
	    @graph = Koala::Facebook::API.new(user.oauth_token)

	    #1377214703?fields=id,name,birthday,friends.fields(gender,birthday,first_name,last_name,picture,email,name)
	    @friends = @graph.get_connections("me", "friends?fields=id,name,gender,birthday,first_name,last_name,picture,email")
	    @friends.each do |i|
		   newFriend = Person.from_friend(i)
		   rel = Friend.find_by_person_id_and_friend_id(user.id, newFriend.id)
		   if(rel == nil) 
		   		rel = Friend.create(:person_id => user.id, :friend_id => newFriend.id)
		   		rel.save
		   end
 			Person.findActiveResults(newFriend)
 			#binding.pry
		end
	  end
	end

	def self.from_friend(friend)
		self.where(:uid => friend['id'], :name => friend['name']).first_or_create.tap do |user|
			user.uid = friend['id']
		    user.name = friend['name']
		    user.email = friend['email']
		    user.first_name = friend['first_name']
		    user.last_name = friend['last_name']
		    user.gender = friend['gender'] 
		    user.image = friend['picture']['data']['url']
		    user.save!
		end
	end

	def self.findActiveResults(user)

		#api/v1/events/{event_name}/sub_events/{sub_event_name}/participants/{participant_id}
		#http://results.active.com/api/v1/events/san-diego-international-triathlon/sub_events/international/participants/14572691
		#http://results.active.com/api/v1/search?query=Marc%20Villanueva/events/2005-montclair-10k-2-mile-run-walk/2-mile/marcus-villanueva

	  results = RestClient.get 'http://results.active.com/api/v1/search?query=' + Rack::Utils.escape(user['name'])
	  parsed_json = ActiveSupport::JSON.decode(results)
	  parsed_json['results'].each do |result|
	  	 #binding.pry
	  	if(result['full_name'] == user['name'])
	  		begin
		  		badUrl = result['url']
		  		@parts = badUrl.split('/')
		  		# binding.pry
		  		record_url = 'http://results.active.com/api/v1/events/' + @parts[7] + '/sub_events/' + @parts[8] + '/participants/' + @parts[9]	  		
		  		record_data = RestClient.get record_url
		  		record_data = ActiveSupport::JSON.decode(record_data)
		  		
		  		event_url = 'http://results.active.com/api/v1/events/' + @parts[7] 
		  		event_data = RestClient.get event_url
		  		event_data = ActiveSupport::JSON.decode(event_data)

		  		Person.saveRecord(user, record_data, event_data, @parts[8])
		  	rescue Exception => e
                  puts "Error: #{e}"
                  puts 'Bad RECORD URL: ' + record_url unless record_url.nil?
                  puts 'Bad EVENT URL: ' + event_url unless event_url.nil?
	  		end
	  		#binding.pry
	  	end
	  end
	  #puts parsed_json
	end

	#private 
		def self.saveRecord(user, record, event, subCategory)
			my_rec = PersonalRecord.find_by_record_id(record['id'])
			#binding.pry
		   if(my_rec == nil) 
		   		if(record['race_result']['finish_time'] != nil)
			   		@time = record['race_result']['finish_time'].split(':')
			   		
			   		my_time = Time.new(1978, 1, 19, 0, 0, 0, "-00:00")
			   		if(@time.size == 1)
			   			my_time = Time.new(1978, 1, 19, 0, 0, @time[0].to_i, "-00:00")
			   		elsif(@time.size == 2)
			   			my_time = Time.new(1978, 1, 19, 0, @time[0].to_i, @time[1].to_i, "-00:00")
			   		elsif( @time.size == 3)
						my_time = Time.new(1978, 1, 19, @time[0].to_i, @time[1].to_i, @time[2].to_i,"-00:00")
			   		end
			   		
			   		rel = PersonalRecord.create(
			   			:person_id => user['id'], 
			   			:record_id => record['id'],
			   			:event_type_id => 0, 
			   			:event_name => event['title'], 
			   			:result_time => my_time, 
			   			:url => record['url'], 
			   			:sub_cat => subCategory,
			   			:event_id => record['event_id'], 
			   			:sub_event_id => record['sub_event_id'],
			   			:pr => 0
			   			)
			   		rel.save
			   	end
		   end
		end
	#end

end
