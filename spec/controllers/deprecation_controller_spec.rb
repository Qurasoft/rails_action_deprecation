require "spec_helper"

RSpec.describe DeprecationController, type: :controller do
  describe "with deprecation headers" do
    let(:sunset_http_date) {"Fri, 01 Jul 2022 12:34:56 GMT"}

    [
      { name: :index, http_method: :get, params: {} },
      { name: :create, http_method: :post, params: {} },
      { name: :show, http_method: :get, params: { id: 123 } },
      { name: :update, http_method: :patch, params: { id: 123 } },
      { name: :destroy, http_method: :delete, params: { id: 123 } },
    ].each do |test_case|

      context "when calling #{test_case[:name]}" do
        subject { send_request(test_case[:http_method], test_case[:name], test_case[:params]) }

        it 'will have a Deprecation HTTP Header' do
          expect(subject.headers).to include 'Deprecation'
        end

        it 'will contain an IMF-fixdate in the Deprecation HTTP Header' do
          expect(subject.headers['Deprecation']).to eql sunset_http_date
        end
      end

    end
  end
end
