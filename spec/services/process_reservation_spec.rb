require 'rails_helper'

describe ProcessReservation do
  let(:flat_payload) do 
    {
      "reservation_code": "YYY12345678",
      "start_date": "2021-04-14",
      "end_date": "2021-04-18",
      "nights": 4,
      "guests": 4,
      "adults": 2,
      "children": 2,
      "infants": 0,
      "status": "accepted",
      "guest": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "wayne_woodbridge@bnb.com"
      },
      "currency": "AUD",
      "payout_price": "4200.00",
      "security_price": "500",
      "total_price": "4700.00"
    }
  end

  let(:embedded_payload) do 
    {
      "reservation": {
        "code": "XXX12345678",
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
          "localized_description": "4 guests",
          "number_of_adults": 2,
          "number_of_children": 2,
          "number_of_infants": 0
        },
        "guest_email": "woodbridge.wayne@bnb.com",
        "guest_first_name": "Wayne",
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
          "639123456789",
          "639123456789"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4300.00"
      }
    }
  end

  context 'new guest and new reservation' do
    context 'flat payload' do
      it 'creates guest record' do
        result = described_class.new.call(flat_payload)
        guest = Guest.where(email: "wayne_woodbridge@bnb.com").first

        expect(result).to be_success
        expect(guest).to_not be_nil
      end

      it 'creates reservation record' do
        result = described_class.new.call(flat_payload)
        guest_id = Guest.where(email: "wayne_woodbridge@bnb.com").pluck(:id).first
        reservation = Reservation.where(code: "YYY12345678").first

        expect(result).to be_success
        expect(reservation).to_not be_nil
        expect(reservation.guest_id).to eq(guest_id)
      end
    end

    context 'embedded payload' do
      it 'creates guest record' do
        result = described_class.new.call(embedded_payload)
        guest = Guest.where(email: "woodbridge.wayne@bnb.com").first

        expect(result).to be_success
        expect(guest).to_not be_nil
      end

      it 'creates reservation record with guest' do
        result = described_class.new.call(embedded_payload)
        guest_id = Guest.where(email: "woodbridge.wayne@bnb.com").pluck(:id).first
        reservation = Reservation.where(code: "XXX12345678").first

        expect(result).to be_success
        expect(reservation).to_not be_nil
        expect(reservation.guest_id).to eq(guest_id)
      end
    end
  end

  context 'existing guest and new reservation' do
    context 'flat payload' do
      before do
        Guest.create(
          email: "wayne_woodbridge@bnb.com", 
          first_name: "First", 
          last_name: "Last", 
          phone: "123456"
        )
      end

      it 'updates guest record' do        
        result = described_class.new.call(flat_payload)
        guest = Guest.where(email: "wayne_woodbridge@bnb.com").first

        expect(result).to be_success
        expect(guest.phone).to eq("639123456789")
        expect(guest.first_name).to eq("Wayne")
        expect(guest.last_name).to eq("Woodbridge")
      end

      it 'creates reservation record with guest' do
        result = described_class.new.call(embedded_payload)
        guest_id = Guest.where(email: "woodbridge.wayne@bnb.com").pluck(:id).first
        reservation = Reservation.where(code: "XXX12345678").first

        expect(result).to be_success
        expect(reservation).to_not be_nil
        expect(reservation.guest_id).to eq(guest_id)
      end
    end
    
    context 'embedded payload' do
      before do
        Guest.create(
          email: "woodbridge.wayne@bnb.com", 
          first_name: "First", 
          last_name: "Last", 
          phone: "123455"
        )
      end

      it 'updates guest record' do
        result = described_class.new.call(embedded_payload)
        guest = Guest.where(email: "woodbridge.wayne@bnb.com").first

        expect(result).to be_success
        expect(guest.phone).to eq("639123456789, 639123456789")
        expect(guest.first_name).to eq("Wayne")
        expect(guest.last_name).to eq("Woodbridge")
      end

      it 'creates reservation record with guest' do
        result = described_class.new.call(embedded_payload)
        guest_id = Guest.where(email: "woodbridge.wayne@bnb.com").pluck(:id).first
        reservation = Reservation.where(code: "XXX12345678").first

        expect(result).to be_success
        expect(reservation).to_not be_nil
        expect(reservation.guest_id).to eq(guest_id)
      end
    end
  end

  context 'new guest and existing reservation' do
    context 'flat payload' do
      before do
        Reservation.create(
          code: "YYY12345678", 
          start_date: "2021-04-14 00:00:00.000000000 +0000", 
          end_date: "2021-04-18 00:00:00.000000000 +0000", 
          number_of_nights: 0, 
          number_of_guests: 0, 
          number_of_adults: 0, 
          number_of_children: 0, 
          number_of_infants: 0, 
          status: "pending", 
          currency: "PHP", 
          payout_price: 0, 
          security_price: 0, 
          total_price: 0, 
          notes: "", 
          guest_id: 99999
        )
      end

      it 'updates reservation' do
        result = described_class.new.call(flat_payload)
        guest_id = Guest.where(email: "wayne_woodbridge@bnb.com").pluck(:id).first
        reservation = Reservation.where(code: "YYY12345678").first

        expect(result).to be_success
        expect(reservation).to_not be_nil
        expect(reservation.guest_id).to eq(guest_id)
        expect(reservation.start_date).to eq("2021-04-14 00:00:00.000000000 +0000")
        expect(reservation.end_date).to eq("2021-04-18 00:00:00.000000000 +0000")
        expect(reservation.number_of_nights).to eq(4)
        expect(reservation.number_of_guests).to eq(4)
        expect(reservation.number_of_adults).to eq(2)
        expect(reservation.number_of_children).to eq(2)
        expect(reservation.number_of_infants).to eq(0)
        expect(reservation.status).to eq("accepted" )
        expect(reservation.currency).to eq("AUD")
        expect(reservation.payout_price).to eq(0.42e4)
        expect(reservation.security_price).to eq(0.5e3)
        expect(reservation.total_price).to eq(0.47e4)
      end
    end
    
    context 'embedded payload' do
      before do
        Reservation.create(
          code: "XXX12345678", 
          start_date: "2021-04-14 00:00:00.000000000 +0000", 
          end_date: "2021-04-18 00:00:00.000000000 +0000", 
          number_of_nights: 4, 
          number_of_guests: 4, 
          number_of_adults: 2, 
          number_of_children: 2, 
          number_of_infants: 0, 
          status: "accepted", 
          currency: "AUD", 
          payout_price: 0.42e4, 
          security_price: 0.5e3, 
          total_price: 0.47e4, 
          notes: "", 
          guest_id: 99999
        )
      end

      it 'updates reservation' do
        result = described_class.new.call(embedded_payload)
        guest_id = Guest.where(email: "woodbridge.wayne@bnb.com").pluck(:id).first
        reservation = Reservation.where(code: "XXX12345678").first        

        expect(result).to be_success
        expect(reservation).to_not be_nil
        expect(reservation.guest_id).to eq(guest_id)
        expect(reservation.start_date).to eq("2021-03-12 00:00:00.000000000 +0000")
        expect(reservation.end_date).to eq("2021-03-16 00:00:00.000000000 +0000")
        expect(reservation.number_of_nights).to eq(4)
        expect(reservation.number_of_guests).to eq(0)
        expect(reservation.number_of_adults).to eq(2)
        expect(reservation.number_of_children).to eq(2)
        expect(reservation.number_of_infants).to eq(0)
        expect(reservation.status).to eq("accepted" )
        expect(reservation.currency).to eq("AUD")
        expect(reservation.payout_price).to eq(0.38e4)
        expect(reservation.security_price).to eq(0.5e3)
        expect(reservation.total_price).to eq(0.43e4)
        expect(reservation.notes).to eq("4 guests")
      end
    end
  end

  context 'existing guest and reservation' do
    context 'flat payload' do
      before do
        Guest.create(
          email: "wayne_woodbridge@bnb.com", 
          first_name: "First", 
          last_name: "Last", 
          phone: "123456"
        )

        Reservation.create(
          code: "YYY12345678", 
          start_date: "2021-04-14 00:00:00.000000000 +0000", 
          end_date: "2021-04-18 00:00:00.000000000 +0000", 
          number_of_nights: 0, 
          number_of_guests: 0, 
          number_of_adults: 0, 
          number_of_children: 0, 
          number_of_infants: 0, 
          status: "pending", 
          currency: "PHP", 
          payout_price: 0, 
          security_price: 0, 
          total_price: 0, 
          notes: "", 
          guest_id: 99999
        )
      end

      it 'updates guest record' do        
        result = described_class.new.call(flat_payload)
        guest = Guest.where(email: "wayne_woodbridge@bnb.com").first

        expect(result).to be_success
        expect(guest.phone).to eq("639123456789")
        expect(guest.first_name).to eq("Wayne")
        expect(guest.last_name).to eq("Woodbridge")
      end

      it 'updates reservation' do
        result = described_class.new.call(flat_payload)
        guest_id = Guest.where(email: "wayne_woodbridge@bnb.com").pluck(:id).first
        reservation = Reservation.where(code: "YYY12345678").first

        expect(result).to be_success
        expect(reservation).to_not be_nil
        expect(reservation.guest_id).to eq(guest_id)
        expect(reservation.start_date).to eq("2021-04-14 00:00:00.000000000 +0000")
        expect(reservation.end_date).to eq("2021-04-18 00:00:00.000000000 +0000")
        expect(reservation.number_of_nights).to eq(4)
        expect(reservation.number_of_guests).to eq(4)
        expect(reservation.number_of_adults).to eq(2)
        expect(reservation.number_of_children).to eq(2)
        expect(reservation.number_of_infants).to eq(0)
        expect(reservation.status).to eq("accepted" )
        expect(reservation.currency).to eq("AUD")
        expect(reservation.payout_price).to eq(0.42e4)
        expect(reservation.security_price).to eq(0.5e3)
        expect(reservation.total_price).to eq(0.47e4)
      end
    end

    context 'embedded payload' do
      before do 
        Guest.create(
          email: "woodbridge.wayne@bnb.com", 
          first_name: "First", 
          last_name: "Last", 
          phone: "123455"
        )

        Reservation.create(
          code: "XXX12345678", 
          start_date: "2021-04-14 00:00:00.000000000 +0000", 
          end_date: "2021-04-18 00:00:00.000000000 +0000", 
          number_of_nights: 4, 
          number_of_guests: 4, 
          number_of_adults: 2, 
          number_of_children: 2, 
          number_of_infants: 0, 
          status: "accepted", 
          currency: "AUD", 
          payout_price: 0.42e4, 
          security_price: 0.5e3, 
          total_price: 0.47e4, 
          notes: "", 
          guest_id: 99999
        )
      end

      it 'updates guest record' do
        result = described_class.new.call(embedded_payload)
        guest = Guest.where(email: "woodbridge.wayne@bnb.com").first

        expect(result).to be_success
        expect(guest.phone).to eq("639123456789, 639123456789")
        expect(guest.first_name).to eq("Wayne")
        expect(guest.last_name).to eq("Woodbridge")
      end

      it 'updates reservation' do
        result = described_class.new.call(embedded_payload)
        guest_id = Guest.where(email: "woodbridge.wayne@bnb.com").pluck(:id).first
        reservation = Reservation.where(code: "XXX12345678").first        

        expect(result).to be_success
        expect(reservation).to_not be_nil
        expect(reservation.guest_id).to eq(guest_id)
        expect(reservation.start_date).to eq("2021-03-12 00:00:00.000000000 +0000")
        expect(reservation.end_date).to eq("2021-03-16 00:00:00.000000000 +0000")
        expect(reservation.number_of_nights).to eq(4)
        expect(reservation.number_of_guests).to eq(0)
        expect(reservation.number_of_adults).to eq(2)
        expect(reservation.number_of_children).to eq(2)
        expect(reservation.number_of_infants).to eq(0)
        expect(reservation.status).to eq("accepted" )
        expect(reservation.currency).to eq("AUD")
        expect(reservation.payout_price).to eq(0.38e4)
        expect(reservation.security_price).to eq(0.5e3)
        expect(reservation.total_price).to eq(0.43e4)
        expect(reservation.notes).to eq("4 guests")
      end
    end
  end

  context 'invalid payloads' do

  end
end
