require_relative '../../test_helper'

describe Dweet::Thing do
    before do
        @thing_with_no_name = Dweet::Thing.new
        @dweet = Dweet::Dweet.new
        @dweet.content = { foo: :bar }
        @specific_thing = Dweet::Thing.new("my_thing")
    end

    describe "when ask to publish a dweet" do
        it "should return a valid dweet" do
            @thing_with_no_name.publish(@dweet).must_be_instance_of(Dweet::Dweet)
        end
    end

    describe "when ask to publish a dweet for my thing" do
        it "should return a dweet associate with my thing" do
            assert_equal @specific_thing.publish(@dweet).thing, "my_thing"
        end
    end

    describe "when ask to publish a dummy Hash" do
        it "should return a published dweet with dummy Hash as content" do
            h = { "foo" => "bar", "hello" => "world" }
            d1 = @specific_thing.publish h
            assert_equal d1.content, h
            d2 = @specific_thing.publish foo: :bar, hello: :world
            assert_equal d2.content, h
        end
    end

    describe "when ask to retrieve last dweet" do
        it "should return the last published dweet" do
            dweet = @specific_thing.publish(@dweet)
            assert_equal @specific_thing.last, dweet
        end
    end
end
