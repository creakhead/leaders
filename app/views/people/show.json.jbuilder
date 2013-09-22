
  json.extract! person, :id, :name, :image
  json.url person_url(person, format: :json)
