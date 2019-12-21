defmodule EtsyScraper do
  alias EtsyScraper.Fetcher
  alias EtsyScraper.Parser

  def shop_data(url) do
    Fetcher.extract_body(url)
    |> Parser.extract_page_info()
  end
end
