defmodule EtsyParserTest do
  use ExUnit.Case

  def read_html do
    path = Path.join(File.cwd!(), "test/assets/wood_all_good_shop.html")
    File.read(path)
  end

  test "parses external website link" do
    {:ok, html} = read_html()
    page_info = EtsyScraper.Parser.extract_page_info(html)
    assert page_info.external_website_link == "http://www.woodallgoodshop.com"
  end
end
