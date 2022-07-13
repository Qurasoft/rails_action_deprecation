require "spec_helper"

RSpec.describe CleanController, type: :controller do
  describe "no deprecation headers" do
    [
      { name: :index, http_method: :get, params: {} },
      { name: :create, http_method: :post, params: {} },
      { name: :show, http_method: :get, params: { id: 123 } },
      { name: :update, http_method: :patch, params: { id: 123 } },
      { name: :destroy, http_method: :delete, params: { id: 123 } },
    ].each do |test_case|

      context "when calling #{test_case[:name]}" do
        subject { send_request(test_case[:http_method], test_case[:name], test_case[:params]) }

        it 'will not have a Sunset HTTP Header' do
          expect(subject.headers).not_to include 'Sunset'
        end

        it 'will not have a Deprecation HTTP Header' do
          expect(subject.headers).not_to include 'Deprecation'
        end
      end

    end
  end
end
