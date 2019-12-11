defmodule EtsyScraper.Parser do
  def extract_page_info(html) do
    %{
      external_website_link: extract_external_website_link(html)
    }
  end

  def extract_external_website_link(html) do
    Floki.find(html, "[data-outside-link='shop-website']")
    |> Floki.attribute("href")
    |> hd
  end
end
