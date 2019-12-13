defmodule EtsyScraper.Parser do
  def extract_page_info(html) do
    %{
      email: extract_email(html),
      external_website_link: extract_external_website_link(html)
    }
  end

  # Some shops have their external website listed (e.g. Shopify)
  def extract_external_website_link(html) do
    Floki.find(html, "[data-outside-link='shop-website']")
    |> Floki.attribute("href")
    |> List.first()
  end

  # Some shops have email in their About section
  def extract_email(html) do
    regex = ~r/([a-zA-Z0-9+._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)/

    Regex.scan(regex, html)
    |> Enum.uniq()
    |> List.flatten()
    |> List.first()
  end
end
