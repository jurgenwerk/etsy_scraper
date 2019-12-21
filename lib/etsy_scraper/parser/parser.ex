defmodule EtsyScraper.Parser do
  def extract_page_info(html) do
    %{
      email: extract_email(html),
      external_website_link: extract_external_website_link(html),
      sales_count: extract_sales_count(html),
      shop_name: extract_shop_name(html),
      review_count: extract_review_count(html),
      location: extract_location(html),
      description: extract_description(html)
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

  def extract_sales_count(html) do
    sales_text =
      Floki.find(html, ".shop-sales")
      |> Floki.text()

    case Integer.parse(sales_text) do
      {sales_count, _} -> sales_count
      :error -> nil
    end
  end

  def extract_shop_name(html) do
    Floki.find(html, ".shop-name-and-title-container h1")
    |> Floki.text()
  end

  def extract_review_count(html) do
    ratings_text =
      Floki.find(html, ".reviews-wrapper .total-rating-count")
      |> Floki.text()
      |> String.trim()

    ratings_numbers_text =
      Regex.scan(~r/[0-9]+/, ratings_text)
      |> List.flatten()
      |> List.first()

    # ratings_numbers_text will be nil if rating count is not present
    case Integer.parse(ratings_numbers_text || "") do
      {ratings_count, _} -> ratings_count
      :error -> nil
    end
  end

  def extract_description(html) do
    Floki.find(html, ".shop-title [data-key='headline']")
    |> Floki.text()
    |> String.trim()
  end

  def extract_location(html) do
    Floki.find(html, "[data-key='user_location']")
    |> Floki.text()
  end
end
