json.array!(@cat_search_results) do |category|
  json.extract! category, :id, :keyword
end
