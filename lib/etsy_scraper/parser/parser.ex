defmodule EtsyScraper.Parser do
  def extract_page_info(html) do
    %{
      external_website_link: extract_external_website_link(html)
    }
  end

  def extract_external_website_link(html) do
    link_parts =
      Floki.find(html, "[data-outside-link='shop-website']")
      |> hd

    # link_parts look like this:
    # {"a",
    # [
    #   {"data-outside-link", "shop-website"},
    #   {"href", "http://www.woodallgoodshop.com"},
    #   {"class", "  text-decoration-none  clearfix"},
    #   {"title", "Website"},
    #   {"target", "_blank"},
    #   {"rel", "nofollow noopener"}
    # ],
    # [
    #   {"span", [{"class", "etsy-icon"}],
    # ...

    {_, attrs, _} = link_parts

    href_attr =
      Enum.find(attrs, fn attr ->
        case attr do
          {"href", _} ->
            attr

          _ ->
            nil
        end
      end)

    {"href", link_url} = href_attr
    link_url
  end
end
