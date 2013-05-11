class ServiceController < ApplicationController

  def cn_load
  	require 'net/http'
    response = Net::HTTP.get(URI.parse('http://api.charitynavigator.org/api/v1/lists/?app_key=665026acda4a7072c426615f0c7eb705&app_id=47f2a4c2&format=json'))
    res = JSON.parse(response)
    res['objects'].each do |object|
    	if CnList.where(:listid=>object['listid']).count == 0
	    	@list = CnList.new(object)
	    	@list.save
	    end	
    end

    CnCharityList.delete_all
    CnList.where(:show=>true).each do |list|
    	list_id = list.listid
		url = 'http://api.charitynavigator.org/api/v1/lists-orgs/?app_key=665026acda4a7072c426615f0c7eb705&app_id=47f2a4c2&format=json&listid='+list_id.to_s    	
		response = Net::HTTP.get(URI.parse(url))
	    res = JSON.parse(response)
	    res['objects'].each do |object|
		    	@listItem = CnCharityList.new(object)
		    	@listItem.save
	    end
    end	
  end

  def get_cn_lists
    @lists = CnList.where(:show=>true).order(:show_order)
    render :json => @lists,:callback => params[:callback]
  end

  def get_cn_list
    @list = CnCharityList.where(:listid=>params[:listid]).order(:rank)
    render :json => @list,:callback => params[:callback]
  end

 
end
