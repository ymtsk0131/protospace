json.array! @prototypes do |prototype|
  json.prototype_id prototype.id
  json.image prototype.captured_images.find_by("status = 0")[:content]
  json.title prototype.title
  json.user_id prototype.user.id
  json.user_name prototype.user.name
  json.posted_date prototype.posted_date
end
