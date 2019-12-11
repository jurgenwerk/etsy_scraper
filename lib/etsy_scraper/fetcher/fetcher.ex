defmodule EtsyScraper.Fetcher do
  def fetch_content(shop_url) do
    HTTPoison.get(shop_url)
  end

  def extract_body(shop_url) do
    {:ok, response} = fetch_content(shop_url)
    response.body
  end
end
