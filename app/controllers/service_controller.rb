class ServiceController < ApplicationController
  include REXML

  def cn_load
  	require 'net/http'
    response = Net::HTTP.get(URI.parse('http://api.charitynavigator.org/api/v1/lists/?app_key=665026acda4a7072c426615f0c7eb705&app_id=47f2a4c2&format=json'))
    res = JSON.parse(response)
    res['objects'].each do |object|
    	if CnList.where(:listid=>object['listid']).count == 0
	    	list = CnList.new(object)
	    	list.save
	    end	
    end

    CnCharityList.delete_all
    CnList.where(:show=>true).each do |list|
    	list_id = list.listid
		url = 'http://api.charitynavigator.org/api/v1/lists-orgs/?app_key=665026acda4a7072c426615f0c7eb705&app_id=47f2a4c2&format=json&listid='+list_id.to_s    	
		response = Net::HTTP.get(URI.parse(url))
	    res = JSON.parse(response)
	    res['objects'].each do |object|
		    	listItem = CnCharityList.new(object)
          ein = listItem.ein
          ein = ein.insert(2, "-")
          url_desc = "http://www2.guidestar.org/PartnerReport.aspx?Partner=networkforgood&ein="+ein
          response = Net::HTTP.get(URI.parse(url_desc))
          listItem.description = response
		    	listItem.save
	    end
    end	
  end

  def get_cn_lists
    lists = CnList.where(:show=>true).order(:show_order)
    render :json => lists,:callback => params[:callback]
  end

  def get_cn_list
    list = CnCharityList.select("orgid,ein,charity_name,listid").where(:listid=>params[:listid]).order(:rank)
    render :json => list,:callback => params[:callback]
  end


def get_charity_cn
    res = CnCharityList.where(:orgid=>params[:orgid])
    render :json => res,:callback => params[:callback]
end
    #   token = current_user.oauth_token
    #   url = URI::escape("https://graph.facebook.com/search?q="+params[:text]+"&type=user&access_token="+token);    
    #   response = Net::HTTP.get(URI.parse(url))
    #   res = JSON.parse(response)
    #   render :json => res,:callback => params[:callback]

  def fb_search
    token = current_user.oauth_token
    res = current_user.facebook.search(params[:text],{:type=>"user"})
    render :json => res,:callback => params[:callback]
  end

  def payment
  
    require "net/http"
    require "uri"
    require "rexml/document"

    server = "http://usapisandbox.fgdev.net/"
    url = server+"donation/creditcard"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.request_uri)
    request['JG_APPLICATIONKEY']  = '7692fb3f-da80-49a4-bfe4-99f18b4dfc54'
    request['JG_SECURITYTOKEN'] = '4a194e2e-c55d-43af-8e14-23ced7adf168'
    form_data = {
    "ccNumber"=>params[:ccNumber],
    "ccType"=>params[:ccType],
    "ccExpDateYear"=>params[:ccExpDateYear],
    "ccExpDateMonth"=>params[:ccExpDateMonth],
    "ccCardValidationNum"=>params[:ccCardValidationNum],
    "billToTitle"=>"",
    "billToFirstName"=>params[:billToFirstName],
    "billToLastName"=>params[:billToLastName],
    "billToAddressLine1"=>params[:billToAddressLine1],
    "billToCity"=>params[:billToCity],
    "billToState"=>params[:billToState],
    "billToZip"=>params[:billToZip],
    "billToCountry"=>params[:billToCountry],
    "billToEmail"=>params[:billToEmail],
    "billToPhone"=>params[:billToPhone],
    "remoteAddr"=>params[:remoteAddr],
    "amount"=>params[:amount],
    "currencyCode"=>params[:currencyCode],
    "description"=>params[:description],
    "charityId"=>"b9d575da-2023-11e0-a279-4061860da51d"
    #"charityId"=>params[:charityId]
    }
request.set_form_data(form_data)


# request.set_form_data({
#   "ccNumber"=>"4457010000000009",
#   "ccType"=>"VI",
#   "ccExpDateYear"=>"14",
#   "ccExpDateMonth"=>"01",
#   "ccCardValidationNum"=>"123",
#   "billToTitle"=>"Mr",
#   "billToFirstName"=>"Bill",
#   "billToLastName"=>"Gates",
#   "billToAddressLine1"=>"1 Main St.",
#   "billToCity"=>"Burlington",
#   "billToState"=>"MA",
#   "billToZip"=>"00000",
#   "billToCountry"=>"US",
#   "billToEmail"=>"bovdurenko@gmail.com",
#   "billToPhone"=>"3805030777",
#   "remoteAddr"=>"8.8.8.8",
#   "amount"=>"1",
#   "currencyCode"=>"USD",
#   "description"=>"Donation via DH site",
#   "charityId"=>"b9d575da-2023-11e0-a279-4061860da51d"})

# ccNumber – Required. User’s credit card number.
# ccType – User’s credit card type.
# * “VI” ‐ Visa
# * “MC” ‐ MasterCard
# * “DI” ‐ Discover Card
# * “AX” – American Express
# ccExpDateYear – Required. The 4 digit year the card expires.
# ccExpDateMonth – Required. The 2 digit month the card expires.
# ccCardValidationNum – Required. Card security number. Valid values include the following:
# * “CVV2″ ‐ Visa. (three‐digit value)
# * “CVC2″ ‐ MasterCard. (three‐digit value)
# * “CID” ‐ American Express. (four‐digit value)
# billToTitle – The donor’s “title”, such as “Mr.”, “Mrs.”, “Dr.” etc. (Max length: 10)
# billToFirstName – Required. The customer’s first name. (Max length 100).
# billToMiddleName – The customer’s middle name. (Max length 100).
# billToLastName – Required. The customer’s last name. (Max length 100).
# billToAddressLine1 – Required. Address line 1 for customer bill to address. (Max length: 255)
# billToAddressLine2 – Address line 2 for customer bill to address. (Max length: 255)
# billToAddressLine3 – Address line 3 for customer bill to address. (Max length: 255)
# billToCity – Required. City value for customer bill to address. (Max length: 35)
# billToState – Required when billToCountry is US. State name for customer bill to address. In the US, the two character state code should be used. E.g., “FL”, “NY”, etc instead of “Florida” or “New York”. The full list of valid US state codes can be found here (Max length 30)
# billToZip – Required. Zip for customer bill to address. (Max length 20)
# billToCountry – Required. Two character Country code for customer bill to address. The country names corresponding to the abbreviations can be found in the ISO 3166-1 standard. Example: “US”. The full list of countries accepted by the donations API can be found here. (Max length: 3)
# billToEmail – Required. Email address that corresponds to the customer bill to address. (Max length: 100)
# billToPhone – Phone number that corresponds to the customer bill to address. (Max length: 20)
# billToPhone – Required. The end user’s IP address. This optional parameter is used to block common sources of fraud.
# amount – Required. The amount of currency units to be donated. This should be in decimal format. Example: “1.23″ (without quotes). The minimum value is “5.00″.
# currencyCode – The currency code for the currency that describes the number of units to withdraw from the donor’s account.
# * “USD”
# charityId – Required. A UUID identifier provided by FirstGiving which identifies the recipient of the donation.
# eventId – An identifier provided by FirstGiving which identifies the event associated with the donation. If donation does not relate to an event id, pass “” (zero length string).
# fundraiserId – A universally unique ID which identifies the user account that was responsible for the donation that was collected. This is almost always a different person than the donor.
# orderId – A universally unique ID genereated by the 3rd party which identifies the donation in their system.
# description – Required. A short textual description of the donation.
# reportDonationToTaxAuthority – Boolean (1|0) indicating whether or not this donation should be reported to the tax authority in the donor’s country. *Not applicable in the U.S.
# personalIdentificationNumber – The national id number assigned to the donor who wants the donation reported to the tax authority. If the customer does not want the donation reported, just pass a blank string here.  *Not applicable in the U.S.
# donationMessage – Message from donor to the charity.
# honorMemoryName – Name of individual or organization that the donation was made to honor.
# pledgeId - A user defined field that persists to the NPO report linking the transaction from your page to the FirstGiving System.
# campaignName – A free-text field that persists to the NPO report notifying the NPO of the user defined Campaign Name.  If the Campaign Name ranks within the top 5 campaigns during the pay cycle, the Campaign Name will also appear on the NPO check stub.

    #"q" => "My query", "per_page" => "50"})

    response = http.request(request)
      # if response.code == '400'
      #   result = Document.new(response.body)
      #   status = result.elements['firstGivingDonationApi/attributes']
      #   render :xml => status
      # else
      #   res = {:code => response.code, :body => response.body }
      #   render :json => res
      # end
    begin 
      result = Document.new(response.body)
      status = result.elements['firstGivingDonationApi/firstGivingResponse'].attributes['acknowledgement']
      if status == "Success"
        transactionId = result.elements['firstGivingDonationApi/firstGivingResponse/transactionId'].text
        res = {:status => status, :transactionId => transactionId}
        render :json => res
      elsif  status == "Failed"
        errorText = result.elements['firstGivingDonationApi/firstGivingResponse'].attributes['friendlyErrorMessage']
        errorTarget = result.elements['firstGivingDonationApi/firstGivingResponse'].attributes['errorTarget']

        res = {:status => status, :error => {:errortext => errorText, :errorfield=>errorTarget,:body =>response.body,:formdata=>form_data}}
        render :json => res
      end
        
     rescue
       res = {:body=>response.body}
       render :json => res
     end
   end
 end 
