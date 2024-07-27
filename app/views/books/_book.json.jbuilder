json.extract! book, :id, :Book_name, :Author, :Owner, :Contact, :Location, :Availability, :created_at, :updated_at
json.url book_url(book, format: :json)
