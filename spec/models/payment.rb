require 'rails_helper'

describe Payment, type: :model do
  describe 'Instance Methods' do
    describe '.tips' do
      it 'Returns an Hash of available system notes' do
        notice =
          "Checks should be made out to:
           <br />
           <strong>Church in Anaheim - YP</strong>
           <br />
           <br />
           <strong>2528 W. La Palma Ave.
           <br />Anaheim, CA 92801</strong>
           <br />
           and presented to the registration table when arriving at the conference."
          .squish
        expect(Payment.tips).to eq(check_payment_instructions: notice)
      end
    end
  end
end
