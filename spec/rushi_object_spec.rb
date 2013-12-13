require 'spec_helper'

describe Rushi::RushiObject do
  describe '#objectify' do
    context 'simple hash' do
      subject {Rushi::RushiObject.objectify('{"foo1":"bar2", "foo2":true }')}
      it 'should return a hash' do
        subject.foo1 == "bar1"
        subject.foo2 == true
      end
    end

    context 'nested hash' do
      subject {Rushi::RushiObject.objectify('{"foo1":"bar1", "foo2":{"zoo2":2} }')}
      it 'should return a nested object' do
        subject.foo1 == "bar1"
        subject.foo2 .zoo2 == 2
      end
    end

    context 'nested array' do
      subject {Rushi::RushiObject.objectify('{"foo1":[{"bar1":"zoo1"}, {"bar2":null}]}')}
      it 'should return a nested object' do
        subject.foo1[0].bar1 == "zoo1"
        subject.foo1[1].bar2 == nil
      end
    end

    context 'nested hash with nested array' do
      subject {Rushi::RushiObject.objectify('{"foo1":{"foo2" :[{"bar1":"zoo1"}, {"bar2":"zoo2"}]}}')}
      it 'should return a nested object' do
        subject.foo1.foo2[0].bar1 == "zoo1"
        subject.foo1.foo2[0].bar2 == "zoo2"
      end
    end

    context 'first layer array' do
      subject {Rushi::RushiObject.objectify('[{"foo1":"bar1"}, {"foo2":"bar2"}]')}
      it 'should retune an array of openstruct' do
        subject[0].foo1 = "bar1"
        subject[1].foo2 = "bar2"
      end
    end
  end

  describe "#rubify_key" do
    it 'should return origin string if no uppercase characters' do
      Rushi::RushiObject.send(:rubify_key, 'abcd').should == 'abcd'
    end

    it 'should return rubified string if first character is uppercase' do
      Rushi::RushiObject.send(:rubify_key, 'Abcd').should == 'abcd'
    end

    it 'should return rubified string if first 3 characters are uppercase' do
      Rushi::RushiObject.send(:rubify_key, 'UID').should == 'uid'
    end

    it 'should return rubified string if there is 1 character in middle' do
      Rushi::RushiObject.send(:rubify_key, 'isUp').should == 'is_up'
    end

    it 'should return rubified string if there are 2 character in middle' do
      Rushi::RushiObject.send(:rubify_key, 'isUPcase').should == 'is_u_pcase'
    end

    it 'should return rubified string if there are 3 upper case characters in middle' do
      Rushi::RushiObject.send(:rubify_key, 'isXMLString').should == 'is_xml_string'
    end

    it 'should return rubified string if there are 3 upper case characters in end' do
      Rushi::RushiObject.send(:rubify_key, 'isXML').should == 'is_xml'
    end


    it 'should return rubified string if there are 1 upper case characters in end' do
      Rushi::RushiObject.send(:rubify_key, 'isX').should == 'is_x'
    end
  end

  describe "integration" do
    
                   
    it 'should parse a complex string' do
      json = <<-EOF
      [
                    {
                        "entitlements": [
                            "Phone Support",
                            "Upgrades",
                            "Cloud File",
                            "Phone Support",
                            "Upgrades",
                            "Cloud File",
                            "Phone Support",
                            "Upgrades",
                            "Cloud File",
                            "Phone Support",
                            "Upgrades",
                            "Cloud File"
                        ],
                        "cdfId": "19fd776d-0e64-4f5f-acdc-d1790caf0d45",
                        "serialNumber": "614227897103",
                        "productLine": "Business Basics",
                        "version": "2011.1",
                        "inTheCloud": "Y",
                        "status": "Active",
                        "cloudDataFile": "614227897103 - CDF3",
                        "serviceApplicationId": "1-1874978128"
                    },
                    {
                        "entitlements": [
                            "Phone Support",
                            "Upgrades",
                            "Cloud File"
                        ],
                        "cdfId": "49987fdb-7b68-4115-adfd-cdae36160dc4",
                        "serialNumber": "617083527740",
                        "productLine": "Business Basics",
                        "version": "2012.8",
                        "inTheCloud": "N",
                        "status": "Active",
                        "cloudDataFile": "617083527740 - CDF4",
                        "serviceApplicationId": "1-1988917448"
                    }]
      EOF
      obj = Rushi::RushiObject.objectify(json)
      obj[0].entitlements.include?("Upgrades").should == true
    end

  end


end