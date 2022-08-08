require "spec_helper"

RSpec.describe MixedController, type: :controller do
  describe "with mixed deprecation and sunset headers" do
    let(:sunset_http_date) {"Fri, 01 Jul 2022 12:34:56 GMT"}
    let(:deprecation_http_date) {"Sat, 02 Jul 2022 12:34:56 GMT"}

    [
      { name: :index, http_method: :get, params: {} }
    ].each do |test_case|

      context "when calling #{test_case[:name]}" do
        subject { send_request(test_case[:http_method], test_case[:name], test_case[:params]) }

        it 'will not have a Sunset HTTP Header' do
          expect(subject.headers).not_to include 'Sunset'
        end

        it 'will have a Deprecation HTTP Header' do
          expect(subject.headers).to include 'Deprecation'
        end

        it 'will not have a Link HTTP Header' do
          expect(subject.headers).not_to include 'Link'
        end

        it 'will contain an IMF-fixdate in the Deprecation HTTP Header' do
          expect(subject.headers['Deprecation']).to eql deprecation_http_date
        end
      end

    end

    [
      { name: :show, http_method: :get, params: { id: 123 } },
      { name: :update, http_method: :patch, params: { id: 123 } },
    ].each do |test_case|

      context "when calling #{test_case[:name]}" do
        subject { send_request(test_case[:http_method], test_case[:name], test_case[:params]) }

        it 'will have a Sunset HTTP Header' do
          expect(subject.headers).to include 'Sunset'
        end

        it 'will have a Deprecation HTTP Header' do
          expect(subject.headers).to include 'Deprecation'
        end

        it 'will not have a Link HTTP Header' do
          expect(subject.headers).not_to include 'Link'
        end

        it 'will contain an IMF-fixdate in the Deprecation HTTP Header' do
          expect(subject.headers['Deprecation']).to eql deprecation_http_date
        end
      end

    end

    [
      { name: :destroy, http_method: :delete, params: { id: 123 } },
    ].each do |test_case|

      context "when calling #{test_case[:name]}" do
        subject { send_request(test_case[:http_method], test_case[:name], test_case[:params]) }

        it 'will have a Sunset HTTP Header' do
          expect(subject.headers).to include 'Sunset'
        end

        it 'will not have a Deprecation HTTP Header' do
          expect(subject.headers).not_to include 'Deprecation'
        end

        it 'will not have a Link HTTP Header' do
          expect(subject.headers).not_to include 'Link'
        end

        it 'will contain an IMF-fixdate in the Sunset HTTP Header' do
          expect(subject.headers['Sunset']).to eql sunset_http_date
        end
      end

    end

    [
      { name: :create, http_method: :post, params: {} },
    ].each do |test_case|

      context "when calling #{test_case[:name]}" do
        subject { send_request(test_case[:http_method], test_case[:name], test_case[:params]) }

        it 'will not have a Sunset HTTP Header' do
          expect(subject.headers).not_to include 'Sunset'
        end

        it 'will not have a Deprecation HTTP Header' do
          expect(subject.headers).not_to include 'Deprecation'
        end

        it 'will not have a Link HTTP Header' do
          expect(subject.headers).not_to include 'Link'
        end
      end

    end
  end
end
