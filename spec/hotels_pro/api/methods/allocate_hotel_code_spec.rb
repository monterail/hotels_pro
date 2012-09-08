require 'spec_helper'

describe HotelsPro::Api::Methods::AllocateHotelCode do
  include RequestHelper

  it "should build correct api params hash" do
    method = HotelsPro::Api::Methods::AllocateHotelCode.new(
      :search_id => "VO-40164625",
      :hotel_code => "US6X5G"
    )

    method.to_api_params.should == {
      "searchId" => "VO-40164625",
      "hotelCode" => "US6X5G"
    }
  end

  it "should build correct result from hash" do
    hash = {
      "responseId" => 5752179,
      "hotelCode" => "US6X5G",
      "availableHotels" => [{
        "processId" => "HF-56017745",
        "hotelCode" => "US6X5G",
        "availabilityStatus" => "InstantConfirmation",
        "totalPrice" => 335,
        "totalTax" => 0,
        "totalSalePrice" => 0,
        "currency" => "USD",
        "boardType" => "Continental Breakfast",
        "rooms" => [{
          "roomCategory" => "Double 1 Queen Bed",
          "paxes" => [
            {"paxType" => "Adult", "age" => 30}
          ],
          "totalRoomRate" => 335,
          "ratesPerNight" => [
            { "date" => "2012-09-09", "amount" => 112 },
            { "date" => "2012-09-10", "amount" => 112 },
            { "date" => "2012-09-11", "amount" => 111 }
          ]
        }]
      }],
      "totalFound" => 1,
      "searchId" => "VO-40164625"
    }

    result = HotelsPro::Api::Methods::AllocateHotelCode::Result.new(
      :response_id => 5752179,
      :hotel_code => "US6X5G",
      :available_hotels => [HotelsPro::Api::Elements::Hotel.new(
        :process_id => "HF-56017745",
        :hotel_code => "US6X5G",
        :availability_status => "InstantConfirmation",
        :total_price => 335,
        :total_tax => 0,
        :total_sale_price => 0,
        :currency => "USD",
        :board_type => "Continental Breakfast",
        :rooms => [HotelsPro::Api::Elements::RoomResponse.new(
          :room_category => "Double 1 Queen Bed",
          :paxes => [
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :age => 30)
          ],
          :total_room_rate => 335,
          :rates_per_night => [
            HotelsPro::Api::Elements::DailyRate.new(:date => Date.parse("2012-09-09", :amount => 112)),
            HotelsPro::Api::Elements::DailyRate.new(:date => Date.parse("2012-09-10", :amount => 112)),
            HotelsPro::Api::Elements::DailyRate.new(:date => Date.parse("2012-09-11", :amount => 111))
          ]
        )],
        :total_found => 1,
        :search_id => "VO-40164625",
      )]
    )
  end

  it "should return result when performed" do
    HotelsPro::Stubs.allocate_hotel_code.response(fixture("allocate_hotel_code"))

    method = HotelsPro::Api::Methods::AllocateHotelCode.new(
      :search_id => "VO-40164625",
      :hotel_code => "US6X5G"
    )

    result = method.perform

    result.should be_instance_of HotelsPro::Api::Methods::AllocateHotelCode::Result
    result.response_id.should == 5752179
    result.total_found.should == 2
    result.search_id.should == "VO-40164625"
    result.hotel_code.should == "US6X5G"
  end
end
