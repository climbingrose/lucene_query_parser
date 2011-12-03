require "spec_helper"

describe LuceneQueryParser::Parser do
  let(:parser) { LuceneQueryParser::Parser.new }

  describe "#parse" do
    it "parses a term with special characters" do
      should parse("foo&").as({:term => "foo&"})
      should parse("foo!").as({:term => "foo!"})
      should parse("foo:").as({:term => "foo:"})
      should parse("foo&!").as({:term => "foo&!"})
      should parse("foo*").as({:term => "foo*"})
      should parse("foo-").as({:term => "foo-"})
      should parse("foo+").as({:term => "foo+"})
      should parse("foo?").as({:term => "foo?"})
      should parse("foo/").as({:term => "foo/"})
    end

    it "parses multiple terms with special characters" do
      should parse("foo& bar*").as([{:term => "foo&"}, {:term => "bar*"}])
    end

    it "parses phrase with special characters" do
      should parse("\"foo& bar*\"").as({:phrase => "foo& bar*"})
    end
  end

end

