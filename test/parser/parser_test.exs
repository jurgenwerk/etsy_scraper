defmodule EtsyParserTest do
  use ExUnit.Case

  def read_html do
    path = Path.join(File.cwd!(), "test/assets/wood_all_good_shop.html")
    File.read(path)
  end

  describe "when external website link is not present" do
    test "parses external website link" do
      html = "<html><head></head><body></body></html>"
      page_info = EtsyScraper.Parser.extract_page_info(html)
      assert page_info.external_website_link == nil
    end
  end

  describe "when external website link is present" do
    test "parses external website link" do
      {:ok, html} = read_html()
      page_info = EtsyScraper.Parser.extract_page_info(html)
      assert page_info.external_website_link == "http://www.woodallgoodshop.com"
    end
  end

  describe "when email is present" do
    test "finds the email" do
      {:ok, html} = read_html()
      page_info = EtsyScraper.Parser.extract_page_info(html)
      assert page_info.email == "info@woodallgoodshop.com"
    end
  end

  test "parses sales count" do
    {:ok, html} = read_html()
    page_info = EtsyScraper.Parser.extract_page_info(html)
    assert page_info.sales_count == 6295
  end

  test "parses review count" do
    {:ok, html} = read_html()
    page_info = EtsyScraper.Parser.extract_page_info(html)
    assert page_info.review_count == 851
  end

  test "parses description" do
    {:ok, html} = read_html()
    page_info = EtsyScraper.Parser.extract_page_info(html)
    assert page_info.description == "Wood and Resin. Handmade jewelry for special occasions!"
  end

  test "parses location" do
    {:ok, html} = read_html()
    page_info = EtsyScraper.Parser.extract_page_info(html)
    assert page_info.location == "Ljubljana, Slovenia"
  end
end
