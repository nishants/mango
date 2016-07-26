require './src/mango/contract'
require 'rspec'

RSpec.describe Mango::Contract do

  describe "Contract Default Names" do

    it "should convert relative path to unique contract name" do
      expected = {"home.json" => "home", "companies/all.json" => "companies-all"}
      expected.keys.each{|path|
        expect(Mango::Contract.path_to_url path).to eq(expected[path])
      }
    end

  end

end