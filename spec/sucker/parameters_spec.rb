require 'spec_helper'

module Sucker
  describe Parameters do
    let(:parameters) do
      Parameters.new
    end

    context "when initialized" do
      it "sets `Service`" do
        parameters['Service'].should_not be_nil
      end

      it "sets `Version`" do
        parameters['Version'].should_not be_nil
      end

      it "set `Timestamp`" do
        parameters['Timestamp'].should_not be_nil
      end
    end

    describe "#normalize" do
      it "casts keys to string" do
        parameters[:Foo] = 0
        normalized = parameters.normalize

        normalized.should have_key "Foo"
        normalized.should_not have_key :foo
      end

      it "camelizes keys" do
        parameters["foo_bar"] = 0
        normalized = parameters.normalize

        normalized.should have_key "FooBar"
        normalized.should_not have_key "foo_bar"
      end

      it "casts numeric values to string" do
        parameters["Foo"] = 1
        parameters.normalize["Foo"].should eql "1"
      end

      it "converts array values to string" do
        parameters["Foo"] = ['bar', 'baz']
        parameters.normalize["Foo"].should eql 'bar,baz'
      end
    end

    describe "#timestamp" do
      it "generates a timestamp" do
        parameters.send(:timestamp).should match /^\d+-\d+-\d+T\d+:\d+:\d+Z$/
      end
    end
  end
end
